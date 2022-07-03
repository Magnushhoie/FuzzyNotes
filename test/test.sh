#!/bin/bash
# FuzzyNotes test
# https://github.com/Magnushhoie/FuzzyNotes

#set -e
shopt -s expand_aliases

# Set directory variables
script_path="${BASH_SOURCE[0]}"
script_dir="$(cd "$(dirname "$script_path")" && pwd -P)"
main_dir=$(dirname $script_dir)
tmp_dir=$script_dir/tmp
mkdir -p $tmp_dir
echo $main_dir $tmp_dir

# Set log files
test_results=$script_dir/test_results
test_logfile=$tmp_dir/test.log

# Cleanup and reset tmp directory
if ! [ -z "${tmp_dir}" ] && [ -d "$tmp_dir" ]
    then echo "Deleting files in" "${tmp_dir}"
    rm -r $tmp_dir/*  2> /dev/null
fi

# Delete+Create new log files
rm -f $test_results 2> /dev/null
rm -f $test_logfile 2> /dev/null
touch $test_results
touch $test_logfile

# Copy project files to tmp directory
cp -r $main_dir/src $main_dir/_FuzzyNotes $tmp_dir
cp $main_dir/setup.sh $tmp_dir/
cp $script_dir/test_config.txt $tmp_dir/config.txt

#
# test setup.sh, install script
#

# Run install script
echo "Sourcing $tmp_dir/setup.sh"
source $tmp_dir/setup.sh > $test_logfile 2>&1

# Check install folder
V=$(grep 'tmp/_FuzzyNotes' $test_logfile | wc -l | awk '{print $1}')
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
alias fz=$tmp_dir/src/fz.sh
alias fze=$tmp_dir/src/fze.sh


#
# test fze, search script
#

# fz search with keywords
#V=$(fz "notes" | wc | awk '{print $1}')
#if [ "$V" -gt "10" ]; then
#    echo "3. PASS: fz search keywords" >> $test_results
#else
#    echo "3. FAIL: fz search keywords" >> $test_results
#fi

# fz --list
V=$(fz --list | grep "Available" | wc -l | awk '{print $1}')
if [ "$V" -eq "1" ]; then
    echo "4. PASS: fz --list" >> $test_results
else
    echo "4. FAIL: fz --list" >> $test_results
fi

# fz --help
V=$(fz --help | grep "Example usage:" | wc -l | awk '{print $1}')
if [ "$V" -eq "1" ]; then
    echo "5. PASS: fz --help" >> $test_results
else
    echo "5. FAIL: fz --help" >> $test_results
fi

# fz --open
open() {
    echo "$@"
}
export -f open
V=$(fz --open | grep "FuzzyNotes" | wc -l | awk '{print $1}')
if [ "$V" -gt "0" ]; then
    echo "6. PASS: fz --open" >> $test_results
else
    echo "6. FAIL: fz --open" >> $test_results
fi

# fz --config
V=$(fz --config | grep "config.txt" | wc -l | awk '{print $1}')
if [ "$V" -gt "0" ]; then
    echo "7. PASS: fz --config" >> $test_results
else
    echo "7. FAIL: fz --config" >> $test_results
fi


#
# test fze, editor search/edit
#

# fze without keywords
vim() {
    echo "$@"
}
export -f vim

#V=$(fze | wc | awk '{print $1}')
#if [ "$V" -eq "2" ]; then
#    echo "8. PASS: fze no keywords" >> $test_results
#else
#    echo "8. FAIL: fze no keywords" >> $test_results
#fi

# fze with keywords
V=$(fze notes | grep "notes" | wc | awk '{print $1}')
if [ "$V" -gt "0" ]; then
    echo "9. PASS: fze search keywords" >> $test_results
else
    echo "9. FAIL: fze search keywords" >> $test_results
fi

# fze create new file
V=$(fze --new new_file.txt | grep "new_file.txt" | wc -l | awk '{print $1}')
if [ "$V" -eq "2" ]; then
    echo "10. PASS: fze new file creation" >> $test_results
else
    echo "10. FAIL: fze new file creation" >> $test_results
fi

V=$(fze python | grep "python.py" | wc -l | awk '{print $1}')
if [ "$V" -eq "2" ]; then
    echo "11. PASS: fze alternative file" >> $test_results
else
    echo "11. FAIL: fze alternative file" >> $test_results
fi

# Display test results
cat $test_results
