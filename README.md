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

**[See bash_ref in 60 seconds on asciinema](https://asciinema.org/a/431547)**
- From your terminal, add any notes you want to references.txt using just "**refe**"
- Multi-line search for any keywords you want using "**ref \<keywords\>**"
- Search results can be searched again using hotkey **/**
- Use **ref -a** to search across all notefiles

Used daily for writing and searching notes and code snippets since 2019. Uses BASH, [grep](https://github.com/Magnushhoie/bash_ref/blob/master/src/functions.sh#L176) and vim / text editor of choice.

See [references.txt](_bash_ref/references.txt) for example note file.

## Documentation

Use "**ref --help**" for all arguments.

#### ref - Multi-line search for keywords across all note files

```text
# Usage (notefile is optional):
ref [notefile] keywords

# View main note file (references.txt):
ref 

# Search main note file (references.txt) for keyword "terminal"
ref terminal

# Search file bash.sh in note folder for keyword "for loop"
ref bash for loop

# See list of all note files
ref --list

# Search across all files in note folder for keywords "python" "list"
ref --all python list
```

#### refe - Edit note file at searched line

```text
# Usage (notefile is optional):
refe [notefile] keywords

# Edit main note file (references.txt) in vim / editor of choice:
refe

# Edit file bash.sh at first line with "for loop"
refe bash for loop

# Create new note file, personal.txt in notes folder
refe --new personal.txt
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
