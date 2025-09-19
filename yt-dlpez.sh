#!/bin/bash
# Bash script to run yt-dlp more easily

# Version 1.1 - Sep 19, 2025
# Added option to format in best quality in MP4 format

# Request for Format
echo -e "What format do you want to download?
1. Maximum quality video and audio
2. Maximum quality video and audio (MP4)
3. 1080p video + best audio
4. 480p video + best audio
5. Audio only"
read -p ">> " format

case $format in
    1) format_opts="-f bestvideo+bestaudio" ;;
    2) format_opts="-f bestvideo+bestaudio --merge-output-format mp4" ;;
    3) format_opts="-f 'bestvideo[height<=1080]+bestaudio'" ;;
    4) format_opts="-f 'bestvideo[height<=480]+bestaudio'" ;;
    5) format_opts="-f bestaudio" ;;
    *) echo "Invalid choice, defaulting to best"; format_opts="-f best" ;;
esac

# Request for Thumbnail
echo -e "Do you want to retain the thumbnail? (Y/n)"
read -p ">> " thumbnail
if [[ "$thumbnail" =~ ^[Yy]$ || "$thumbnail" == "" ]]; then
    thumb_opts="--embed-thumbnail"
else
    thumb_opts=""
fi

# Request for Captions
echo -e "Do you want closed captions on the video? (Y/n)"
read -p ">> " captions
if [[ "$captions" =~ ^[Yy]$ || "$captions" == "" ]]; then
    caption_opts="--write-subs --sub-lang en --embed-subs"
else
    caption_opts=""
fi

# Request for Cookies
echo -e "Do you want to use your cookies.txt file? (Y/n)"
read -p ">> " cookies
if [[ "$cookies" =~ ^[Yy]$ || "$cookies" == "" ]]; then
    cookie_opts="--cookies cookies.txt"
else
    cookie_opts=""
fi

# Final input (URL)
read -p "Enter the video URL: " url

# Build final command
cmd="yt-dlp $format_opts $thumb_opts $caption_opts $cookie_opts \"$url\""

echo "Running: $cmd"
eval $cmd
