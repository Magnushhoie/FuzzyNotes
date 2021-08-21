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
    Quickly search and edit notes + code-snippets <a href="https://asciinema.org/a/431547">in your terminal</a>
    
  
  </p>
</p>

## Installation

Sets up notes directory and adds aliases to ~/.bash_profile or ~/.zshrc.

```bash
git clone https://github.com/Magnushhoie/bash_ref/
cd bash_ref
bash setup.sh
```

## Usage

**[Learn bash_ref in 60 seconds on asciinema](https://asciinema.org/a/431547)**
- From your terminal, add any notes you want to references.txt using just "**refe**"
- Search for any keywords you want using "**ref \<keywords\>**"
- Search results can be searched again using hotkey **/**

Used daily for writing and searching notes and code snippets since 2019. Uses BASH, [grep](https://github.com/Magnushhoie/bash_ref/blob/master/src/functions.sh#L176) and vim / text editor of choice.
See [references.txt](references.txt) for example note file.

## Documentation

Use "**ref --help**" for all arguments.

#### ref - Multi-line search for keywords across all note files

```text
# Usage:
ref.sh [notefile] keywords

# View main note file (references.txt):
ref 

# Search main note file (references.txt) for keywords "bash" "loop"
ref bash loop

# Search file notes2.txt in note folder for keyword "python"
ref notes2 python

# See list of all note files
ref --list
ref -l

# ref -all:
# Search across all files in note folder for keywords "python" "list"
ref --all python list
ref -a python list
```

#### refe - Edit note file at searched line

```text
# Usage:
refe [notefile] keywords

# Edit main note file (references.txt) in vim / editor of choice:
refe

# Create new note file, notes2.txt in notes folder
refe --new notes2.txt
refe -n notes2.txt

# Edit main note file (references.txt) at first line with "bash loop"
refe bash loop

# Edit notes2.txt at first line with "python"
refe notes2 python
```

## Testing

```bash
bash test/test.sh
```

## Compatibility
Compatible with zsh. Tested on MacOS Mojave and Ubuntu 21.04. 

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
