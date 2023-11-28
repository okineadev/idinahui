#!/bin/bash

echo "Розпочинаємо установку..."

# Змінні
is_android=false

sudo="sudo"
update="update"
install="install -y"

if echo "$OSTYPE" | grep -qE '^linux-gnu.*' && [ -f '/etc/debian_version' ]; then
    pkgmgr="apt"

elif echo "$OSTYPE" | grep -qE '^linux-gnu.*' && [ -f '/etc/arch-release' ]; then
    pkgmgr="pacman"
    install="-Sy --noconfirm"
    update="-Sy"

# elif echo "$OSTYPE" | grep -qE '^darwin.*'; then
#     pkgmgr="brew"
#     install="install"
#     if ! command -v brew >/dev/null; then
# 		ruby <(curl -fsSk https://raw.github.com/mxcl/homebrew/go)
# 	fi

elif echo "$OSTYPE" | grep -qE '^linux-android.*'; then
    pkgmgr="pkg"
    is_android=true

    # Т.к в Termux не використовується sudo - ми його й тут
    # не будемо використовувати
    sudo=""

else
    echo "Платформа не підтримується."
    exit 1
fi

if ! command -v cowsay &> /dev/null || ! command -v lolcat &> /dev/null ; then
    echo "Встановлення cowsay та lolcat..."

    $sudo $pkgmgr $update

    if [[ $is_android == true ]]; then
        $pkgmgr $install cowsay ruby wget patch
        patch -p1 $PREFIX/bin/cowsay cowsay.patch
        wget https://github.com/busyloop/lolcat/archive/master.zip
        unzip master.zip && rm master.zip
        cd lolcat-master/bin
        gem install lolcat
        cd ../..

    else
        sudo $pkgmgr $install cowsay lolcat
    fi
fi

echo "Встановлення..."
# Копіювання файлів та налаштування прав доступу
if [[ $is_android == true ]]; then
    usr=$PREFIX
else
    usr=/usr
fi

$sudo cp idinahui $usr/bin
$sudo cp -r idinahui-assets $usr/share

# Створення папки .idinahui та копіювання uninstall.sh
$sudo mkdir -p ~/.idinahui
$sudo cp uninstall.sh ~/.idinahui
$sudo chmod +x ~/.idinahui/uninstall.sh $usr/bin/idinahui

echo "Установку завершено!"

idinahui
