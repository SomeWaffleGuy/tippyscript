# TippyScript
Messy Fedora setup scripts, massively WIP

Should (mostly) work and provide a basic useable system

### Instructions

```
wget https://raw.githubusercontent.com/SomeWaffleGuy/tippyscript/master/workstation.sh
chmod +x workstation.sh
./workstation.sh
```
### Configuration Tips

Celluloid does NOT default to hardware decoding. In order to activate it for Intel/AMD, add the following to 'Extra MPV options'

```
--hwdec=vaapi
```

Or for NVIDIA, add;

```
--hwdec=vdpau
```

Any standard MPV options can be added this way, or with a config file.

Firefox supports hardware acceleration on ALL GPUs, and hardware video decoding on Intel/AMD GPUs. Please see;

https://wiki.archlinux.org/index.php/Firefox#Hardware_video_acceleration

For more information.

NVIDIA users may still wish to enable WebRender despite the lack of video decoding. DO NOT enable MOZ_X11_EGL on NVIDIA until the transparency bug is addressed.
