echo "Datetime/keymapping config" 
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
echo KEYMAP=br-abnt2 >> /etc/vconsole.conf

echo "Installing network/sound/utils"
pacman -Sy efibootmgr git sudo dhcpcd wget pulseaudio pulseaudio-alsa lib32-alsa-plugins lib32-libpulse
rmmod snd_pcm_oss

echo "Enabling dhcpd"
systemctl enable dhcpcd

echo "Creating new user"
useradd joaquim

