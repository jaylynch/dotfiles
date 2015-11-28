#!/usr/bin/env python
import os

cdir = os.path.dirname(os.path.abspath(__file__))
sourcedir = os.path.join(cdir, 'src')
targetdir = os.path.expanduser('~')

for dotfile in os.listdir(sourcedir):
  source = os.path.join(sourcedir, dotfile)
  target = os.path.join(targetdir, dotfile)

  if os.path.exists(target):
      print "WARNING: %s exists! Skipping." % (target)
      continue

  ##TODO## :: Look at why os.symlink doesn't like relative paths
  os.system("ln -s %s %s" % (source, target))

