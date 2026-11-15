# Lab 4 - Partition, mirror, fail, recover

## Layout
- **Windows:** (Theoretical part) MBR is used for legacy BIOS, GPT for modern UEFI. We assign a drive letter.
- **Linux:** Created a RAID 1 (mirror) array `/dev/md0` using two 1GB disks (`/dev/sdb` and `/dev/sdc`). Formatted as `ext4` and mounted at `/mnt/raid1`. After failure, `/dev/sdd` was added and the array rebuilt successfully.

## Answer to the question
**Colleague deleted the wrong file an hour ago. Does RAID 1 help? Why?**
No, RAID 1 does not help in this case. RAID 1 provides redundancy against hardware failure (like a disk dying), ensuring the system stays online. However, it mirrors data instantly, so if a user deletes a file, it is deleted from both disks immediately. To recover deleted files, you need a backup or a filesystem snapshot, not a RAID array.

## Evidence Files
- `lsblk-before.txt` - Disks layout before starting.
- `array-healthy.txt` - RAID state when fully functional.
- `array-degraded.txt` - RAID state after one disk failed.
- `checksum-before.txt` - MD5 checksum of the file before failure.
- `checksum-after-failure.txt` - MD5 checksum of the file after failure (proves data survived).
- `array-rebuilt.txt` - RAID state after adding the third disk and rebuilding.
