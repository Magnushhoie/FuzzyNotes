<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Magnushhoie/bash_ref">
    <img src="img/bash_ref.png" alt="Logo" width="350">
  </a>

  <h3 align="center">bash_ref</h3>

  <p align="center">
    Blazingly fast search and edit of text files
  <a href="https://asciinema.org/a/458105">in your terminal</a>
  </p>
</p>

A shell script for rapidly searching and editing text files in a notes directory, with interactive and multi-line search. Built with FZF, grep and vim.

<a href="https://asciinema.org/a/458105">
<img src="img/image.jpg" alt="Logo" width="700">

**[See bash_ref in 60 seconds on asciinema](https://asciinema.org/a/458105)**
  
## Installation

Sets up notes directory and adds aliases to ~/.bash_profile or ~/.zshrc.

```bash
# Requirements
brew install fzf
  
# Install
git clone https://github.com/Magnushhoie/bash_ref/
cd bash_ref
bash setup.sh
```

## Usage
- ref: Interactively search note files using FZF
- ref -l: List and open note files in default $EDITOR
- refe -f: Interactively search and edit note files using FZF
- refe [file] [pattern]: Multi-line search file, edit at match



See [main.txt](_bash_ref/main.txt) for example note file.

## Documentation

Use "**ref --help**" for all arguments.

#### ref - Interactive search and view

```text
ref --help
usage: ref.sh [notefile] keywords
  notefile: File basename in note folder if existing. Default is main.txt
  keywords: Search terms, space-separated

Optional arguments:
  -o|--open                  Open file with default system editor
  -l|--list                  Display and open files in notes folder
  -g|--get                   Get filenames and line-numbers for lines matching keywords across all files
  -h|--help                  Displays this help
  --config                   Open configuration file
  --tutorial                 Start ref tutorial

Example usage:
Interactively search and view files for lines starting with __ or #:
ref

Search [main.txt] for keywords "bash" "loop"
ref bash loop

Search [python.py] in note folder for "list" "comprehension"
ref python list comprehension
```

#### refe - Interactive search and edit

```text
refe --help
usage: refe.sh [notefile] keywords
  notefile: File basename in note folder if existing. Default is main.txt
  keywords: Search terms, space-separated

Optional arguments:
     -o|--open                  Open file with default system editor
     -l|--list                  Displays searchable files in notes folder
     -n|--new                   Create [filename] in notes folder
     -h|--help                  Displays this help
     --config                   Open configuration file
     --tutorial                 Start ref tutorial

Example usage:
Interactively search and edit files at lines starting with __ or #:
refe -f

Open and edit [main.txt] at first line with "bash loop"
refe bash loop

Create newfile.txt in notes folder
refe -n newfile.txt
```

## Testing

```bash
bash test/test.sh
```

## Compatibility
Compatible with zsh. Tested on MacOS Mojave/Big Sur and Ubuntu 21.04. 

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Magnushhoie/bash_ref.svg?style=for-the-badge
[contributors-url]: https://github.com/Magnushhoie/bash_ref/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Magnushhoie/bash_ref.svg?style=for-the-badge
[forks-url]: https://github.com/Magnushhoie/bash_ref/network/members
[stars-shield]: https://img.shields.io/github/stars/Magnushhoie/bash_ref.svg?style=for-the-badge
[stars-url]: https://github.com/Magnushhoie/bash_ref/stargazers
[issues-shield]: https://img.shields.io/github/issues/Magnushhoie/bash_ref.svg?style=for-the-badge
[issues-url]: https://github.com/Magnushhoie/bash_ref/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/Magnushhoie/bash_ref/blob/master/LICENSE.txt
