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
