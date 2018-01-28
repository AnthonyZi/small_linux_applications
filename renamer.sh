#!/bin/bash
echo "renamer <path> [overwrite] [numbers1|numbers2]"

flags=$(echo $@ | cut -d " " -f2-)


if [ -f "$1" ]
then
    files="$1"
else
    if [ -d "$1" ]
    then
        cd $1
        files="*"
    else
        echo "you have to specify a file or path"
        exit
    fi
fi




renameflags=""
overwrite=$(echo ${flags} | grep overwrite)
if [ ! -z "${overwrite}" ]
then
    echo "enabled: forcing overwrite"
    renameflags="${renameflags} -f"
fi

echo "rename${renameflags} Ü->Ue"
rename${renameflags} "s/Ü/Ue/" ${files}
sleep 0.05

echo "rename${renameflags} ü->ue"
rename${renameflags} "s/ü/ue/" ${files}
sleep 0.05

echo "rename${renameflags} Ö->Oe"
rename${renameflags} "s/Ö/Oe/" ${files}
sleep 0.05

echo "rename${renameflags} ö->oe"
rename${renameflags} "s/ö/oe/" ${files}
sleep 0.05

echo "rename${renameflags} Ä->Ae"
rename${renameflags} "s/Ä/Ae/" ${files}
sleep 0.05

echo "rename${renameflags} ä->ae"
rename${renameflags} "s/ä/ae/" ${files}
sleep 0.05

echo "rename${renameflags} ' '->'_'"
rename${renameflags} "y/ /_/" ${files}
sleep 0.05

echo "rename${renameflags} (->_"
rename${renameflags} "y/(/_/" ${files}
sleep 0.05

echo "rename${renameflags} )->_"
rename${renameflags} "y/)/_/" ${files}

echo "rename${renameflags} :->-"
rename${renameflags} "y/:/-/" ${files}

numbers1=$(echo ${flags} | grep numbers1)
if [ ! -z "${numbers1}" ]
then
    echo "add 0 to 1-digit numbers '^X_', '_X_', '_X.abc'"
    rename${renameflags} 's/^([0-9])_/0$1_/' ${files}
    rename${renameflags} 's/_([0-9])_/_0$1_/' ${files}
    rename${renameflags} 's/_([0-9])\.([A-Za-z])/_0$1\.$2/' ${files}
fi

numbers2=$(echo ${flags} | grep numbers2)
if [ ! -z "${numbers2}" ]
then
    echo "add 0 to 1-digit numbers '^X_', '_X_', '_X.abc'"
    rename${renameflags} 's/(^[0-9])_/0$1_/' ${files}
    rename${renameflags} 's/_([0-9])_/_0$1_/' ${files}
    rename${renameflags} 's/_([0-9])\.([A-Za-z])/_0$1\.$2/' ${files}
    echo "add 0 to 2-digit numbers '^XX_', '_XX_', '_XX.abc'"
    rename${renameflags} 's/(^[0-9][0-9])_/0$1_/' ${files}
    rename${renameflags} 's/_([0-9][0-9])_/_0$1_/' ${files}
    rename${renameflags} 's/_([0-9][0-9])\.([A-Za-z])/_0$1\.$2/' ${files}
fi
