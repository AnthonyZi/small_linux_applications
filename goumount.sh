sudo -v

function um {
    isMounted=$(lsblk | grep "/media/usb$1")
    if [ ! -z "$isMounted" ]
    then
        echo "umount /media/usb$1"
        sudo umount /media/usb$1
    fi
}
if [ -z "$1" ]
then
    um 0
    um 1
    um 2
    um 3
else
    um $1
fi
