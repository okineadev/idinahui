if echo "$OSTYPE" | grep -qE '^linux-android.*'; then
    cd $PREFIX
    sudo=""
else
    cd /usr
    sudo="sudo"
fi

$sudo rm -rf ~/.idinahui bin/idinahui share/idinahui-assets

echo "Програму видалено!"