#!/bin/bash
# 设置玲珑id
LINGLONG_APPID=io.imsyy.SPlayer
# 设置AppImage下载链接
APPIMAGE_URL=https://github.com/imsyy/SPlayer/releases/download/v3.0.0-beta.3/splayer-3.0.0-beta.3-x86_64.AppImage

# 进入工作目录
cd linglong/sources
# 删除${SOURCES}目录里过时的lib库
rm -f libs/*
# 再删除过时的应用程序库
rm -rf ${LINGLONG_APPID}
# 调用内置的busybox下载AppImage
wget -O target.AppImage ${APPIMAGE_URL}

# 解包AppImage并进入squashfs-root目录
chmod +x target.AppImage && ./target.AppImage --appimage-extract
cd squashfs-root

# 拷贝必需的lib库
cp -a usr/lib/* ../libs
# 删除多余的文件
rm -rf .DirIcon AppRun SPlayer.png SPlayer.desktop usr
# 退回上一级重命名
cd .. && mv squashfs-root ${LINGLONG_APPID}

# 退回玲珑项目根目录
cd ../..

ll-builder build --skip-output-check && ll-builder export --layer -z lzma
