# Lab 3 — Teardown, and the same machine from the command line

## First half: a teardown on paper

### 1. Components (Captions, Links, and Limits)
*All photos are in the `evidence/photos/` folder.*

*   **AMD Ryzen 5 7600:** Desktop processor. Connects to AM5 socket. Limit: only works with DDR5 memory and AMD 600-series (or newer) motherboards. Link: [AMD](https://www.amd.com/en/products/apu/amd-ryzen-5-7600). Ships with AMD Wraith Stealth cooler.
*   **Intel Core i5-13400:** Desktop processor. Connects to LGA1700 socket. Limit: requires a 600/700-series chipset. Link: [Intel](https://www.intel.com/content/www/us/en/products/sku/230494/intel-core-i513400-processor-20m-cache-up-to-4-60-ghz/specifications.html). Ships with Intel Laminar RM1 cooler.
*   **ASUS PRIME B650M-A:** Motherboard. Limit: Supports only AMD Ryzen 7000/8000/9000 series (Socket AM5). Memory type: DDR5 only. Link: [ASUS](https://www.asus.com/motherboards-components/motherboards/prime/prime-b650m-a/).
*   **MSI PRO B760M-A WIFI DDR4:** Motherboard. Limit: Supports only Intel 12th/13th/14th Gen processors (Socket LGA1700). Memory type: DDR4 only. Link: [MSI](https://www.msi.com/Motherboard/PRO-B760M-A-WIFI-DDR4).
*   **Kingston FURY Beast DDR5-5600 16GB:** RAM. Limit: Cannot be used in DDR4 slots. Link: [Kingston](https://www.kingston.com/en/memory/gaming/kingston-fury-beast-ddr5-memory).
*   **Crucial DDR4-3200 16GB DIMM:** RAM. Limit: Cannot be used in DDR5 slots. Link: [Crucial](https://www.crucial.com/memory/ddr4/ct16g4dfra32a).
*   **Samsung 990 PRO 1TB:** NVMe SSD. Limit: Requires PCIe 4.0 for max speed. Link: [Samsung](https://semiconductor.samsung.com/consumer-storage/internal-ssd/990-pro/).
*   **Samsung 870 EVO 1TB:** SATA SSD. Limit: Limited by SATA III speeds. Link: [Samsung](https://semiconductor.samsung.com/consumer-storage/internal-ssd/870-evo/).
*   **Corsair RM750e (750W):** Power Supply Unit (PSU). Limit: 750W total output. Link: [Corsair](https://www.corsair.com/us/en/p/psu/cp-9020262-na/rm750e-fully-modular-low-noise-atx-power-supply-cp-9020262-na).
*   **Stock coolers:** Limit: Only sufficient for stock TDP.

### 2. Two Working Builds
**Build 1: The AMD Build**
*   Parts: AMD Ryzen 5 7600 + ASUS PRIME B650M-A + Kingston FURY Beast DDR5-5600 (16GB) + Samsung 990 PRO 1TB + Corsair RM750e + AMD Wraith Stealth.
*   Justification: The Ryzen 5 7600 (AM5) matches the ASUS B650M (AM5). Motherboard supports DDR5, so Kingston DDR5 is required. 990 PRO uses M.2 slot. 750W PSU is plenty.
*   Missing: PC Case, OS, dedicated GPU.

**Build 2: The Intel Build**
*   Parts: Intel Core i5-13400 + MSI PRO B760M-A WIFI DDR4 + Crucial DDR4-3200 (16GB) + Samsung 870 EVO 1TB + Corsair RM750e + Intel Laminar RM1.
*   Justification: i5-13400 (LGA1700) fits the MSI B760M (LGA1700). MSI board is DDR4, matching Crucial kit. 870 EVO is SATA drive.
*   Missing: PC Case, OS, dedicated GPU.

## Second half: the same facts from the command line
### Three-OS Comparison Table
| Fact | macOS (Host) | Linux (Ubuntu VM) | Windows |
| :--- | :--- | :--- | :--- |
| **CPU Name** | `sysctl -n machdep.cpu.brand_string` | `lscpu` | `wmic cpu get name` |
| **RAM Amount** | `sysctl hw.memsize` | `free -h` | `wmic memorychip get capacity` |
| **Disk Info** | `system_profiler SPStorageDataType` | `lsblk` | `wmic diskdrive get size` |
