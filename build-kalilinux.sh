#!/bin/bash

build-from-nothing () {
sudo apt install -y meson wget build-essential ninja-build cmake-extras cmake gettext gettext-base fontconfig libfontconfig-dev libffi-dev libxml2-dev libdrm-dev libxkbcommon-x11-dev libxkbregistry-dev libxkbcommon-dev libpixman-1-dev libudev-dev libseat-dev seatd libxcb-dri3-dev libvulkan-dev libvulkan-volk-dev  vulkan-validationlayers-dev libvkfft-dev libgulkan-dev libegl-dev libgles2 libegl1-mesa-dev glslang-tools libinput-bin libinput-dev libxcb-composite0-dev libavutil-dev libavcodec-dev libavformat-dev libxcb-ewmh2 libxcb-ewmh-dev libxcb-present-dev libxcb-icccm4-dev libxcb-render-util0-dev libxcb-res0-dev libxcb-xinput-dev xdg-desktop-portal-wlr
sudo apt install -y hwdata nala meson wget build-essential ninja-build cmake-extras cmake gettext gettext-base fontconfig libfontconfig-dev libffi-dev libxml2-dev libdrm-dev libxkbcommon-x11-dev  libliftoff0 libliftoff-dev libxkbregistry-dev libxkbcommon-dev libpixman-1-dev libudev-dev libseat-dev seatd libxcb-dri3-dev libvulkan-dev libvulkan-volk-dev  vulkan-validationlayers-dev libvkfft-dev libgulkan-dev libegl-dev libgles2 libegl1-mesa-dev glslang-tools libinput-bin libinput-dev libxcb-composite0-dev libavutil-dev libavcodec-dev libavformat-dev libxcb-ewmh2 libxcb-ewmh-dev libxcb-present-dev libxcb-icccm4-dev libxcb-render-util0-dev libxcb-res0-dev libxcb-xinput-dev libpango1.0-dev xdg-desktop-portal-wlr xwayland libgbm-dev libgbm1 libdrm-amdgpu1 libdrm-dev libwlroots-dev

mkdir HyprSource
cd HyprSource

## We get Source
wget https://github.com/hyprwm/Hyprland/releases/download/v0.24.1/source-v0.24.1.tar.gz
tar -xvf source-v0.24.1.tar.gz

## We get the building deps that we need to build

wget https://gitlab.freedesktop.org/wayland/wayland-protocols/-/releases/1.31/downloads/wayland-protocols-1.31.tar.xz
tar -xvJf wayland-protocols-1.31.tar.xz

wget https://gitlab.freedesktop.org/wayland/wayland/-/releases/1.22.0/downloads/wayland-1.22.0.tar.xz
tar -xvJf wayland-1.22.0.tar.xz

wget https://gitlab.freedesktop.org/emersion/libdisplay-info/-/releases/0.1.1/downloads/libdisplay-info-0.1.1.tar.xz
tar -xvJf libdisplay-info-0.1.1.tar.xz

wget https://gitlab.freedesktop.org/emersion/libliftoff/-/archive/v0.4.1/libliftoff-v0.4.1.tar.gz
tar -xvpf libliftoff-v0.4.1.tar.gz

## Building libliftoff
cd libliftoff-v0.4.1/

mkdir build &&
cd    build &&

meson setup --prefix=/usr --buildtype=release &&
ninja

sudo ninja install

cd ../..

## Building libdisplay-info

cd libdisplay-info-0.1.1/

mkdir build &&
cd    build &&

meson setup --prefix=/usr --buildtype=release &&
ninja

sudo ninja install

cd ../..

## Building Wayland

cd wayland-1.22.0
mkdir build
cd    build

meson setup ..            \
      --prefix=/usr       \
      --buildtype=release \
      -Ddocumentation=false &&
ninja
sudo ninja install

cd ../..

## Building wayland-protocols

cd wayland-protocols-1.31

mkdir build &&
cd    build &&

meson setup --prefix=/usr --buildtype=release &&
ninja

sudo ninja install

cd ../..

}

## Building Hyprland
build-hyprland () {

chmod a+rw hyprland-source

cd hyprland-source/

sed -i 's/\/usr\/local/\/usr/g' config.mk

### Installing

sudo make install

#deletiing Everything

cd ../..

echo -e "\e[30m NOW YOU HAVE HYPRLAND INSTALLED!!! \e[0m"
echo -e "\e[31m Remember to add \e[0m \n\n misc {\n    suppress_portal_warnings = true \n } \n\n\e[31mto \e[0m hyprland.conf " 
}

if [ -d "HyprSource" ];
then
  cd HyprSource
  build-hyprland
else 
  build-from-nothing
  build-hyprland
fi
