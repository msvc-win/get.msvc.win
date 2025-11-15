# get.msvc.win Scripts
This repository served as host of MSVC.win Project.

## Mirroring
We encourage you to mirror this website, you'll need to follow this requirement:

- Replace `get.msvc.win` inside of all scripts into your own domain, and your own domain must use msvc as prefix, like `msvc.example.com`
    - However, you should not replace the script inside of `$OEM$.zip`

## Build
This repository also provide automatically generated offline installers.

If you prefer build yourself, you can follow these procedures:

### Windows (TBD)

### Linux
We assume you're using Debian-based Linux distro (e.g. Ubuntu).

1. Install required dependencies.
```bash
sudo apt-get install aria2 nsis curl
```

2. Build installer.
```bash
# Build installer for Windows XP or newer
curl https://get.msvc.win/generate.sh | bash

# Build installer for Windows 7 or newer
curl https://get.msvc.win/generate.sh | bash -s - win7

# Build installer for Windows 10 or newer
curl https://get.msvc.win/generate.sh | bash -s - win10

# Build all 3 installers at once
curl https://get.msvc.win/generate_all.sh | bash
```

### Contribute
Do you think it needs any improvements? Feel free to create Pull Request.