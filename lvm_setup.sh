#!/bin/bash
# Создание LVM в GitHub Codespaces (симуляция диска)

sudo dd if=/dev/zero of=/tmp/disk.img bs=1M count=1024 status=none
sudo losetup -fP /tmp/disk.img
LOOP=$(losetup -l --noheadings -o NAME,BACK-FILE | grep disk.img | awk '{print $1}')

sudo pvcreate $LOOP
sudo vgcreate vg_storage $LOOP
sudo lvcreate -L 800M -n lv_storage vg_storage
sudo mkfs.ext4 -F /dev/vg_storage/lv_storage
sudo mkdir -p /mnt/storage
sudo mount /dev/vg_storage/lv_storage /mnt/storage

echo "LVM готов и смонтирован в /mnt/storage"
