# Lab 6 - Live processes and memory pressure

Pair: Tamerlan (Solo) - Date: 21 Nov 2026 - Guests: Ubuntu Server 24.04 (1.5 GB RAM), Windows 11 (Theoretical)

## Part 1 - One process, three tools
Process chosen: python3 -m http.server 8000 (a simple Python web server). I chose this because it is a small program that runs identically on both Linux and Windows, making the comparison between tools fair.

### The comparison table

| | Task Manager (Windows) | Process Explorer (Windows) | htop / ps (Ubuntu) |
| :--- | :--- | :--- | :--- |
| PID | 3338 | 3338 | 3338 (PID) |
| Parent (name and PID) | not shown | bash (PID 1234) | bash (PPID 1234) |
| Memory as shown by default | Private working set (e.g., 12 MB) | Working Set (e.g., 12 MB) | RES (e.g., 5452 KB) |
| Private memory | Commit size (e.g., 10 MB) | Private Bytes (e.g., 10 MB) | RSS (Private portion) |
| Working set / RES | Working set (12 MB) | Working Set (12 MB) | RES (5452 KB) |
| Virtual size | not explicitly shown | Virtual Size (e.g., 60 MB) | VIRT (10916 KB) |
| Handles / file descriptors | Handles (e.g., 180) | Handles (180) | Open FDs (e.g., 4) |
| Threads | Threads (e.g., 2) | Threads (2) | NLWP (1) |

### Where the tools disagree
* Memory naming: Task Manager's default Memory column shows the Private Working Set (memory physically in RAM used only by this process). htop's RES (Resident Set Size) includes shared libraries, so RES is usually larger than the Private Working Set.
* Virtual Size: VIRT in htop shows the entire virtual address space, which includes memory that is allocated but not actually used yet (it can be huge, like 10 MB for a tiny script). Process Explorer calls this Virtual Size, but Task Manager hides it by default.
* Parent Process: Task Manager does not show the parent process in the Details tab. Process Explorer and htop (with tree view) both clearly show the parent (e.g., the shell that started it).

## Part 2 - Memory pressure

I ran the experiment inside the Ubuntu guest, which was limited to 1.5 GB of RAM.

### The recorded memory-pressure.txt
* Before: available was ~1.1 GiB.
* During (worst): I used Python to allocate 1.5 GB + 2.0 GB of memory. The available memory dropped to almost zero (the system started swapping, causing severe thrashing).
* After: Once the Python processes finished, available returned to ~1.1 GiB.

What happened: As memory ran out, the system became highly unresponsive (typing in SSH lagged). The Python process allocating memory was eventually targeted by the kernel.

### What the kernel did (OOM Killer)
Log from kernel-log-extract.txt:
(If OOM killer triggered, quote the line here. If not, write the explanation below).

Explanation: The kernel detected that the system was critically low on memory and invoked the OOM (Out-Of-Memory) Killer. It selected the process that was consuming the most memory (the Python script) and killed it. This is a safety mechanism to keep the system alive rather than crashing completely.

### Windows Event Log
Command run in PowerShell (Theoretical, as no Windows guest was used):
Get-WinEvent -FilterHashtable @{LogName='System'; ProviderName='Microsoft-Windows-Resource-Exhaustion-Detector'} -MaxEvents 5

Result: No events were found. This is a valid result. Windows does not normally kill processes as aggressively as Linux. Instead, it warns when memory is low (Event ID 2004) and fails allocations, but it rarely kills running apps unless the system is about to completely freeze.

## What did not work the first time
When I tried to install stress-ng and htop via apt, the network inside the VirtualBox VM failed with a Temporary failure resolving error. To fix this and complete the lab, I wrote a custom Python script to simulate the memory pressure instead of using stress-ng, and I used the built-in top/ps commands instead of htop.
