dotfiles
========

Super-lightweight way to manage dotfiles... It's probably not the most efficient way but I've been setting up a heap of VMs lately and it was driving me nuts using default config on all of them, so here we are.

Currently contains:
- .vimrc (Vim config)
- .vim/colors (Vim color schemes)
- .bashrc (Basics for now)
- .bash_profile
- .gitconfig

Just run install.py in the root to install to home directory, note it's still _incredibly_ naive at this point - it purely runs over every item in src/ and links each from the current user's home directory - so make sure you only run it on a clean installation where these files aren't going to exist.

Thanks to the makers of the color schemes included here! They're duplicated so I know I'm getting the exact version but all are available on vim.org

TODO
----

- Better Windows / MSYS detection
- Better OSX and zsh detection
- Sublime Text config


macOS keyboard remapping
------------------------

`macos/LaunchAgents/local.escape-to-backtick.plist` maps the physical Escape key
to backtick/tilde and Caps Lock to Escape, applying the mappings at login.
In System Settings → Keyboard → Keyboard Shortcuts → Modifier Keys, leave
Caps Lock mapped to Caps Lock for each keyboard; the LaunchAgent handles its remap.

Install separately from `install.py`:

```sh
mkdir -p ~/Library/LaunchAgents
ln -s ~/dotfiles/macos/LaunchAgents/local.escape-to-backtick.plist ~/Library/LaunchAgents/local.escape-to-backtick.plist
launchctl bootstrap "gui/$(id -u)" ~/Library/LaunchAgents/local.escape-to-backtick.plist
```

If that LaunchAgent is already loaded, unload it before loading the updated file:

```sh
launchctl bootout "gui/$(id -u)/local.escape-to-backtick"
launchctl bootstrap "gui/$(id -u)" ~/Library/LaunchAgents/local.escape-to-backtick.plist
```
