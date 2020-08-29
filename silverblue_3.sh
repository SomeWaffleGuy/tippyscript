#/bin/sh
#TippyScript: Fedora setup script
#CURRENT VERSION: 32
#USE ON NEWER/OLDER VERSIONS AT OWN RISK
rpm-ostree install steam wine-dxvk unrar cabextract fontconfig
##Use for Intel GPU
#dnf install intel-media-driver
##Use for Nvidia GPU
#dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda vulkan xorg-x11-drv-nvidia-cuda-libs vdpauinfo libva-vdpau-driver libva-utils
#grubby --update-kernel=ALL --args='nvidia-drm.modeset=1'
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
exit 0
