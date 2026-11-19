# Lab 4 - Partition, mirror, fail, recover

## Windows Storage
The Windows disk uses a **GPT** partition style because it supports UEFI boot and larger drives (unlike the old MBR). A drive letter (C:) was assigned to the primary NTFS partition. The required `Get-Disk`, `Get-Volume`, and `Get-Partition` outputs are saved in `evidence/windows-storage.txt`.

## Linux RAID 1 Array
I attached three 1GB disks (`sdb`, `sdc`, `sdd`). I created a RAID 1 mirror using `sdb` and `sdc`, formatted it as `ext4`, and mounted it at `/mnt/raid1`. The evidence files contain the exact commands executed alongside their raw output, including `mdadm --detail`. I used SHA256 checksums on `proof.txt` and `random.bin` to prove data survival.

## Answer to the question
**Colleague deleted the wrong file an hour ago. Does RAID 1 help? Why?**
No, RAID 1 does not help in this case. RAID 1 provides redundancy against hardware failure (like a dead disk), keeping the system online by mirroring data. However, if a user deletes a file, the deletion is instantaneous on both disks. To recover from accidental deletion, you need a backup or a filesystem snapshot, not a RAID array.

## What did not work the first time
During my first attempt, my `array-rebuilt.txt` was taken before the rebuild reached 100%, so the final `[2/2] [UU]` state was not evidenced. I also used MD5 instead of SHA256, and I did not include the actual commands in the evidence files. Furthermore, I lacked the Windows `Get-Disk` output. I have corrected all of these issues in this submission.
