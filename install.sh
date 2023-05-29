#!/bin/bash

read -n1 -rep 'Would you like to install the packages? (Y,n)' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si --noconfirm
    cd ..
    yay -S --answerclean None --answerdiff None --needed - < pkg.lst
    cp -R ./assets/* ~/.config/
    cp -R ./Wallpapers ~/
    chmod +x ~/.config/hypr/scripts/screensharing
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