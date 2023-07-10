# My Personal VIM Configuration

## VIM的安装

由于vim在更新迭代的过程中会陆续迭代一些新的功能，非常有效，可以取得和现代编辑器类似的效果，因次，本配置需要安装最新的vim版本以支持这些新功能的使用。并且由于各发行版的系统可能软件包更新不及时，推荐使用下方的方法安装vim。

### Appimage（Linux推荐）

```
# 具体的安装方式见https://github.com/vim/vim-appimage/releases
# 将vim下载到/tmp目录下，下载的链接是当时的最新版本，需要更新当前最新版本的链接，见上一行的releases链接
mkdir -p ~/.local/bin
wget -O ~/.local/bin/vim https://github.com/vim/vim-appimage/releases/download/v9.0.1599/Vim-v9.0.1599.glibc2.29-x86_64.AppImage

# 给vim程序添加可执行权限
chmod u+x ~/.local/bin/vim
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

## VIM的配置

### 基本环境配置

#### Node.js

- 手动安装：https://nodejs.org/en/download
- Homebrew安装：`brew install node`
- Conda安装：`conda install -c conda-forge nodejs`
- 包管理器安装：`sudo apt install nodejs npm`

### 配置VIM

```
# 到用户目录下
cd ~

# git clone当前的仓库
git clone https://github.com/GoodlPlus/vim.git

# 将文件夹重命名为vim默认的隐藏配置文件名
mv vim .vim

# 进入vim
vim

# 在vim中输入该命令安装默认的vim插件
:InstallPlugin
```

## 自定义安装插件
如果需要自定义安装github中的插件，在pack/offline/start/plugin/plugin/plugin.vim进行配置
```
...
Plugin 'https://github.com/Yggdroot/indentLine'
# 在引号中填入所需要添加插件的github链接
Plugin '{插件github链接}'
...

# 添加的插件必须得在该行之前
call plugin#load_plugin_all()
```
配置完需要加入的plugin信息后，重新进入vim，输入`:InstallPlugin`进行自定义插件安装。此外，除了`InstallPlugin`之外，还支持`:UpdatePlugin`和`:UninstallPlugin`功能，如下介绍所示。
```
# 刚下载配置或者新添加插件地址后安装插件
:InstallPlugin

# 更新插件
:UpdatePlugin

# 在配置中删除插件地址后卸载插件
:UninstallPlugin
```
