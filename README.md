# 编译安装 Hyprland 到 Kali Linux
## 使用 `build-kalilinux.sh` 脚本安装 Hyprland
该脚本基于[Ubuntu Guide For Installing And Building Hyprland Gist](https://gist.github.com/Vertecedoc4545/3b077301299c20c5b9b4db00f4ca6000)，详情请参考该项目。
```
chmod +x build-kalilinux.sh
./build-kalilinux.sh
```
## `environment` 文件为部分环境变量配置
```
## 以下为 fcitx 变量配置
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx

## 以下为 wayland 相关配置
QT_QPA_PLATFORM="wayland;xcb"
QT_AUTO_SCREEN_SCALE_FACTOR=1
QT_WAYLAND_DISABLE_WINDOWDECORATION=1
QT_QPA_PLATFORMTHEME=qt5ct
SDL_VIDEODRIVER=wayland
GDK_BACKEND="wayland,x11"
WLR_RENDERER=vulkan
MOZ_ENABLE_WAYLAND=1
```
## `config` 文件夹为 hyprland 及 waybar 等相关配置，复制到`～/.config/`目录下使用
若使用本项目提供的配置文件，可能需要安装以下工具
```
## 安装输入法
sudo apt install fcitx5 fcitx5-chinese-addons fcitx5-config-qt
## 安装终端
sudo apt install alacritty
## 安装状态栏工具
sudo apt install waybar
## 安装应用启动工具
sudo apt install wofi
## 安装桌面背景配置工具
sudo apt install swaybg
## 安装音频服务及插件
sudo apt install pipewire wireplumber pipewire-pulse pipewire-jack pipewire-alsa pipewire-audio pulsemixer
## 安装文件管理器
sudo apt install pcmanfm
```
## 已知问题
1. 录屏截屏暂时无法使用，可能与源中自带的qt库有关
