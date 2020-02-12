
timedatectl set-ntp true

echo "Partition config from sda-part.dump"
sfdisk /dev/sda < sda-part.dump

echo "Formatting partitions"
mkfs.ext4 /dev/sda2
mkfs.fat -F 32 /dev/sda1

echo "Mounting partitions"
mkdir /mnt/boot
mount /dev/sda2 /mnt
mount /dev/sda1 /mnt/boot

echo "Installing kernel + basics"
pacstrap /mnt base linux linux-firmware man-db man-pages texinfo efibootmgr vim

echo "fstab generator"
genfstab /mnt >> /mnt/etc/fstab

echo "Adding EFI boot entry ($PART_UUID)"
PART_UUID=$(blkid -s UUID -o value /dev/sda2)
efibootmgr --create --disk /dev/sda --part 1 --label "Arch Linux" --loader /vmlinuz-linux --unicode "root=PARTUUID=$PART_UUID rw initrd=\initramfs-linux.img" --verbose

echo "Preparing basic install"
chmod +x basic_install.sh
cp basic_install.sh /mnt/home

echo "Rooting into new SO"
arch-chroot /mnt