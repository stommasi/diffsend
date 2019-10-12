#!/bin/bash

path_file="$1"
base_file="${path_file##*/}"
temp_file="/tmp/${base_file}.tmp"
diff_file="/tmp/${base_file}.diff"
email="sean.tommasi@gmail.com"

if [ -e "$temp_file" ]; then
    diff <(grep "$2" "$temp_file") <(grep "$2" "$path_file") > "$diff_file"
else
    cp "$path_file" "$temp_file"
    exit 0
fi

if [ $? -ne 0 ]; then
    mutt -s "${base_file} update" $email < "$diff_file"
fi

cp "$path_file" "$temp_file"
