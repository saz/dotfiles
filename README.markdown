## Files
.vim
    directory of file type configurations and plugins
.vimrc
    my vim configuration
.screenrc
    my screen configuration
.weechat
    my configuration for weechat, a great irc client
.gimp
    my tweaks/additions to gimp (fonts, brushes, etc)

## Instructions
### Creating source files
Any file which matches the shell glob `_*` will be linked into `$HOME` as a symlink with the first `_`  replaced with a `.`

For example:

    _bashrc

becomes

    ${HOME}/.bashrc

### Installing source files
It's as simple as running:

    ./install.sh

From this top-level directory.


I've extended the install.sh script to handle .config directory, too.
Just create a directory named '_config' and add files or directories in this directory.
Everything inside _config will be symlinked to .config.

For example:

    _config/awesome/rc.lua

becomes

    ${HOME}/.config/awesome/rc.lua

## Requirements
* bash
