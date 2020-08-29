#/bin/sh
#TippyScript: Fedora setup script
#CURRENT VERSION: 32
#USE ON NEWER/OLDER VERSIONS AT OWN RISK
rpm-ostree install steam wine-dxvk unrar cabextract libdvdcss mozilla-openh264 compat-ffmpeg28 ffmpeg-libs libva-utils neofetch nextcloud
##Use for laptop
#rpm-ostree install powertop tlp thermald
##Use for ThinkPad
#rpm-ostree install thinkfan
##Use for Intel GPU
#rpm-ostree install intel-media-driver
##Use for Nvidia GPU
#rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia-cuda vulkan xorg-x11-drv-nvidia-cuda-libs vdpauinfo libva-vdpau-driver
#grubby --update-kernel=ALL --args='nvidia-drm.modeset=1'
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
exit 0
