#!/bin/bash

name=`xclip -selection c -o`
folder=/home/desired_folder/
import ${folder}/${name}.png
