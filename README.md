# My Personal VIM Configuration

## VIM的安装与配置

由于vim在更新迭代的过程中会陆续迭代一些新的功能，非常有效，可以取得和现代编辑器类似的效果，因次，本配置需要安装最新的vim版本以支持这些新功能的使用。并且由于各发行版的系统可能软件包更新不及时，推荐使用下方的方法安装vim。

### Appimage（Linux推荐）

```
# 具体的安装方式见https://github.com/vim/vim-appimage/releases
# 将vim下载到/tmp目录下，下载的链接是当时的最新版本，需要更新当前最新版本的链接，见上一行的releases链接
wget -O /tmp/vim.appimage https://github.com/vim/vim-appimage/releases/download/v9.0.1599/Vim-v9.0.1599.glibc2.29-x86_64.AppImage

# 给vim程序添加可执行权限
chmod +x /tmp/vim.appimage

# 执行vim程序
/tmp/vim.appimage
```
如果出现"dlopen(): error loading libfuse.so.2"错误
```
dlopen(): error loading libfuse.so.2

AppImages require FUSE to run.
You might still be able to extract the contents of this AppImage
if you run it with the --appimage-extract option.
See https://github.com/AppImage/AppImageKit/wiki/FUSE
for more information
```
执行下述命令即可
`sudo apt-get -y install libfuse2`

### Homebrew（Mac推荐）

```
# 安装Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 安装vim
brew install vim
```

### Conda

```
conda install -c conda-forge vim
```

## 安装基本环境

### Node.js

- 手动安装：https://nodejs.org/en/download
- Homebrew安装：`brew install node`
- Conda安装：`conda install -c conda-forge nodejs`
