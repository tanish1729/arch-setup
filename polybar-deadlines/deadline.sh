#!/bin/bash
python ~/.config/polybar-deadlines/deadline.py
value=$(<output.txt)
sed -i "342s/.*/$value/" ~/.config/polybar/config