# Four Builds — detailed reasoning

## Build 1 — Accountant

**Load:** Heavy Excel (large pivot tables, VLOOKUP across sheets), 1C Accounting, Outlook, browser. Runs 8 hours solid. No video calls, no Docker, no GPU work.

**Bottleneck:** Single-core performance (Excel is still largely single-threaded) and RAM when files exceed ~2–3 GB.

**Chosen parts:**
- CPU: AMD Ryzen 5 5600G (6c/12t, strong single-core, integrated Vega graphics)
- RAM: 16 GB DDR4-3200
- Storage: 1 TB NVMe
- Motherboard: A520
- PSU: 500 W
- Monitor: 24" IPS
- Windows 11 Pro + keyboard/mouse

**Trade-off / alternative rejected:**  
I rejected the Ryzen 5 7600 (AM5) because the extra platform cost (~80–90 k) buys almost nothing for this workload. I also rejected a discrete GPU — the integrated graphics are more than enough and save both money and power. 16 GB is the minimum that stays comfortable with large Excel files; 32 GB would be waste.

**Total:** 612 000 KZT (see budget.csv rows 1–9)

---

## Build 2 — Sales Manager

**Load:** CRM in Chrome (30–40 tabs permanently open), Excel, Zoom/Teams 3–5 hours per day, sometimes screen-sharing while looking at the CRM. Multitasking all day.

**Bottleneck:** RAM. Chrome + one video call already sits at 11–14 GB. On 16 GB the machine starts swapping in the middle of a customer conversation.

**Chosen parts:**
- CPU: Intel Core i5-12400 (6c/12t, excellent multi-tasking, low power)
- RAM: 32 GB DDR4-3200
- Storage: 1 TB NVMe
- Motherboard: B660
- PSU: 500 W
- Monitor: 24" IPS
- Windows 11 Pro + keyboard/mouse + USB headset + 1080p webcam

**Trade-off / alternative rejected:**  
I deliberately took a cheaper CPU (i5-12400 instead of Ryzen 5 7600 or i5-13400) and spent the difference on 32 GB RAM and a proper headset. A faster CPU would sit idle 90 % of the time; RAM is what the user actually feels. I also rejected a discrete GPU — zero benefit for this role.

**Total:** 698 000 KZT (budget.csv rows 10–20)

---

## Build 3 — Web Developer

**Load:** Docker containers, local databases, VS Code with many extensions, 3–4 browsers with DevTools, Node.js builds, occasional light Figma.

**Bottleneck:** CPU for compilation and Docker, RAM (Docker + browsers easily eat 20+ GB), storage speed for node_modules and container layers.

**Chosen parts:**
- CPU: AMD Ryzen 7 7700 (8c/16t, Zen 4, excellent compile times)
- RAM: 32 GB DDR5-5600
- Storage: 1 TB PCIe 4.0 NVMe
- Motherboard: B650
- PSU: 650 W
- Monitor: 27" 2K IPS (more screen space for code + browser)
- Windows 11 Pro + keyboard/mouse

**Trade-off / alternative rejected:**  
I rejected a discrete GPU (RTX 4060) because the developer does not do 3D or CUDA work; the integrated graphics are enough and the money went into a faster CPU and Gen4 SSD instead. I also rejected 64 GB RAM — 32 GB is the sweet spot for this load today and still leaves upgrade room on the B650 board.

**Total:** 789 000 KZT (budget.csv rows 21–30)

---

## Build 4 — Designer

**Load:** Photoshop, Illustrator, Figma, large 4K/6K image files, occasional short video edits in Premiere.

**Bottleneck:** GPU (effects, smart objects, 4K layers) and colour accuracy of the monitor. RAM is secondary but still important.

**Chosen parts:**
- CPU: Intel Core i5-13400F (10 cores, enough for the CPU side of Adobe)
- RAM: 32 GB DDR5
- Storage: 1 TB NVMe
- GPU: NVIDIA RTX 4060 8 GB
- Motherboard: B760
- PSU: 650 W
- Monitor: 27" 4K IPS 99 % sRGB (colour-critical)
- Windows 11 Pro + keyboard/mouse

**Trade-off / alternative rejected:**  
I rejected a higher-end CPU (i7 or Ryzen 9) — Adobe is far more GPU-bound than CPU-bound for this user’s files. I also rejected the cheaper RTX 3050 / 3060 8 GB because the 4060 has noticeably better encoding and more modern architecture that will age better. The expensive 4K colour-accurate panel was non-negotiable; a regular 27" 2K would force the designer to work with inaccurate colours.

**Total:** 891 000 KZT (budget.csv rows 31–41)

---

## Longevity notes (the “few years” requirement)

- Accountant & Sales: DDR4 platforms — still fully supported, cheap upgrades later.
- Web Developer: AM5 platform — CPU can be swapped for a future Zen 5/6 chip without changing motherboard or RAM.
- Designer: the RTX 4060 can be replaced with a future 16 GB card on the same 650 W PSU; the 4K monitor will remain useful for many years.
