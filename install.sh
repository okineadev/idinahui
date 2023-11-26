sudo apt update
sudo apt install lolcat cowsay -y

cp idinahui /usr/bin

chmod +x /usr/bin/idinahui

mkdir /usr/share/idinahui
cp text.txt /usr/share/idinahui

idinahui

echo "Заїбав блять"