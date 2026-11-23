# How to build a Test Machine (Ubuntu & Windows)

## Step 1: Download the Tools
1. Download and install UTM from https://mac.getutm.app (Free hypervisor for Apple Silicon).
2. Download the Ubuntu Server ARM64 ISO from https://ubuntu.com/download/server/arm.
3. Download the Windows 11 Enterprise Evaluation ARM64 ISO from https://www.microsoft.com/en-us/evalcenter/evaluate-windows-11-enterprise.

## Step 2: Create the Linux (Ubuntu) Guest
1. Open UTM and click **Create a New Virtual Machine**.
2. Select **Virtualize** -> **Linux**.
3. Browse to the Ubuntu Server ARM64 ISO.
4. Memory: **2048 MB**. CPU Cores: **2**. Storage: **25 GB**.
5. Start the VM. Choose "Install OpenSSH server" when asked.

## Step 3: Create the Windows Guest (Requires EFI/Secure Boot)
1. Open UTM and click **Create a New Virtual Machine**.
2. Select **Virtualize** -> **Windows**.
3. Browse to the Windows 11 Enterprise ARM64 ISO.
4. Memory: **4096 MB**. CPU Cores: **4**. Storage: **64 GB**.
5. **Important:** In UTM settings, enable **EFI Boot** and **Secure Boot** (TPM 2.0 is emulated by default in UTM). Windows 11 will refuse to install without this.
6. Start the VM and follow the Windows installer.

## Step 4: Networking (Shared Network)
In UTM, go to Settings -> Network. Change the mode to **Shared Network**.
*Why Shared Network and not Bridged?* The Innotech teaching network filters by MAC address. A bridged adapter gives the guest its own MAC, which the network will reject. Behind Shared Network, the guest goes out using the host's address, and the problem disappears. Note: Plain NAT in VirtualBox does not allow guests to see each other, so Shared Network (NAT Network) is required.
> Check: run `ip addr` inside the guest. You should see an address like 192.168.64.x.

## Step 5: Test and Rollback
1. Test the connection by pinging from Ubuntu to Windows.
2. Shut down the VM. Go to Snapshots -> Take. Name it `clean-install`.
3. If you break something, just click "Restore" to roll back instantly.
