

timedatectl set-ntp true

#partition config
#format
mkfs.ext4 /dev/sda2
mkfs.fat -F 32 /dev/sda1
#mounting
mount /dev/sda2 /mnt
mount /dev/sda1 /mnt/boot
#installing basics
pacstrap /mnt base linux linux-firmware
#fstab
genfstab /mnt >> /mnt/etc/fstab
#installing network/sound/utils
pacstrap /mnt efibootmgr vim dhcpcd pulseaudio

#get part uuid
set PART_UUID=sudo blkid-s UUID -o value /dev/sda2
#add efi entry
efibootmgr --create --disk /dev/sda --part 1 --label "Arch Linux" --loader /vmlinuz-linux --unicode 'root=PARTUUID=$1 rw initrd=\initramfs-linux.img' --verbose
#locale/kb config
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
echo KEYMAP=br-abnt2 >> /etc/vconsole.conf

#date/time config


