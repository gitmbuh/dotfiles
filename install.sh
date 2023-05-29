#!/bin/bash

read -n1 -rep 'Would you like to install the packages? (Y,n)' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    yay -S --noconfirm --needed - < pkg.lst
    cp -R ./assets/* ~/.config/
    cp -R ./Wallpapers ~/
    chmod +x ~/.config/hypr/scripts/XDPH
fi

read -n1 -rep 'Would you like to enable SDDM autologin? (Y,n)' SDMM
if [[ $SDMM == "Y" || $SDMM == "y" ]]; then
    LOC="/etc/sddm.conf"
    echo -e "[Autologin]\nUser = $(whoami)\nSession=hyprland" | sudo tee -a $LOC
    sudo systemctl enable sddm
    sleep 3
    reboot
else
    sudo systemctl enable sddm
    sleep 3
    reboot
fi
