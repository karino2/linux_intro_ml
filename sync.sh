#!/bin/sh
rsync -av --update --include "*.md" --exclude "*" .  ../../Google\ ドライブ/DriveText/
rsync -av --update --include "*.md" --exclude "*" ../../Google\ ドライブ/DriveText/ . 
