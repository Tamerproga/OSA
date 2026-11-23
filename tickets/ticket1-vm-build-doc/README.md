# Ticket 1 - VM build document

## 1. What was asked
Aigerim (Office Manager) asked: "We have someone starting on Monday and he needs a test computer set up. Nothing special, just so he can try things without breaking anything. Can you write down how to do it so I can do the next one myself?"

## 2. What was actually needed
Aigerim's request left out critical information. "Nothing special" is not a technical specification, and Aigerim is not an IT person, so she doesn't know what to ask for.
*   **What was left out:** She did not specify the OS the developer needs, the host's RAM, or the network access required. She also didn't ask about licenses (we need a valid Windows eval license and hypervisor license) and didn't know about "snapshots" as the real way to test things "without breaking anything".
*   **What I assumed:** I assumed the developer needs an Ubuntu Server VM for backend testing and a Windows 11 ARM64 VM for frontend testing. I assumed the host is my Mac with 16 GB RAM.
*   **Questions for Aigerim:** What specific software does the developer need (Docker, VS Code)? Do they need Windows or Linux? Do we have a budget for a Windows license?
*   **What was wrong:** The request implies any machine will do, but a dev needs specific tools, network access, and snapshot rollback capabilities.

## 3. Non-default settings and resource justification
I used the following non-default settings for the VMs:
*   **Windows 11:** 4096 MB RAM, 4 vCPUs, 64 GB Disk, EFI enabled, Secure Boot enabled, TPM 2.0 enabled, Shared Network (NAT).
*   **Ubuntu Server:** 2048 MB RAM, 2 vCPUs, 25 GB Disk, BIOS, Shared Network (NAT).

**Resource calculation (based on Lab 0 host numbers):**
My host is a MacBook Air (Apple M4, 10 cores, 16 GB RAM, 251 GB SSD).
*   **CPU:** I allocated 6 vCPUs total out of 10 physical cores, leaving 4 for macOS.
*   **RAM:** I allocated 6 GB total (4+2) out of 16 GB, leaving 10 GB for macOS to run smoothly.
*   **Disk:** 89 GB total (64+25) dynamically allocated out of 251 GB free, which is safe and won't fill the SSD.

## 4. What I would do differently
If I had more time, I would ask Aigerim exactly what software the developer needs. I would also automate the Ubuntu setup using a cloud-init script instead of writing a GUI guide. Finally, I would write a proper troubleshooting section for network errors.
