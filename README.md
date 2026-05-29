# Dotfiles
### General
i'm using these below:
+ OS: Ubuntu 26 LTS
+ WM: i3
+ Terminal: alacritty
+ Shell: zsh
### Instructions
<p> dependencies</p>

``` bash
sudo apt update
sudo apt install \ 
xorg i3 i3status i3lock dmenu \
alacritty rofi dunst libnotify-bin \
pipewire pipewire-pulse wireplumber pavucontrol pulseaudio-utils \
network-manager network-manager-gnome blueman brightnessctl acpi \
nautilus gvfs gvfs-backends gvfs-fuse file-roller \
feh lxappearance gnome-themes-extra papirus-icon-theme \
fonts-firacode fonts-noto fonts-noto-color-emoji \
flameshot xclip xsel copyq \
xss-lock picom git zsh

```
### Note that:
The command above is sufficient for :
- Terminal
- App launcher
- Notification
- sound
- Wi-Fi
- Bluetooth
- Brightness
- File manager
- Screenshot
- Font
- Wallpaper
- Compositor
### Change Shell
``` zsh 
chsh -s $(which zsh) 
```