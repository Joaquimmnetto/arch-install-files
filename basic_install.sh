echo "Enabling and installing locale"
echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen  
locale-gen
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf

echo "Datetime/keymapping config" 
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
echo KEYMAP=br-abnt2 >> /etc/vconsole.conf

echo "Enabling multilib repo"
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf 


echo "Installing network/sound/utils"
pacman -Sy efibootmgr git sudo dhcpcd wget pulseaudio pulseaudio-alsa lib32-alsa-plugins lib32-libpulse
rmmod snd_pcm_oss

echo "Enabling dhcpd"
systemctl enable dhcpcd

echo "Please enter root user password"
passwd

echo "Creating new user"
useradd joaquim

