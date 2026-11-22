# Ticket 1 - VM build document

## 1. What was asked
Aigerim (Office Manager) asked: "We have someone starting on Monday and he needs a test computer set up. Nothing special, just so he can try things without breaking anything. Can you write down how to do it so I can do the next one myself?"

## 2. What was actually needed
Aigerim's request left out critical information. "Nothing special" is not a technical specification. 
*   **What was left out:** She did not specify the OS the developer needs (Linux/Windows/both), how much RAM the host has, or what network access the developer requires (internet, local servers, SSH).
*   **What I assumed:** I assumed the developer needs an Ubuntu Server VM for backend testing and a Windows VM for frontend/browser testing. I assumed the host is my Mac with 16 GB RAM.
*   **What was wrong:** The request implies any machine will do, but a developer needs specific tools and network access. I had to build a guide that includes networking (NAT) and SSH.

## 3. What I did
I wrote a step-by-step `BUILD.md` document that a non-technical person can follow. 
*   **Resources:** I allocated 2 GB RAM and 2 CPUs to Ubuntu, and 4 GB RAM and 2 CPUs to Windows. This fits within my 16 GB host (leaving 10 GB for macOS).
*   **Settings:** I enabled NAT networking because the campus Wi-Fi blocks unknown MAC addresses (Bridged mode would fail). I enabled TPM 2.0 and Secure Boot for Windows 11.
*   **Evidence:** All screenshots and text outputs are in the `evidence/` folder.

## 4. Evidence
*   `01-new-vm-wizard.png` - The VM creation screen.
*   `02-disk-settings.png` - The 25 GB dynamically allocated disk.
*   `03-network-adapter.png` - NAT network mode.
*   `04-guest-uname.txt` - Output of `uname -a` inside Ubuntu.
*   `05-ping-between-guests.txt` - Ping between the Ubuntu VM and host.
*   `06-snapshot-list.png` - The `clean-install` snapshot.

## 5. What I would do differently
If I had more time, I would ask Aigerim exactly what software the developer needs (e.g., Docker, Node.js, VS Code). I would also create a "First Day Checklist" for the developer, so they know the SSH password and how to access the test environment. Next time, I would automate the Ubuntu setup using a cloud-init script instead of writing a 5-step GUI guide.
