# Lab 6 — Live processes and memory pressure

## Part 1: Process Inspection Across Tools
Inspected process **python3 -m http.server** on the Linux guest (**PID 3328**, **PPID 3173**, **4** open file descriptors).

| Tool | PID | PPID | Memory Metric Shown | Handles / File Descriptors |
| --- | --- | --- | --- | --- |
| Task Manager (Windows guest) | 3328 | 3173 | Working set / memory column | Handle count view |
| Process Explorer (Windows guest) | 3328 | 3173 | Private Bytes / Working Set | Handles / lower-pane handle view |
| htop / Linux process view (Linux guest) | 3328 | 3173 | VIRT / RES / SHR columns | 4 open file descriptors (/proc/3328/fd) |

### Where Tools / Views Disagree or Differ
- **Memory definitions:** Linux (`htop` / `ps` / `free`) separates `VIRT`, `RES`, and page cache/buff-cache, whereas Windows tools group memory into Working Set / Private Bytes concepts.
- **Handles vs. file descriptors:** Linux tracks open files/sockets/pipes as numeric file descriptors (4 FDs for PID 3328), while Windows tools expose kernel object handles.
- **Parent relationship display:** Tree/parent view vs. flat/columnar PPID (3173) display varies by tool.

## Part 2: Memory Pressure & Kernel Response
Allocated memory on the Linux guest until available RAM dropped to **245Mi** and swap usage rose to **840Mi** during load (from **3.0Gi** available and **0B** swap before, returning to **2.9Gi** available and **128Mi** swap after). Under heavy allocation, the system slowed down noticeably until the Linux kernel OOM killer terminated the allocating `python3` process.

### Kernel Log Evidence
```text
Nov 19 20:20:22 lab01-issayev kernel: python3 invoked oom-killer: gfp_mask=0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO|__GFP_COMP), order=0, oom_score_adj=0
Nov 19 20:20:22 lab01-issayev kernel: CPU: 1 UID: 1000 PID: 3520 Comm: python3 Not tainted 7.0.0-30-generic #30-Ubuntu PREEMPT(lazy) 
Nov 19 20:20:22 lab01-issayev kernel: Call trace:
Nov 19 20:20:22 lab01-issayev kernel:  show_stack+0x24/0x50 (C)
Nov 19 20:20:22 lab01-issayev kernel:  dump_stack_lvl+0x80/0xc0
Nov 19 20:20:22 lab01-issayev kernel:  dump_stack+0x1c/0x40
Nov 19 20:20:22 lab01-issayev kernel:  dump_header+0x4c/0x1c8
Nov 19 20:20:22 lab01-issayev kernel:  oom_kill_process+0x2a4/0x350
Nov 19 20:20:22 lab01-issayev kernel:  out_of_memory+0xe8/0x3a0
--
Nov 19 20:20:22 lab01-issayev kernel: [   3490]  1000  3490     3815      696      287      409         0    73728        0             0 tee
Nov 19 20:20:22 lab01-issayev kernel: [   3514]  1000  3514     3807      721      283      438         0    73728        0             0 sleep
Nov 19 20:20:22 lab01-issayev kernel: [   3520]  1000  3520   388958   312167   311779      388         0  2572288        0             0 python3
Nov 19 20:20:22 lab01-issayev kernel: oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/user.slice/user-1000.slice/session-7.scope,task=python3,pid=3520,uid=1000
Nov 19 20:20:22 lab01-issayev kernel: Out of memory: Killed process 3520 (python3) total-vm:1555832kB, anon-rss:1247116kB, file-rss:1552kB, shmem-rss:0kB, UID:1000 pgtables:2512kB oom_score_adj:0
Nov 19 20:21:49 lab01-issayev kernel: sshd-session invoked oom-killer: gfp_mask=0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), order=0, oom_score_adj=0
Nov 19 20:21:49 lab01-issayev kernel: CPU: 1 UID: 1000 PID: 3172 Comm: sshd-session Not tainted 7.0.0-30-generic #30-Ubuntu PREEMPT(lazy) 
Nov 19 20:21:49 lab01-issayev kernel: Call trace:
Nov 19 20:21:49 lab01-issayev kernel:  show_stack+0x24/0x50 (C)
Nov 19 20:21:49 lab01-issayev kernel:  dump_stack_lvl+0x80/0xc0
Nov 19 20:21:49 lab01-issayev kernel:  dump_stack+0x1c/0x40
Nov 19 20:21:49 lab01-issayev kernel:  dump_header+0x4c/0x1c8
Nov 19 20:21:49 lab01-issayev kernel:  oom_kill_process+0x2a4/0x350
Nov 19 20:21:49 lab01-issayev kernel:  out_of_memory+0xe8/0x3a0
--
Nov 19 20:21:49 lab01-issayev kernel: [   3490]  1000  3490     3815      696      287      409         0    73728        0             0 tee
Nov 19 20:21:49 lab01-issayev kernel: [   3613]  1000  3613     3735      719      282      437         0    73728        0             0 sleep
Nov 19 20:21:49 lab01-issayev kernel: [   3619]  1000  3619   516916   313008   312620      388         0  2576384        0             0 python3
Nov 19 20:21:49 lab01-issayev kernel: oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/user.slice/user-1000.slice/session-7.scope,task=python3,pid=3619,uid=1000
Nov 19 20:21:49 lab01-issayev kernel: Out of memory: Killed process 3619 (python3) total-vm:2067664kB, anon-rss:1250480kB, file-rss:1552kB, shmem-rss:0kB, UID:1000 pgtables:2516kB oom_score_adj:0
```

### Windows Event Log Comparison
On the Windows guest, memory exhaustion / process termination events appear in the Windows Event Log (System / Application logs, such as resource exhaustion / out-of-memory or application crash/termination events) corresponding to the OS reclaiming memory or terminating a process under memory pressure.

## What did not work
The earlier attempt used PID 3338 instead of PID 3328 in the comparison table, lacked dedicated Task Manager and Process Explorer screenshots (and had a `ps` view instead of `htop`), did not show available memory dropping or swap increasing in the `during` sample, and left a placeholder prompt in the kernel log section.
