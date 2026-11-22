# Ticket 2 - Kitting out the new office

## 1. What was asked
Director Daniyar requested four identical computers for an accountant, sales manager, web developer, and designer. The budget is 3,000,000 KZT for everything (including monitors). He wants them to last a few years.

## 2. What was actually needed (The Real Request)
The director's assumption that "four identical machines are best" is incorrect. Building four identical PCs is a mistake because their workloads are completely different:
*   An accountant needs a reliable CPU and standard RAM, but no GPU.
*   A web developer needs a lot of RAM (Docker/containers) and a fast CPU, but no dedicated GPU.
*   A designer needs a powerful dedicated GPU, color-accurate monitor, and lots of RAM.
If we buy four identical mid-range PCs, the designer will suffer from slow rendering, while the accountant's PC will have wasted power.

**What was left out:** The request did not mention keyboards, mice, Windows OS licenses, or the exact size/quality of monitors. I have assumed standard peripherals and included Windows 11 Pro licenses in the budget, as accounting software (like 1C) and Adobe tools require Windows. I would ask Daniyar if the designer needs a drawing tablet or a calibrated monitor.

## 3. What I did
I built four different PCs tailored to their specific bottlenecks (detailed in `builds.md` and priced in `budget.csv`). The total cost is 2,685,000 KZT, leaving room for peripherals.

### Answers to the Director's Questions:
1.  **Which machine to upgrade first in 18 months and why?**
    I would upgrade the **Web Developer's RAM and SSD** first (or add a second 1TB drive). As Docker images and local databases grow, storage and RAM are consumed fastest. The Designer's GPU will also age, but a PC with 32GB RAM and a Gen4 SSD can easily last 3 years.
2.  **Pre-built vs. Custom Builds:**
    If we bought pre-built PCs, the company gains **warranty and support** (one phone call to fix it) and saves build time. However, we lose the **choice of components** (pre-builts often skimp on the Power Supply and Motherboard) and it's harder to upgrade them later. Pre-built PCs also cost 10-15% more for the same specs. I have added a pre-built alternative in `budget.csv` (as a theoretical comparison, we would need ~3.2 million KZT for pre-builts of this quality).
3.  **Who will complain within a month and why?**
    The **Designer** will complain. Even though we bought an RTX 4060, complex 4K Photoshop files with dozens of layers, or 4K video editing, will quickly fill up the RAM and VRAM. They might also complain about the monitor if it doesn't match their specific Pantone color needs. The second to complain would be the **Accountant** if their 1C database grows too large and requires more processing power.

## 4. Evidence
*   `budget.csv` - Detailed pricing in KZT from local vendors.
*   `builds.md` - Justification of parts for each role.
*   `evidence/pcpartpicker-links.md` - Compatibility check.

## 5. What I would do differently
If I had more time, I would interview the designer to find out exactly which software they use (Figma vs. Adobe Premiere) and whether they need a color-calibrated monitor (which costs significantly more). I would also ask the accountant if they need dual monitors for spreadsheets. Furthermore, I would research the exact power draw of the designer's PC to see if a 750W PSU is needed for future GPU upgrades.
