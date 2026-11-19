# Lab 3 — Teardown, and the same machine from the command line

## First half: a teardown on paper

### 1. Components (Captions, Links, and Limits)
*All photos are in the `evidence/photos/` folder.*

*   **AMD Ryzen 5 7600:** Desktop CPU. **Connects to:** AM5 socket. **Limit:** Only works with DDR5 memory and AMD 600-series (or newer) motherboards. Link: [AMD](https://www.amd.com/en/products/apu/amd-ryzen-5-7600).
*   **Intel Core i5-13400:** Desktop CPU. **Connects to:** LGA1700 socket. **Limit:** Requires a 600/700-series Intel chipset; supports both DDR4 and DDR5 depending on the motherboard. Link: [Intel](https://www.intel.com/content/www/us/en/products/sku/230494/intel-core-i513400-processor-20m-cache-up-to-4-60-ghz/specifications.html).
*   **ASUS PRIME B650M-A:** Motherboard. **Connects to:** CPU, RAM, SSD, PSU. **Limit:** Supports only AMD Ryzen 7000/8000/9000 series (Socket AM5). Memory type is strictly DDR5. Link: [ASUS](https://www.asus.com/motherboards-components/motherboards/prime/prime-b650m-a/).
*   **MSI PRO B760M-A WIFI DDR4:** Motherboard. **Connects to:** CPU, RAM, SSD, PSU. **Limit:** Supports only Intel 12th/13th/14th Gen processors (Socket LGA1700). Memory type is strictly DDR4. Link: [MSI](https://www.msi.com/Motherboard/PRO-B760M-A-WIFI-DDR4).
*   **Kingston FURY Beast DDR5-5600 (16GB):** RAM. **Connects to:** DIMM slots on the motherboard. **Limit:** Cannot fit into DDR4 slots; requires a DDR5-compatible motherboard. Link: [Kingston](https://www.kingston.com/en/memory/gaming/kingston-fury-beast-ddr5-memory).
*   **Crucial DDR4-3200 (16GB):** RAM. **Connects to:** DIMM slots on the motherboard. **Limit:** Cannot fit into DDR5 slots; requires a DDR4-compatible motherboard. Link: [Crucial](https://www.crucial.com/memory/ddr4/ct16g4dfra32a).
*   **Samsung 990 PRO (1TB):** NVMe SSD. **Connects to:** M.2 PCIe slot on the motherboard. **Limit:** Requires PCIe 4.0 for max speed (works in 3.0 but slower). Link: [Samsung](https://semiconductor.samsung.com/consumer-storage/internal-ssd/990-pro/).
*   **Samsung 870 EVO (1TB):** SATA SSD. **Connects to:** SATA port on the motherboard and requires a SATA power cable from the PSU. **Limit:** Limited by SATA III speeds (~560 MB/s). Link: [Samsung](https://semiconductor.samsung.com/consumer-storage/internal-ssd/870-evo/).
*   **Corsair RM750e (750W):** Power Supply Unit. **Connects to:** Wall outlet, motherboard (24-pin), CPU (EPS), and drives. **Limit:** 750W total output. Link: [Corsair](https://www.corsair.com/us/en/p/psu/cp-9020262-na/rm750e-fully-modular-low-noise-atx-power-supply-cp-9020262-na).
*   **Stock coolers:**
    *   **AMD Wraith Stealth** (ships with Ryzen 5 7600). **Connects to:** CPU and CPU_FAN header. **Limit:** Only sufficient for stock TDP.
    *   **Intel Laminar RM1** (ships with i5-13400). **Connects to:** CPU and CPU_FAN header. **Limit:** Only sufficient for stock TDP.

### 2. Two Working Builds

**Build 1: The AMD Build**
*   **Parts:** AMD Ryzen 5 7600 + ASUS PRIME B650M-A + Kingston FURY Beast DDR5-5600 (16GB) + Samsung 990 PRO (1TB NVMe) + Corsair RM750e + AMD Wraith Stealth.
*   **Justification:** The Ryzen 5 7600 (AM5 socket) perfectly matches the ASUS B650M (AM5 socket). The motherboard only supports DDR5, matching the Kingston RAM. The Samsung 990 PRO fits the M.2 slot. The 750W PSU is plenty.
*   **What is missing:** A PC Case, an Operating System, and a dedicated Graphics Card.

**Build 2: The Intel Build**
*   **Parts:** Intel Core i5-13400 + MSI PRO B760M-A WIFI DDR4 + Crucial DDR4-3200 (16GB) + Samsung 870 EVO (1TB SATA) + Intel Laminar RM1.
*   **Justification:** The i5-13400 (LGA1700) fits the MSI B760M (LGA1700). The MSI board is DDR4, matching the Crucial RAM. The 870 EVO is a SATA drive, connecting to the board's SATA ports.
*   **What is missing:** A PC Case, an Operating System, a dedicated Graphics Card, and **a second Power Supply** (since only one Corsair RM750e is listed, Build 2 needs its own PSU).

## Second half: the same facts from the command line

### Three-OS Comparison Table

| Fact | macOS (Host) | Linux (Ubuntu VM) | Windows |
| :--- | :--- | :--- | :--- |
| **CPU Name** | `sysctl -n machdep.cpu.brand_string` | `lscpu` | `wmic cpu get name` |
| **RAM Amount** | `sysctl hw.memsize` | `free -h` | `wmic memorychip get capacity` |
| **Disk Info** | `system_profiler SPStorageDataType` | `lsblk` | `wmic diskdrive get size` |

*Raw outputs are saved in the `evidence/` folder as `macos-specs.txt`, `linux-specs.txt`, and `windows-specs.txt`, including the commands above each output.*

## What did not work the first time
The first time, my captions were too brief and only mentioned limits without explaining what the part connects to. Also, I forgot to include the actual terminal commands in the output text files, and I did not specify that the second computer build requires its own separate power supply. I have corrected all of these issues in this submission.
