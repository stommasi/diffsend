#!/bin/bash

# diffsend - compare file to last time script was run and email diff report
#
# This script takes a filename, a regular expression, and an email address as
# arguments. If the file has never been checked before, the script makes a copy
# of it in /tmp and exits. On the next run, it checks to see if lines matching
# the regular expression have been added or removed from the file in the
# meantime, i.e. it checks for updates in regards to a particular matching
# string. If there is a difference, the diff report is emailed to the specified
# address. This is useful for monitoring log files.

path_file="$1"
regex="$2"
email="$3"

base_file="${path_file##*/}"
temp_file="/tmp/${base_file}.tmp"
diff_file="/tmp/${base_file}.diff"

if [ -e "$temp_file" ]; then
    diff <(grep -P "$regex" "$temp_file") <(grep -P "$regex" "$path_file") > "$diff_file"
    if [ $? -ne 0 ]; then
        mutt -s "${base_file} update" "$email" < "$diff_file"
    fi
fi

cp "$path_file" "$temp_file"
