# Lab 1: Your first virtual machine

## Resource Allocation Justification
I configured the Ubuntu Server VM with the following resources based on the host machine measurements from Lab 0 (Apple M4, 10 CPUs, 16 GB RAM, 251 GB SSD):

* **2 vCPUs:** The host has 10 physical cores. Allocating 2 cores to the VM provides a fast, responsive server environment while leaving 8 cores dedicated to macOS and background tasks.
* **2048 MB (2 GB) of RAM:** The host has 16 GB of memory. macOS typically requires about 6-8 GB to run smoothly. Allocating 2 GB to the VM is the minimum recommended for a headless Ubuntu Server, leaving 14 GB for the host system.
* **30 GB of Disk:** The host has 251 GB of storage. A 30 GB virtual disk is more than enough for the Ubuntu Server OS and future updates, without wasting too much of the host's physical SSD space.

## What did not work
**No issues encountered. The clean-install snapshot was taken before modifications, and the rollback successfully restored the system state.**
