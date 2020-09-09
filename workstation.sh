#/bin/bash
#TippyScript: Fedora setup script
#CURRENT VERSION: 32
#USE ON NEWER/OLDER VERSIONS AT OWN RISK
echo "$(tput setaf 2)$(tput bold)This script will configure a fresh install of Fedora Workstation to be what I consider a useable desktop. This includes Non-Free software and drivers. For best results, run on an up-to-date system.$(tput sgr 0)"
echo -n "$(tput setaf 2)$(tput bold)Continue? (Y/N)$(tput sgr 0) "
read answer
if echo "$answer" | grep -iq "^y" ;then
  echo "$(tput setaf 2)$(tput bold)Uninstalling useless GNOME parts$(tput sgr 0)"
  sudo dnf -y remove gnome-maps gnome-boxes totem gnome-photos libreoffice*
  echo "$(tput setaf 2)$(tput bold)Making sure wget and font prerequisites are installed$(tput sgr 0)"
  sudo dnf -y install wget cabextract xorg-x11-font-utils fontconfig
  echo "$(tput setaf 2)$(tput bold)Downloading and installing RPMFusion and MS Fonts$(tput sgr 0)"
  wget https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  wget https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  wget https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
  sudo dnf -y install *.rpm
  rm *.rpm
  sudo dnf -y upgrade
  echo "$(tput setaf 2)$(tput bold)Setting up basic multimedia functionality$(tput sgr 0)"
  sudo dnf -y groupupdate core
  sudo dnf -y upgrade
  sudo dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
  sudo dnf -y groupupdate sound-and-video
  echo "$(tput setaf 2)$(tput bold)Adding RPMFusion tainted repos$(tput sgr 0)"
  sudo dnf -y install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
  sudo dnf -y install wine-dxvk gnome-tweaks gnome-shell-extension-appindicator unrar zip curl celluloid youtube-dl mozilla-openh264 compat-ffmpeg28 ffmpeg-libs libdvdcss libva-utils ffmpegthumbnailer neofetch gstreamer1-vaapi vulkan gdouros-symbola-fonts google-noto-emoji-fonts google-noto-emoji-color-fonts google-android-emoji-fonts
  echo -n "$(tput setaf 2)$(tput bold)Install Gaming Software (Steam, Lutris, Discord)? (Y/N)$(tput sgr 0) "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    sudo dnf -y install steam lutris discord
  fi
  echo -n "$(tput setaf 2)$(tput bold)Install Nextcloud Client? (Y/N)$(tput sgr 0) "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    sudo dnf -y install nextcloud-client
  fi
  echo -n "$(tput setaf 2)$(tput bold)Select your GPU
1: Intel
2: AMD
3: NVIDIA
$(tput sgr 0)"
  read answer
  if echo "$answer" | grep -iq "^1" ;then
    sudo dnf -y install intel-media-driver mesa-vulkan-drivers libvdpau-va-gl
  elif echo "$answer" | grep -iq "^2" ;then
    sudo dnf -y install xorg-x11-drv-amdgpu mesa-vulkan-drivers
    echo "$(tput setaf 2)$(tput bold)Additional configuration may be required to use the AMDGPU driver. I do not have a modern AMD GPU for testing.$(tput sgr 0) "
  elif echo "$answer" | grep -iq "^3" ;then
    sudo dnf -y install akmod-nvidia xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-cuda-libs vdpauinfo libva-vdpau-driver
  fi
  echo "$(tput setaf 2)$(tput bold)Enabling Flathub$(tput sgr 0)"
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  echo -n "$(tput setaf 2)$(tput bold)Enable S32LE in PulseAudio? (Generally fine for modern systems, skip if unsure) (Y/N)$(tput sgr 0) "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    sudo sed -i "s/; default-sample-format = s16le/default-sample-format = s32le/g" /etc/pulse/daemon.conf
    sudo sed -i "s/; resample-method = speex-float-1/resample-method = speex-float-10/g" /etc/pulse/daemon.conf
    sudo sed -i "s/; avoid-resampling = false/avoid-resampling = true/g" /etc/pulse/daemon.conf
  fi
  busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting…")'
  echo "$(tput setaf 2)$(tput bold)Making GNOME more useable...$(tput sgr 0)"
  gnome-extensions disable background-logo@fedorahosted.org
  gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
  gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing 'rgba'
  gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
  gsettings set org.gnome.desktop.interface clock-show-date 'true'
  gsettings set org.gnome.desktop.interface clock-show-weekday 'true'
  gsettings set org.gnome.desktop.interface enable-hot-corners 'false'
  gsettings set org.gnome.desktop.interface show-battery-percentage 'true'
  gsettings set org.gnome.desktop.interface clock-format '12h'
  gsettings set org.gnome.nautilus.preferences show-create-link 'true'
  gsettings set org.gnome.nautilus.preferences thumbnail-limit '4096'
  gsettings set org.gnome.nautilus.icon-view default-zoom-level 'standard'
  echo -n "$(tput setaf 2)$(tput bold)Use dark theme? (Y/N)$(tput sgr 0) "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
  fi
  echo "$(tput setaf 2)$(tput bold)NOTE: Firefox supports hardware acceleration on ALL GPUs and hardware accelerated video on Intel/AMD since version 80. Please refer to:
https://wiki.archlinux.org/index.php/Firefox#Hardware_video_acceleration
For more information on enabling it (WebRender is worth enabling even on NVIDIA)$(tput sgr 0) "
fi
exit 0
