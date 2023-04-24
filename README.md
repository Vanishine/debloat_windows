# ✂️ Debloat Windows

[简体中文](./README.zh-Hans.md)

Debloat the latest version of Windows.

## Principles

Do not use any third-party closed-source software other than that provided by Microsoft. The main goal is not to reduce disk space usage (e.g., installation image size and post-installation system size), but to remove unnecessary features (mainly ads) as well as to improve system performance and reduce privacy leaks.

Only the latest MSDN images for Windows 11 and Windows 10 are guaranteed to be supported, other versions may be available but are not supported.

## Steps

> 🛑 The first time you use this PowerShell script, please copy commands from it in small pieces after you have a basic understanding of the commands, otherwise it may be flawed and cause accidental file deletion or other unintended behavior. Once you know the script execution process well, you can automate the execution, grab a cup of coffee and wait for the image to finish debloating.

After starting PowerShell as Administrator, see [Optimize.ps1](Optimize.ps1).

## Tips

### Using a ram disk

You can use [ImDisk](https://sourceforge.net/projects/imdisk-toolkit/) to speed up the build, at least 8GB of space is sufficient. Since ImDisk does not provide some metadata for the disk, you can only create a VHDX inside it to mount the Windows image.

## Questions

How to implement a [reproducible build](https://reproducible-builds.org/)?
