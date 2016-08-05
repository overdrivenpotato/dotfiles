# my dotfiles

Quick install

```sh
curl https://raw.githubusercontent.com/overdrivenpotato/dotfiles/master/setup.sh -sSf | sh
```

`$CLONE_DIR` is set to the directory where this repository was cloned.

By default the quick install will try and clone to `~/dotfiles`.

The following files (if they exist) will be moved into `$CLONE_DIR/backup`:

  * `~/.vimrc`
  * `~/.bashrc`
  * `~/.bash_profile`

Files are symlinked to the original files in "$CLONE_DIR".
