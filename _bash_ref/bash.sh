## BASH commands ##

__bash terminal hotkeys__
Arrow up/down: should previous/next commands from history

Ctrl + A: go to beginning of line
Ctrl + E: end of line

Ctrl + K: delete to end of line
Ctrl + U: delete to beginning of line

Ctrl + R: Search history backwards
Ctrl + S: Search history forward
Ctrl + O - Run command found using ctrl + R

__bash file commands
less <file>         - view file contents
head <file>         - show top 10 lines
tail <file>         - show end of file
cat <file>          - output all data in file
cat text1.txt text2.txt -> results.txt - output content of 2 files to results.txt
grep word test.txt  - find lines containing "word" in test.txt
cut -f 2-5 <file>   - cuts columns 2-5
touch <file>        - create empty file

__bash find files, execute command
find . -name projects -exec realpath {} \;
find . -name projects -exec ls -alh {} \;

__bash for loop
array=$(ls)
for var in ${array[@]}
do
    echo "$var"
done

__bash loop over two arrays
array=($(seq 1 1 20))
array2=(A C D E F G H I K L M N P Q R S T V W Y)

for index in ${!array[*]}; do
  echo "${array[$index]} is in ${array2[$index]}"
done

__bash find and kill process
# Find ID for the given process, e.g. Chrome
pgrep chrome
kill -9 <ID>

# Kill all processes with given name, e.g. Chrome
pkill -f chrome
