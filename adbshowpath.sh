function adb_search_ip {
    echo "searching for android-device \"$1\""
    ip=$(nmap -sP 192.168.178.0/24 | grep $1 | rev | cut -d " " -f1 | rev | tr -d "(" | tr -d ")")
    if [ -z "$ip" ]
    then
        adb_search_ip $1
    fi
}
###############################################################################

adb_search_ip zmandroid

echo "connecting to: ${ip}"
adb connect ${ip}
sleep 3

echo "logging in as root"
adb root
echo "searching ..."
if [ -z "$2" ]
then
    rootfolder=/storage
    adb shell find "${rootfolder}/" -iname "$1" | tr -d '\015' | while read line
    do
        echo $line
    done
else
    rootfolder=$1
    adb shell find "${rootfolder}/" -iname "$2" | tr -d '\015' | while read line
    do
        echo $line
    done

fi

adb disconnect ${ip}
