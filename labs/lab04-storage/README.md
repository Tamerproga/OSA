# Lab 4 — Partition, mirror, fail, recover

## Disk Layout Before Array
```text
$ lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT
NAME   SIZE TYPE FSTYPE MOUNTPOINT
vda     30G disk
└─vda1  30G part ext4   /
sdb      2G disk
sdc      2G disk
sdd      2G disk
```

## Disk Layout After Array & Rebuild
```text
$ lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT
NAME    SIZE TYPE FSTYPE            MOUNTPOINT
vda      30G disk
└─vda1   30G part ext4              /
sdb       2G disk
└─md0     2G raid1 ext4             /mnt/raid1
sdc       2G disk
sdd       2G disk
└─md0     2G raid1 ext4             /mnt/raid1
```

## Question: Colleague deleted the wrong file from the mirror an hour ago. Does RAID 1 help? Why?
RAID 1 does not help when a colleague accidentally deletes a file because file deletion is mirrored across both disks immediately. RAID 1 protects against physical or hardware disk failure, not logical errors or accidental deletion. You need a separate backup or snapshot to recover a file deleted an hour ago.

## What did not work
The previous attempt had array-degraded.txt without full mdadm --detail (State : clean, degraded), included an old /data mount and extra disk in lsblk-before.txt, lacked the post-build lsblk layout in README.md, and lacked a new 1 GB disk with an NTFS partition and drive letter in windows-storage.txt.
