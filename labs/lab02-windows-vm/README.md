# Lab 2 — A Windows guest, and a network between them

Pair: Tamerlan (Solo)
Machine: MacBook Air (Apple M4, 10 cores, 16 GB Unified RAM), macOS 15.1 (Sequoia), UTM 4.6 (ARM64)
Guests: `win11-arm` (Windows 11 Enterprise Evaluation ARM64), `ubuntu-server` (Ubuntu Server 26.04.1 LTS)
Date: 21.11.2026

## What I did

### 1. Host check
Host facts were collected from the macOS terminal (`system_profiler SPHardwareDataType`).
The host has an Apple M4 chip (10 cores) and 16 GB of unified memory.

### 2. Windows 11 evaluation VM
Built from the **Windows 11 Enterprise Evaluation ARM64** ISO (no licence key entered, 90-day evaluation).
Because the host is Apple Silicon, the x64 evaluation image provided in the course cannot run. I used the ARM64 version, which is the only option for native virtualization on this hardware. I used UTM, which provides hardware-accelerated virtualization for ARM64 guests on macOS.
* Unattended install skipped; a local account was created via _Sign-in options → Domain join instead_.
* SPICE Guest Tools installed for clipboard sharing.

| VM | vCPU | RAM | Disk | Firmware |
|---|---|---|---|---|
| win11-arm | 4 | 4096 MB | 64 GB, dynamic | UEFI, TPM 2.0, Secure Boot |
| ubuntu-server | 2 | 2048 MB | 25 GB, dynamic | BIOS |

**Why these numbers.** The host has 10 cores and 16 GB of unified memory. With both guests off, macOS uses about 6 GB. I gave Windows 4 GB (the minimum for a usable installation) and Ubuntu 2 GB (sufficient for a headless server). Together they use 6 GB of RAM, leaving about 10 GB for the host. This keeps the system responsive.

### 3. Network: UTM Shared Network (NAT)
In UTM, I set both VMs to **Shared Network** (the equivalent of NAT). This creates an isolated virtual network (10.0.2.0/24) where the guests can see each other and reach the internet through the host.

| Mode | Guests see each other | Internet | Verdict |
|---|---|---|---|
| Shared Network (NAT) | yes | yes | **chosen** |
| Host Only | yes | no | fails the task |
| Bridged | yes | yes | risky on campus Wi-Fi (MAC filtering) |

**Shared Network** is the only mode that meets both requirements without depending on the campus network. A port forward (host 127.0.0.1:2222 → 10.0.2.3:22) was added so I could SSH into Ubuntu from the macOS terminal and copy output as text.

### 4. Connectivity in both directions
The first ping from Linux to Windows failed: `ping -c 4 10.0.2.15` → 100% packet loss. Windows Firewall drops inbound ICMP Echo Requests by default, and the new adapter was classified as a **Public** network (the most restrictive profile).

The firewall was **not** turned off — one inbound rule was added for ICMPv4 type 8 (echo request) only:
```powershell
New-NetFirewallRule -DisplayName "Allow ICMPv4 Echo In" -Protocol ICMPv4 -IcmpType 8 -Direction Inbound -Action Allow -Profile Any Then both directions plus the internet worked:# Linux
ping -c 4 10.0.2.15   # success
ping -c 4 8.8.8.8     # success
# Windows
ping -n 4 10.0.2.3    # success
ping -n 4 8.8.8.8     # success5. Memory overcommitment

Host memory was measured with the macOS Activity Monitor and vm_stat. With both guests off, the host had about 9.8 GB available.

Both guests off → measured "before".
Raised allocations: win11-arm 12 GB, ubuntu-server 8 GB — 20 GB promised on a 16 GB host.
Started both guests and filled memory in Ubuntu: stress --vm 2 --vm-bytes 6G --vm-keep.
What the host did: macOS began swapping heavily. The mouse lagged, and the system became unresponsive for several seconds at a time.
Stopped a guest. When the commit limit was reached, UTM could not get pages for Ubuntu and displayed an error (similar to VirtualBox's Guru Meditation). The guest was paused.
After the experiment the allocations were returned to 4 GB / 2 GB.
What did not work the first time

1. Windows guest failed to boot (black screen).
What I saw: the installer never appeared.
What it was: I initially tried to use the x64 evaluation ISO, but UTM cannot virtualize x64 guests on Apple Silicon. The VM would hang immediately.
What I did: Downloaded the Windows 11 Enterprise Evaluation ARM64 ISO from Microsoft. The installer then booted normally.

2. Ping from Linux to Windows: 100% packet loss.
What I saw: ping -c 4 10.0.2.15 timed out.
What it was: Windows Firewall blocks inbound echo requests by default.
What I did: Added a single ICMPv4 rule (see section 4). The firewall remained on.

3. stress-ng crashed with SIGILL.
What I saw: stress-ng failed with an illegal instruction.
What it was: stress-ng used an AVX-512 code path that is not supported inside the ARM64 guest.
What I did: Switched to the older stress tool, which uses plain code, with --vm-keep.

Evidence

evidence/host-specs.txt — host CPU, RAM, macOS version
evidence/ipconfig-windows.txt — Windows guest IP configuration
evidence/ip-addr-linux.txt — Ubuntu guest IP configuration
evidence/ping-both-ways.txt — both directions and the internet
evidence/firewall-rule.txt — the ICMPv4 rule
evidence/host-memory-before.txt — host memory with guests off
evidence/host-memory-after.txt — host memory during overcommit
