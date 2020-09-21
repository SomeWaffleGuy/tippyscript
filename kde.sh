#/bin/bash
#TippyScript: Fedora KDE setup script
#CURRENT VERSION: 32
#USE ON NEWER/OLDER VERSIONS AT OWN RISK
echo "$(tput setaf 2)$(tput bold)This script will configure a fresh install of Fedora Workstation to be what I consider a useable desktop. This includes$(tput sgr 0)$(tput setaf 1)$(tput bold) NON-FREE SOFTWARE AND DRIVERS$(tput sgr 0)$(tput setaf 2)$(tput bold) and suggests software which may be subject to restrictions under local law. $(tput sgr 0)"
echo -n "$(tput setaf 2)$(tput bold)Continue? 
(y/N)$(tput sgr 0) "
read answer
if echo "$answer" | grep -iq "^y" ;then
  echo "$(tput setaf 2)$(tput bold)Checking for system updates...$(tput sgr 0)"
  sudo dnf -y upgrade
  echo "$(tput setaf 2)$(tput bold)Making sure prerequisites are installed...$(tput sgr 0)"
  sudo dnf -y install wget cabextract xorg-x11-font-utils fontconfig
  echo "$(tput setaf 2)$(tput bold)Downloading and installing RPM Fusion and MS Core Fonts...$(tput sgr 0)"
  wget https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
  sudo dnf -y install *.rpm
  rm *.rpm
  echo "$(tput setaf 2)$(tput bold)Setting up basic multimedia functionality...$(tput sgr 0)"
  sudo dnf -y groupupdate core
  sudo dnf -y upgrade
  sudo dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
  sudo dnf -y groupupdate sound-and-video
  echo "$(tput setaf 2)$(tput bold)Installing typical applications...$(tput sgr 0)"
  sudo dnf -y install wine-dxvk breeze-gtk unrar zip curl mpv youtube-dl mozilla-openh264 compat-ffmpeg28 ffmpeg-libs libva-utils ffmpegthumbs neofetch gstreamer1-vaapi vulkan gdouros-symbola-fonts google-noto-emoji-fonts google-noto-emoji-color-fonts google-android-emoji-fonts
  echo -n "$(tput setaf 2)$(tput bold)Install 'tainted' RPM Fusion repositories? 
$(tput sgr 0)$(tput setaf 1)$(tput bold)REPOS CONTAIN SOFTWARE WITH LEGAL RESTRICTIONS $(tput sgr 0)$(tput setaf 2)$(tput bold)
(y/N)$(tput sgr 0) "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    sudo dnf -y install rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
    echo -n "$(tput setaf 2)$(tput bold)Enable DVD playback? 
$(tput sgr 0)$(tput setaf 1)$(tput bold)LEGAL RESTRICTIONS MAY APPLY (E.g. in the USA)$(tput sgr 0)$(tput setaf 2)$(tput bold) 
(y/N)$(tput sgr 0) "
    read answer
    if echo "$answer" | grep -iq "^y" ;then
      sudo dnf -y install libdvdcss
    fi
  fi
  echo -n "$(tput setaf 2)$(tput bold)Install Gaming Software (Steam, Lutris)? 
(y/N)$(tput sgr 0) "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    sudo dnf -y install steam lutris
  fi
  echo -n "$(tput setaf 2)$(tput bold)Install Nextcloud Client? 
(y/N)$(tput sgr 0) "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    sudo dnf -y install nextcloud-client
  fi
  echo -n "$(tput setaf 2)$(tput bold)Select your GPU
1: Intel
2: AMD
3: NVIDIA
4: Other/FOSS Drivers
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
  echo -n "$(tput setaf 2)$(tput bold)Enable S32LE in PulseAudio? (Generally fine for modern systems, skip if unsure) 
(y/N)$(tput sgr 0) "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    sudo sed -i "s/; default-sample-format = s16le/default-sample-format = s32le/g" /etc/pulse/daemon.conf
    sudo sed -i "s/; resample-method = speex-float-1/resample-method = speex-float-10/g" /etc/pulse/daemon.conf
    sudo sed -i "s/; avoid-resampling = false/avoid-resampling = true/g" /etc/pulse/daemon.conf
  fi
  echo "$(tput setaf 2)$(tput bold)Enabling Flathub$(tput sgr 0)"
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  echo "$(tput setaf 2)$(tput bold)RESTART REQUIRED TO COMPLETE SETUP$(tput sgr 0)"
fi
exit 0
