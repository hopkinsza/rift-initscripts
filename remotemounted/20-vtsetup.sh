#!/bin/mksh
# vim: syntax=sh

# 03-console-setup.sh
# set console font, keymap, RTC clock

if [[ -n $setfont_font ]]; then
	msg "setting console font to $vtfont"

	i=0
	while [[ $i < $ttys ]]; do
		setfont $setfont_flags "$setfont_font" -C "/dev/tty$i"
		i=$((i+1))
	done
fi

if [[ -n $keymap ]]; then
	msg "setting keymap to $keymap"
	loadkeys -qu "$keymap"
fi
