<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Magnushhoie/bash_notes">
    <img src="img/bash_notes.png" alt="Logo">
  </a>

  <h3 align="center">bash_notes</h3>

  <p align="center">
    Quickly search and edit your notes and code-snippets in your terminal
    <br />
  </p>
</p>

## Installation

Sets up notes directory and adds aliases to ~/.bash_profile or ~/.zshrc.

```bash
git clone https://github.com/Magnushhoie/bash_notes/
cd bash_notes
bash setup.sh
```

## Usage
- From your terminal, add any notes you want to references.txt using **refe**
- Search for any keywords you want using **ref \<keywords\>**
- Search results can be searched again using hotkey **/**

Used daily for writing and searching notes and code snippets since 2019. Uses BASH, [grep](https://github.com/Magnushhoie/bash_notes/blob/master/src/functions.sh#L176) and vim / text editor of choice.
See [references.txt](references.txt) for example note file.

#### ref - Multi-line search for keywords across all note files

```text
# Usage:
ref.sh [notefile] keywords

# View main note file (references.txt):
ref 

# Search main note (references.txt) file for keywords "bash" "loop"
ref bash loop

# Search file notes2.txt in note folder for keywords "python"
ref notes2 python

# Search across all files in note folder for keywords "python" "list"
ref -a python list
```

<br>

#### refe - Edit note files at searched line

```text
# Usage:
refe [notefile] keywords

# Edit main note file (references.txt) in vim / editor of choice:
refe

# Create new note file, notes2.txt in notes folder
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
[contributors-shield]: https://img.shields.io/github/contributors/Magnushhoie/bash_notes.svg?style=for-the-badge
[contributors-url]: https://github.com/Magnushhoie/bash_notes/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Magnushhoie/bash_notes.svg?style=for-the-badge
[forks-url]: https://github.com/Magnushhoie/bash_notes/network/members
[stars-shield]: https://img.shields.io/github/stars/Magnushhoie/bash_notes.svg?style=for-the-badge
[stars-url]: https://github.com/Magnushhoie/bash_notes/stargazers
[issues-shield]: https://img.shields.io/github/issues/Magnushhoie/bash_notes.svg?style=for-the-badge
[issues-url]: https://github.com/Magnushhoie/bash_notes/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/Magnushhoie/bash_notes/blob/master/LICENSE.txt
