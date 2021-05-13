# bash_notes

Personal bash note-taking system using the terminal. Multi-line searches and edits note files using grep, less and Vim.

Daily driver for managing code snippets since 2019. See [references.txt](references.txt) for example note file.

## Installation

Sets up ~/_bash_notes directory and adds ref and refe as aliases to ~/.bash_profile

```bash
git clone https://github.com/Magnushhoie/bash_notes/
cd bash_notes
bash setup.sh
```

## Usage

```python
# ref.sh: Multi-line search for keywords in references.txt or other .txt files in note folder
ref
ref <keywords>
ref notefile2 <keywords>
ref --list # List available note files in note folder

# refe.sh: Edit/open references.txt or other .txt file in note folder
refe
refe --open # Open using system default text editor (i.e. Atom, Sublime, TextEdit etc)
refe <keywords>
refe --new notefile2.txt
refe notefile2 <keywords>
refe --list
```

## Testing

```bash
bash test/test.sh
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
