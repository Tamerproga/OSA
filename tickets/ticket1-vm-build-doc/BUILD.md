# How to build a Test Machine (Ubuntu & Windows)

## Step 1: Download the Tools
1. Install VirtualBox (or VMware) from the official website.
2. Download the Ubuntu Server ISO and Windows 11 ISO.

## Step 2: Create the Linux (Ubuntu) Guest
1. Open VirtualBox and click **New**.
2. Name: `lab01-issuev`. Type: Linux. Version: Ubuntu (64-bit).
3. Memory: **2048 MB**. Processors: **2**.
4. Hard Disk: Create a virtual disk now, **25 GB**, Dynamically allocated.
5. Start the VM, select the ISO, and follow the installer. Choose "Install OpenSSH server" when asked.

## Step 3: Create the Windows Guest
1. Open VirtualBox and click **New**.
2. Name: `lab02-windows`. Type: Microsoft Windows. Version: Windows 11 (64-bit).
3. Memory: **4096 MB**. Processors: **2**.
4. Hard Disk: Create a virtual disk now, **64 GB**, Dynamically allocated.
5. **Important:** Go to Settings -> System and enable **TPM 2.0** and **Secure Boot** (required for Windows 11).
6. Start the VM, select the ISO, and install Windows.

## Step 4: Networking
In the VM settings, under Network Adapter, choose **NAT**. 
*Why NAT and not Bridged?* The Innotech teaching network filters by MAC address. A bridged adapter gives the guest its own MAC, which the network will reject. Behind NAT, the guest goes out using the host's address, and the problem disappears.
> Check: run `ip addr` inside the guest. You should see an address like 192.168.x.x, different from the host's.

## Step 5: Snapshot
Before you start testing, shut down the VM. Go to Snapshots -> Take. Name it `clean-install`.
