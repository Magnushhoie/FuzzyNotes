# bash_ref tutorial

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
# Two minute bash_ref tutorial, by Magnus H. Høie
# https://github.com/Magnushhoie/bash_ref

1 of 6: ref --list

ref allows you to interactively search all your note files
( in $notes_folder )

You may view your note files and open them using "ref -l"
( After running the command,
SELECT file using arrow keys,
SEARCH filenames by typing )
EOF
practice "ref -l"
bash $script_dir/ref.sh -l
next_step

#
cat <<EOF
2 of 6: ref

ref interactively searches your note files for lines starting with __ or #
( exit with CTRL+C or pressing q )
EOF
practice "ref"
bash $script_dir/ref.sh
next_step

#
cat <<EOF
3 of 6: ref [file] [pattern]

If you already know what you want to search for, you can input the
filename and search pattern as arguments.

Search the file python.py in your notes folder for "for" "loop"
EOF
practice "ref python for loop"
bash $script_dir/ref.sh python for loop
next_step

#
clear
cat <<EOF
4 of 6: refe [option] [file] [pattern]

Now let's edit some files!
refe -f interactively searches files and opens matching lines in vim
( to exit vim, press Escape then enter :q! )

Try searching for "vim commands" among your note files
EOF
practice "refe -f"
bash $script_dir/refe.sh -f
next_step

#
cat <<EOF
5 of 6: refe [option] [file] [pattern]

We can also create new files using refe.
refe --new tutorial.txt creates a new file in your notes folder.
EOF
practice "refe -n tutorial.txt"
bash $script_dir/refe.sh -n tutorial.txt
next_step

#
cat <<EOF
6 of 6: ref --help, refe --help

There are more ways to search using ref and refe.
You can see more examples and view all options using
--help
EOF
practice "refe -h"
bash $script_dir/refe.sh -h

echo
echo "End of tutorial. Good luck!"
