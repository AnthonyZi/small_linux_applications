function get_ip_mask {
    ip_addr_mask=$(ip addr show | grep wlan0 -A5 | grep "inet " | tr -d "inet" | tr -d " " | cut -d "/" -f1 | cut -d "." -f4 --complement)
    ip_addr_mask="${ip_addr_mask}.0/24"
    echo "searching with mask: ${ip_addr_mask}"
}

function search_adb_ip {
    echo "searching for android-device \"$1\""
    ip=$(nmap -sP 192.168.178.0/24 | grep $1 | rev | cut -d " " -f1 | rev | tr -d "(" | tr -d ")")
    if [ -z "$ip" ]
    then
        search_adb_ip $1
    fi
}


function sync_folder {
#    echo "sync_folder: $1 $2"
    # some errors may not occur if transfer is slowed down
    sleep 0.1
    SRC_1=$1
    DST_1=$2
    DST_CUT_1=$(echo ${DST_1} | rev | cut -d "/" -f1 --complement | rev)
    SRCX_1=$(echo ${SRC_1} | rev | cut -d "/" -f1 | rev)
    DST_LIST_1=$(adb shell ls ${DST_CUT_1} | tr -d '\015')
    DST_LIST_GREP_1=$(echo ${DST_LIST_1} | grep "${SRCX_1}")

    # rename file for convention:
    renamer.sh ${SRC_1} overwrite numbers1 &>/dev/null

    if [ -z "$DST_LIST_GREP_1" ]
    then
#        echo "++++ ${SRCX_1}"
        echo "+++d ${DST_1}"
        adb push ${SRC_1} ${DST_1}
    else
        update_folder ${SRC_1} ${DST_1}
    fi
}

function sync_file {
#    echo "sync_file: $1 $2"
    SRC_2=$1
    DST_2=$2
    SRCX_2=$(echo ${SRC_2} | rev | cut -d "/" -f1 | rev)
    DST_LIST_2=$(adb shell ls ${DST_2} | tr -d '\015')
    DST_LIST_GREP_2=$(echo ${DST_LIST_2} | grep "${SRCX_2}")
    if [ -z "$DST_LIST_GREP_2" ]
    then
#        echo "++++ ${SRCX_2}"
        echo "+++f ${DST_2}/${SRCX_2}"
        # rename file for convention:
        renamer.sh ${SRC_2} overwrite numbers1 &>/dev/null
        adb push ${SRC_2} ${DST_2}
    else
#        echo "sync ${SRCX_2} ..."
#        echo "sync ${DST_2}/${SRCX_2}"
        update_file ${SRC_2} ${DST_2}
    fi
}

function update_folder {
#    echo "update_folder: $1 $2"
    SRC_3=$1
    DST_3=$2
    delete_old_files_in_folder ${SRC_3} ${DST_3}
    for path in ${SRC_3}/*
    do
        path_append=$(echo ${path} | rev | cut -d "/" -f1 | rev)
        if [ -d "$path" ]
        then
            sync_folder ${path} ${DST_3}/${path_append}
        else
            sync_file ${path} ${DST_3}
        fi
        DST_3=$2
    done
}

function update_file {
#    echo "update_file: $1 $2"
    SRC_4=$1
    DST_4=$2
    SRC_STAT_4=$(stat -c %y ${SRC_4})
    DST_STAT_4=$(adb shell stat -c %y ${DST_4})
    SRCX_4=$(echo ${SRC_4} | rev | cut -d "/" -f1 | rev)
    if [[ "$SRC_STAT_4" > "$DST_STAT_4" ]]
    then
#        echo "updt ${SRCX_4}"
        echo "updt ${DST_4}/${SRCX_4}"
        # rename file for convention:
        renamer.sh ${SRC_4} overwrite numbers1 &>/dev/null
        adb push ${SRC_4} ${DST_4}
    fi
}

function delete_old_files_in_folder {
#    echo "delete_old_files_in_folder: $1 $2"
    SRC_5=$1
    DST_5=$2
    future_files=$(ls ${SRC_5})
    current_files=$(adb shell ls ${DST_5} | tr -d '\015')
    for file in ${current_files}
    do
        grepped=$(echo ${future_files} | grep "${file}")
        if [ -z "$grepped" ]
        then
#            echo "remv ${file}"
            echo "remv ${DST_5}/${file}"
            adb shell rm -r ${DST_5}/${file}
        fi
    done
}
###############################################################################

if [ -z $1 ]
then
    get_ip_mask
    search_adb_ip zmandroid
else
    ip=$1
fi

echo "connecting to: $ip"
adb connect $ip
sleep 3

echo "start syncronisation"
documents_dir=/home/user/documents
adb_documents_dir=/storage/SDCARD_ID/PDFs

time_management_file=${documents_dir}/organisation/time_management.pdf
time_management_destination=${adb_documents_dir}
echo "-------- $time_management_file --------"
sync_file ${time_management_file} ${time_management_destination}



uni_sync_source=${documents_dir}/university
uni_sync_destination=${adb_documents_dir}/rwth
uni_sync_folders="digitale_bildverarbeitung artificial_intelligence elektrotechnik3 robotik"
for subject in $uni_sync_folders
do
    echo "-------- $subject --------"
    sync_folder ${uni_sync_source}/${subject} ${uni_sync_destination}/${subject}
done


echo "disconnecting ${ip}"
adb disconnect $ip
