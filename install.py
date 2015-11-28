#!/usr/bin/env python
import os

cdir = os.path.dirname(os.path.abspath(__file__))
sourcedir = os.path.join(cdir, 'src')
targetdir = os.path.expanduser('~')

for dotfile in os.listdir(sourcedir):
    source = os.path.join(sourcedir, dotfile)
    target = os.path.join(targetdir, dotfile)

    if os.path.exists(target):
        if os.path.realpath(target) == source:
            continue

        was_link = ""
        if os.path.islink(target):
	    filename = os.path.realpath(target)
            was_link = " (existing symlink to %s)" % filename

        print "\033[93mWARNING\033[0m: %s exists! Skipping.%s" % (target, was_link)
        continue

    ##TODO## :: Look at why os.symlink doesn't like relative paths
    os.system("ln -s %s %s" % (source, target))

