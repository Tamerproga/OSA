# Ticket 2 — We are kitting out the new office

**Pair:** Tamerlan (Solo)  
**Date:** 23 Nov 2026  
**Budget:** 3 000 000 KZT (everything, monitors included)

---

## 1. The real request

The director wrote:

> We are opening the second office and need four computers — accountant, sales, web developer, designer. Budget 3,000,000 tenge for everything. Everyone says we should just buy the same four machines, is that right? Make sure they last a few years. Monitors included.

He did **not** ask for four identical machines. He asked for four machines that fit four different jobs and that will still be usable in 2–3 years. The phrase “just buy the same four machines” is the assumption we must reject.

Missing from the request (and therefore must be supplied by us):
- Exact software each role actually runs
- Keyboard + mouse for every machine
- Licensed Windows 11 Pro (required by company policy)
- Longevity plan (what will be upgraded in 18 months)
- Peripherals that the sales person needs for calls (headset + webcam)

---

## 2. Why identical machines are wrong

| Role | Real daily load | Real bottleneck | What identical 16 GB / mid-range CPU would do |
|------|------------------|-----------------|-----------------------------------------------|
| Accountant | Excel + 1C + large spreadsheets 8 h/day | Single-core speed + RAM for big files | Fine, but we can save money on GPU |
| Sales Manager | CRM (30–40 tabs) + Zoom/Teams 4 h/day + Excel | **RAM** (Chrome + call easily hits 12–14 GB) | Starts swapping during client calls |
| Web Developer | Docker + VS Code + Node + multiple browsers with DevTools | CPU (compile) + RAM + fast storage | Feels slow, Docker eats RAM |
| Designer | Photoshop + Illustrator + Figma + 4K files | **GPU** + colour-accurate monitor + RAM | Integrated graphics cannot handle effects and 4K layers |

Buying four identical machines either overspends on the accountant or underspends on the designer and sales person. Both outcomes break the “last a few years” requirement.

---

## 3. Four builds (summary)

Full justification and rejected alternatives → `builds.md`  
Exact prices with vendor + date → `budget.csv`

| Role | CPU | RAM | Storage | GPU | Monitor | Total KZT |
|------|-----|-----|---------|-----|---------|-----------|
| Accountant | Ryzen 5 5600G | 16 GB DDR4 | 1 TB NVMe | Integrated | 24" IPS | 612 000 |
| Sales Manager | Core i5-12400 | 32 GB DDR4 | 1 TB NVMe | Integrated | 24" IPS | 698 000 |
| Web Developer | Ryzen 7 7700 | 32 GB DDR5 | 1 TB Gen4 NVMe | Integrated | 27" 2K | 789 000 |
| Designer | Core i5-13400F | 32 GB DDR5 | 1 TB NVMe | RTX 4060 8 GB | 27" 4K 99% sRGB | 891 000 |
| **Grand total (parts + OS + keyboards/mice + sales headset)** | | | | | | **2 990 000** |

All four machines stay under the 3 000 000 KZT hard limit and leave a small reserve.

---

## 4. Answers to the three required questions

### 4.1 Which machine will we upgrade first in 18 months and why?

**Designer.**  
Photoshop and Figma are adding more AI features and larger layer support every year. The RTX 4060 will still be usable, but 8 GB VRAM will become the limiting factor first. Upgrading only the GPU (or moving to a 12 GB card) is the cheapest way to keep the designer productive. The other three roles are CPU/RAM bound and the parts we chose already have headroom.

### 4.2 Pre-built machines from a vendor — what does the company gain and lose?

I priced the same four configurations as pre-built PCs from Technodom / Sulpak (see last rows of `budget.csv`).

- **Gain:** 1–2 year on-site warranty, single invoice, no assembly time, easier for accounting.
- **Lose:** ~180–250 000 KZT extra, less control over exact component quality, harder to upgrade later (pre-builts often use proprietary PSUs or non-standard cases), and we cannot choose the exact colour-accurate panel the designer needs.

Recommendation: build ourselves. The saving pays for better monitors and a proper headset for sales, and the upgrade path stays open.

### 4.3 Who will complain about performance within a month and about what?

**Sales Manager — about RAM / stuttering during calls.**  
Even with 32 GB the combination of 40 Chrome tabs + Teams + screen share can still push the machine hard. If the CRM tabs are left open overnight, the first morning call will feel laggy. This is the only role where the user will notice the limit in daily interactive work. The other three roles either run batch work (accountant, developer) or have a dedicated GPU (designer).

---

## 5. What I would do differently next time

I would sit with the designer for 15 minutes and ask which exact Adobe version and colour workflow they use, then measure the actual peak VRAM of their current files. I would also check the PSU headroom on the designer build more carefully (650 W is enough today, but a future GPU upgrade may need 750 W). Finally I would keep a small “peripheral reserve” line in the budget instead of absorbing keyboards/mice into the machine totals.
