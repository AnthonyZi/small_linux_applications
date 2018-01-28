devices=""
while read -r line
do
    dev=$(echo "$line" | grep -v NAME | grep -v sda | grep -v sr0 | grep part | cut -d " " -f1 | cut -d "s" -f2)
    if [ ! -z "${dev}" ]
    then
        devices="${devices} s${dev}"
    fi
done < <(lsblk)

not_mounted_devices=""
while read  -r line
do
    current_dev=$(echo "$line" | grep -v '/media')

    not_mounted_dev=""
    for dev in ${devices}
    do
        not_mounted_dev="${not_mounted_dev} $(echo $current_dev | grep ${dev})"
    done

    not_mounted_dev="$(echo ${not_mounted_dev} | cut -d " " -f1 | cut -d "s" -f2)"
    if [ ! -z "${not_mounted_dev}" ]
    then
        not_mounted_devices="${not_mounted_devices} s${not_mounted_dev}"
    fi
done < <(lsblk)
#echo $not_mounted_devices

sudo -v
i=0
for dev in ${not_mounted_devices}
do
    echo "mount $dev to /media/usb$i"

    full_dev="/dev/${dev}"
    mount_point="/media/usb$i"
    sudo mount ${full_dev} ${mount_point}

    i=$(($i+1))
    if [ "$i" == 4 ]
    then
        break
    fi
done
