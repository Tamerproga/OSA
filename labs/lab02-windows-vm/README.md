# Lab 2 — A Windows guest, and a network between them

Pair: Tamerlan (Solo)
Machine: MacBook Air (Apple M4, 10 cores, 16 GB Unified RAM), macOS 15.1 (Sequoia), UTM 4.6 (ARM64)
Guests: win11-arm (Windows 11 Enterprise Evaluation ARM64), ubuntu-server (Ubuntu Server 26.04.1 LTS)
Date: 23.11.2026

## What I did

### 1. Network Diagram
      [ Internet ]
           |
 [ macOS Host - Apple M4 ]
           |  UTM Shared Network (192.168.64.0/24)
           +-----------------------------+
           |                             |
  [ Windows 11 ARM ]          [ Ubuntu Server ARM ]
  192.168.64.5                192.168.64.6

### 2. Host check
Host facts were collected from the macOS terminal (system_profiler SPHardwareDataType).
The host has an Apple M4 chip (10 cores) and 16 GB of unified memory.

### 3. Windows 11 evaluation VM
Built from the Windows 11 Enterprise Evaluation ARM64 ISO (no licence key entered, 90-day evaluation).
Because the host is Apple Silicon, the x64 evaluation image provided in the course cannot run. I used the ARM64 version. I used UTM, which provides hardware-accelerated virtualization for ARM64 guests on macOS.

| VM | vCPU | RAM | Disk | Firmware |
|---|---|---|---|---|
| win11-arm | 4 | 4096 MB | 64 GB, dynamic | UEFI, TPM 2.0, Secure Boot |
| ubuntu-server | 2 | 2048 MB | 25 GB, dynamic | BIOS |

Why these numbers. The host has 10 cores and 16 GB of unified memory. With both guests off, macOS uses about 6 GB. I gave Windows 4 GB and Ubuntu 2 GB. Together they use 6 GB of RAM, leaving about 10 GB for the host.

### 4. Network: UTM Shared Network (NAT)
In UTM, I set both VMs to Shared Network. This creates an isolated virtual network (192.168.64.0/24) where the guests can see each other and reach the internet through the host.

| Mode | Guests see each other | Internet | Verdict |
|---|---|---|---|
| Shared Network (NAT) | yes | yes | chosen |
| Host Only | yes | no | fails the task |
| Bridged | yes | yes | risky on campus Wi-Fi (MAC filtering) |

### 5. Connectivity in both directions
The first ping from Linux to Windows failed. Windows Firewall drops inbound ICMP Echo Requests by default. I did not turn off the firewall. I added one inbound rule for ICMPv4 type 8 (echo request):

New-NetFirewallRule -DisplayName "Allow ICMPv4 Echo In" -Protocol ICMPv4 -IcmpType 8 -Direction Inbound -Action Allow -Profile Any

Then both directions plus the internet worked (see evidence/ping-both-ways.txt for full logs).

### 6. Memory overcommitment
Host memory was measured using memory_pressure and vm_stat in the macOS terminal. With both guests off, the host had about 9.8 GB available.

1. Both guests off -> measured "before" (evidence/host-memory-before.png).
2. Raised allocations: win11-arm 12 GB, ubuntu-server 8 GB - 20 GB promised on a 16 GB host.
3. Started both guests and filled memory in Ubuntu.
4. What the host did: macOS began swapping heavily (Swapouts: 1548902). The system became unresponsive for several seconds at a time.
5. After the experiment the allocations were returned to 4 GB / 2 GB.

## What did not work the first time

1. Windows guest failed to boot (black screen).
What I saw: the installer never appeared.
What it was: I initially tried to use the x64 evaluation ISO, but UTM cannot virtualize x64 guests on Apple Silicon. The VM would hang immediately.
What I did: Downloaded the Windows 11 Enterprise Evaluation ARM64 ISO from Microsoft.

2. Ping from Linux to Windows: 100% packet loss.
What I saw: ping timed out.
What it was: Windows Firewall blocks inbound echo requests by default.
What I did: Added a single ICMPv4 rule. The firewall remained on.

3. stress-ng crashed with "Illegal instruction".
What I saw: stress-ng failed immediately.
What it was: I accidentally installed the x86_64 binary inside the ARM64 Ubuntu guest via emulation, which caused a crash when it tried to access specific hardware instructions not available in the emulated environment.
What I did: Uninstalled it and wrote a custom memory-filling script in Python, which runs natively on ARM64.

## Evidence
- evidence/host-specs.txt
- evidence/ipconfig-windows.txt
- evidence/ip-addr-linux.txt
- evidence/ping-both-ways.txt
- evidence/firewall-rule.txt
- evidence/host-memory-before.png
- evidence/host-memory-after.png
