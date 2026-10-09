dotfiles
========

Super-lightweight way to manage dotfiles... It's probably not the most efficient way but I've been setting up a heap of VMs lately and it was driving me nuts using default config on all of them, so here we are.

Currently contains:
- .vimrc (Vim config)
- .vim/colors (Vim color schemes)
- .bashrc (Basics for now)
- .bash_profile
- .gitconfig

Run `python3 install.py` in the root to link items in `src/` into your home directory. Existing files and symlinks are left untouched. On macOS, entries in `src/launchagents/` are linked individually into `~/Library/LaunchAgents/`; this directory is skipped on other systems. The installer creates links only; it does not load LaunchAgents into the current login session.

Thanks to the makers of the color schemes included here! They're duplicated so I know I'm getting the exact version but all are available on vim.org

TODO
----

- Better Windows / MSYS detection
- Better OSX and zsh detection
- Sublime Text config


macOS keyboard remapping
------------------------

`src/launchagents/local.escape-to-backtick.plist` maps the physical Escape key
to backtick/tilde and Caps Lock to Escape, applying the mappings at login.
In System Settings → Keyboard → Keyboard Shortcuts → Modifier Keys, leave
Caps Lock mapped to Caps Lock for each keyboard; the LaunchAgent handles its remap.

Run the installer, then load the agent for the current login session:

```sh
python3 install.py
launchctl bootstrap "gui/$(id -u)" ~/Library/LaunchAgents/local.escape-to-backtick.plist
```

If that LaunchAgent is already loaded, unload it before loading the updated file:

```sh
launchctl bootout "gui/$(id -u)/local.escape-to-backtick"
launchctl bootstrap "gui/$(id -u)" ~/Library/LaunchAgents/local.escape-to-backtick.plist
```
