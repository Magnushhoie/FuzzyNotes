#!/bin/bash
# bash_notes test
# https://github.com/Magnushhoie/bash_notes

#set -e
shopt -s expand_aliases


# Set directory variables
script_path="${BASH_SOURCE[0]}"
script_dir="$(cd "$(dirname "$script_path")" && pwd -P)"
tmp_dir=$script_dir/tmp
main_dir=$(dirname $script_dir)

# Set log files
test_results=$script_dir/test_results
test_logfile=$tmp_dir/test.log

# Cleanup and reset tmp directory
if ! [ -z "${tmp_dir}" ] && [ -d "$tmp_dir" ]
    then echo "Deleting files in" "${tmp_dir}"
    rm -r $tmp_dir/*
fi

# Delete+Create new log files
rm -f $test_results
rm -f $test_logfile
touch $test_results
touch $test_logfile

# Copy project files to tmp directory
mkdir -p $tmp_dir
cp -r $main_dir/src $tmp_dir
cp $main_dir/setup.sh $tmp_dir/
cp $main_dir/references.txt $tmp_dir/
cp $script_dir/test_config.txt $tmp_dir/config.txt

#
# test setup.sh, install script
#

# Run install script
source $tmp_dir/setup.sh > $test_logfile 2>&1
cp $main_dir/references.txt $notes_folder/second_file.txt


# Check install folder
V=$(grep 'tmp/_bash_notes' $test_logfile | wc -l | awk '{print $1}')
if [[ $V == '2' ]]; then 
    echo "1. PASS: Correct test install folder" >> $test_results
else 
    echo "1. FAIL: Wrong test install folder" >> $test_results
fi 

# Check install complete
V=$(grep 'Done!' $test_logfile)
if [[ $V == 'Done!' ]]; then 
    echo "2. PASS: Install complete" >> $test_results
else 
    echo "2. FAIL: Install failed" >> $test_results
fi 

# setup aliases manually
alias ref=$tmp_dir/src/ref.sh
alias refe=$tmp_dir/src/refe.sh


#
# test ref, search script
#

# ref search with keywords
V=$(ref This is your references.txt file | wc | awk '{print $1}')
if [ "$V" -gt "10" ]; then
    echo "3. PASS: ref search keywords" >> $test_results
else
    echo "3. FAIL: ref search keywords" >> $test_results
fi

# ref --list
V=$(ref --list | grep "references" | wc -l | awk '{print $1}')
if [ "$V" -eq "1" ]; then
    echo "4. PASS: ref --list" >> $test_results
else
    echo "4. FAIL: ref --list" >> $test_results
fi

# ref --help
V=$(ref --help | grep "Example usage:" | wc -l | awk '{print $1}')
if [ "$V" -eq "1" ]; then
    echo "5. PASS: ref --help" >> $test_results
else
    echo "5. FAIL: ref --help" >> $test_results
fi

# ref --open
open() {
    echo "$@"
}
export -f open
V=$(ref --open | grep "references.txt" | wc -l | awk '{print $1}')
if [ "$V" -gt "0" ]; then
    echo "6. PASS: ref --open" >> $test_results
else
    echo "6. FAIL: ref --open" >> $test_results
fi

# ref --config
V=$(ref --config | grep "config.txt" | wc -l | awk '{print $1}')
if [ "$V" -gt "0" ]; then
    echo "7. PASS: ref --config" >> $test_results
else
    echo "7. FAIL: ref --config" >> $test_results
fi


#
# test refe, editor search/edit
#

# refe without keywords
vim() {
    echo "$@"
}
export -f vim

V=$(refe | wc | awk '{print $1}')
if [ "$V" -eq "2" ]; then
    echo "8. PASS: refe no keywords" >> $test_results
else
    echo "8. FAIL: refe no keywords" >> $test_results
fi

# refe with keywords
V=$(refe references.txt | grep "set hlsearch" | wc | awk '{print $1}')
if [ "$V" -gt "0" ]; then
    echo "9. PASS: refe search keywords" >> $test_results
else
    echo "9. FAIL: refe search keywords" >> $test_results
fi

# refe create new file require .txt
#V=$(refe --new new_file | grep "must end with .txt" | wc | awk '{print $1}')
#if [ "$V" -eq "1" ]; then
#    echo "10. PASS: refe new file expected error message" >> $test_results
#else
#    echo "10. FAIL: refe new file expected error message" >> $test_results
#fi

# refe create new file
V=$(refe --new new_file.txt | grep "new_file.txt" | wc -l | awk '{print $1}')
if [ "$V" -eq "2" ]; then
    echo "10. PASS: refe new file creation" >> $test_results
else
    echo "10. FAIL: refe new file creation" >> $test_results
fi

V=$(refe second_file | grep "second_file.txt" | wc -l | awk '{print $1}')
if [ "$V" -eq "2" ]; then
    echo "11. PASS: refe alternative file" >> $test_results
else
    echo "11. FAIL: refe alternative file" >> $test_results
fi

# Display test results
cat $test_results