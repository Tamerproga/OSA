# Four Builds for the New Office

## 1. Accountant (Build 1)
*   **Load:** Heavy Excel spreadsheets, 1C accounting software, email, browsing. Runs 8 hours a day.
*   **Bottleneck:** CPU single-core speed (for Excel calculations) and RAM (for large files). No GPU needed.
*   **Trade-off:** We saved money by using an integrated GPU and a standard IPS monitor instead of a high-end display.
*   **Parts:** AMD Ryzen 5 5600G (CPU with integrated graphics), 16 GB DDR4, 1 TB NVMe SSD, A520 motherboard, 500W PSU, 24" IPS Monitor, Windows 11 Pro.

## 2. Sales Manager (Build 2)
*   **Load:** CRM in a browser (30+ tabs), Zoom/Teams video calls, MS Office. Multitasking all day.
*   **Bottleneck:** RAM and multitasking. The CPU will idle, but RAM runs out fast with Chrome tabs and video calls.
*   **Trade-off:** We allocated 32 GB of RAM (more than standard) and a slightly better webcam/headset, while saving on the GPU and CPU.
*   **Parts:** Intel Core i5-12400, 32 GB DDR4, 1 TB NVMe SSD, B660 motherboard, 500W PSU, 24" IPS Monitor, Windows 11 Pro.

## 3. Web Developer (Build 3)
*   **Load:** Running Docker containers, local databases, VS Code, multiple browsers with dev tools, Node.js.
*   **Bottleneck:** CPU (compiling) and RAM (Docker eats RAM). Storage speed is also critical.
*   **Trade-off:** We spent more on a high-end CPU (Ryzen 7) and 32 GB of fast DDR5 RAM. We skipped a dedicated GPU because the integrated one is enough for coding (no 3D rendering).
*   **Parts:** AMD Ryzen 7 7700, 32 GB DDR5, 1 TB Gen4 NVMe SSD, B650 motherboard, 650W PSU, 27" 2K Monitor (for more screen space), Windows 11 Pro (or WSL).

## 4. Designer (Build 4)
*   **Load:** Adobe Photoshop, Illustrator, Figma, large 4K image files, maybe light video editing.
*   **Bottleneck:** GPU (for rendering and effects) and RAM. Color accuracy of the monitor is crucial.
*   **Trade-off:** This is the most expensive build. We spent money on a dedicated NVIDIA RTX 4060 GPU, 32 GB RAM, a color-accurate 27" 4K monitor, and skipped a massive CPU (Ryzen 5 is enough).
*   **Parts:** Intel Core i5-13400F, 32 GB DDR5, 1 TB NVMe SSD, B760 motherboard, NVIDIA RTX 4060 8GB, 650W PSU, 27" 4K IPS Monitor (99% sRGB), Windows 11 Pro.
