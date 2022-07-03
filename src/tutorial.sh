# FuzzyNotes tutorial

# Initialize
script_path="${BASH_SOURCE[0]}"
script_dir="$(cd "$(dirname "$script_path")" && pwd -P)"
main_dir=$(dirname $script_dir)
source $main_dir/config.txt
clear

# Interactive practice function
function practice () {
  target1="$1"
  target2="$2"

  echo
  echo "Try running: $target1"
  read -p "" input
  while [[ "$input" != "$target1" && "$input" != "$target2" ]]
  do
      echo "Invalid, please try entering $target1 ..."
      echo "( or exit tutorial with CTRL+C )"
      read -p "" input
  done
  echo
}

function next_step () {
  echo "Well done!"
  read -p "Press enter to continue ..."
  clear
}

# Tutorial steps
#
cat <<EOF
# Two minute FuzzyNotes tutorial, by Magnus H. Høie
# https://github.com/Magnushhoie/FuzzyNotes

1 of 6: fz --list

fz allows you to interactively search all your note files
( in $notes_folder )

You may view your note files and open them using "fz -l"
( After running the command,
SELECT file using arrow keys,
SEARCH filenames by typing )
EOF
practice "fz -l"
bash $script_dir/fz.sh -l
next_step

#
cat <<EOF
2 of 6: fz

fz interactively searches your note files for lines starting with __ or #
( exit with CTRL+C or pressing q )
EOF
practice "fz"
bash $script_dir/fz.sh
next_step

#
cat <<EOF
3 of 6: fz [file] [pattern]

If you already know what you want to search for, you can input the
filename and search pattern as arguments.

Search the file python.py in your notes folder for "for" "loop"
EOF
practice "fz python for loop"
bash $script_dir/fz.sh python for loop
next_step

#
clear
cat <<EOF
4 of 6: fze [option] [file] [pattern]

Now let's edit some files!
fze -f interactively searches files and opens matching lines in vim
( to exit vim, press Escape then enter :q! )

Try searching for "vim commands" among your note files
EOF
practice "fze -f"
bash $script_dir/fze.sh -f
next_step

#
cat <<EOF
5 of 6: fze [option] [file] [pattern]

We can also create new files using fze.
fze --new tutorial.txt creates a new file in your notes folder.
EOF
practice "fze -n tutorial.txt"
bash $script_dir/fze.sh -n tutorial.txt
next_step

#
cat <<EOF
6 of 6: fze --help, fze --help

There are more ways to search using fz and fze.
You can see more examples and view all options using
--help
EOF
practice "fze -h"
bash $script_dir/fze.sh -h

echo
echo "End of tutorial. Good luck!"
