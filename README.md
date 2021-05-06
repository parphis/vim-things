# vim-things

### vimrc
Should be copied to the /etc/vim/ or /home/$USER/.vim folder (on Debian). (VIM 7.3)

UTF-8 file encoding
4 tabs with spaces

 1. Install Vundle plugin manager: `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
 2. Start `vim` and execute `:PluginInstall`

Plugins:
 * Twig
 * Python autocomplete
 * Closetag
 * Tabular
 * Markdown

Keys:
 * CTRL+S           save current buffer
 * CTRL+A           save all buffer
 * F12 or CTRL+Q    save all buffer and quit
 * CTRL+Q           quit without save
 * F10              new tab
 * F7 / F8          previous / next tab
 * F11 / F5         save / restore session to/from ./cs.vim

When opening a new .HTML file an HTML sketelon loads with minimal bootstrap code like css, meta etc. tags.

Also contains some color modifications for `vimdiff`
