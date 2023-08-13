#!/bin/bash

video1="./v1.mp4"
video2="./v1.mp4"
x=$1
y=$2
w=$3
h=$4
output="out.mp4"

ffmpeg -i   "$video1" -vf   "movie=$video2,scale=(iw*($w/100)):(ih*($h/100)),drawbox=0:0-t:(iw*($w/100))*2:(ih*($h/100))*2:color=red@1:t=3.5: -1 [inner]; [in][inner] overlay=(W*($x/100))-(w/2):(H*($y/100))-(h/2)"\
 "$output" \
 && mplayer ./out.mp4 && rm -rf ./out.mp4

