#!/bin/bash

LOG="/tmp/live.txt"
STREAM_KEY=${ENV_STREAM_KEY}
STREAM_URL="rtmp://a.rtmp.youtube.com/live2/${ENV_STREAM_KEY}"

byobu new-session -d -s mystream 'glances --disable-plugin fs,diskio'

while true; do
  byobu capture-pane -t mystream -pS -100 | sed 's/%/P/g'> ${LOG} #lavfiが % 文字列非対応
  sleep 3
done &
WHILE_PID=$!

# ffmpegで表示
ffmpeg \
  -re -f lavfi -i anullsrc=channel_layout=mono:sample_rate=44100 \
  -re -f lavfi -i color=c=black:s=1280x720:r=10 \
  -vf "drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf:textfile=$LOG:reload=1:fontsize=24:fontcolor=white:x=10:y=10" \
  -c:v libx264 -preset veryfast -b:v 1000k \
  -c:a aac -b:a 128k \
  -f flv "$STREAM_URL"

#  -re -f lavfi -i color=c=black:s=1920x1080:r=10 \

# 終了時にプロセス停止
kill "$WHILE_PID"
byobu kill-session -t mystream
