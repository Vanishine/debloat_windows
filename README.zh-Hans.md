# ✂️ Debloat Windows

精简最新版本的 Windows 系统。

## 原则

不使用除了微软提供的任何其他第三方的闭源软件。主要目标不是为了减少磁盘空间占用（如安装镜像大小和安装后系统大小），而是为了删除不必要的功能（主要是广告）以及提高系统性能和减少隐私泄露。

只保证对最新的 Windows 11 和 Windows 10 的 MSDN 镜像可用，其他版本或许可用但不在支持的范围内。

## 精简步骤

> 🛑 第一次使用该脚本，请在基本理解命令后一小段一小段地复制到 PowerShell 中执行，否则可能会因为存在缺陷造成误删文件或其他意料之外的行为。在对脚本脚本的执行流程基本清楚后可用来自动化执行，倒上一杯咖啡，等待系统精简完成。

使用管理员身份启动 PowerShell 后，见 [Optimize.ps1](Optimize.ps1)。

## 提示

### 使用内存盘

可以使用 [ImDisk](https://sourceforge.net/projects/imdisk-toolkit/) 来加快构建速度，保证至少 8GB 的空间就已经足够。由于 ImDisk 没有提供磁盘的一些元数据，因此只能在其内部创建一个 VHDX 来挂载 Windows 镜像。

## 问题

如何实现 [可重现的构建](https://reproducible-builds.org/)？
