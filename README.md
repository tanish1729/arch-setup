# Arch Setup
## **Basic Info**
#### **Distro** - Arch Linux
#### **WM** - i3 gaps
#### **Terminal Emulator** - Alacritty
#### **Application Launcher** - Rofi
---
## **Installing Yay**
Assuming Arch and i3 are already installed, we'll first install an AUR helper `yay`. 
> ```$ sudo pacman -S git base-devel```
> 
> ```$ git clone https://aur.archlinux.org/yay.git```
> 
> ```$ cd yay```
> 
> ```$ makepkg -si```
> 
> ```$ rm -rf yay```
---
## **Installing Standard Applications**
Now we'll use Pacman to install some of the commonly used applications along with their dependencies
> ```$ sudo pacman -Syu```
> 
> ```$ sudo pacman -S alacritty firefox gcc lxappearance nemo picom polybar rofi vim```