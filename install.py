#!/usr/bin/env python
import os
import sys

cdir = os.path.dirname(os.path.abspath(__file__))
sourcedir = os.path.join(cdir, 'src')
targetdir = os.path.expanduser('~')


def link_if_missing(source, target):
    # lexists also protects existing broken symlinks.
    if os.path.lexists(target):
        if os.path.realpath(target) == source:
            return

        was_link = ""
        if os.path.islink(target):
            filename = os.path.realpath(target)
            was_link = " (existing symlink to %s)" % filename

        print("\033[93mWARNING\033[0m: %s exists! Skipping.%s" % (target, was_link))
        return

    os.symlink(source, target)


for dotfile in os.listdir(sourcedir):
    source = os.path.join(sourcedir, dotfile)
    if dotfile == 'launchagents':
        if sys.platform == 'darwin':
            agentsdir = os.path.join(targetdir, 'Library', 'LaunchAgents')
            os.makedirs(agentsdir, exist_ok=True)
            for agent in os.listdir(source):
                link_if_missing(os.path.join(source, agent),
                                os.path.join(agentsdir, agent))
        continue

    link_if_missing(source, os.path.join(targetdir, dotfile))
