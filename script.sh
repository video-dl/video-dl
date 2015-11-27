#!/usr/bin/env bash
[ "${TRAVIS_PULL_REQUEST}" = "false" ] && {
# 2start
source data
git remote rm origin
git remote add origin https://$GH_TOKEN@github.com/video-dl/video-dl
git push origin :${TRAVIS_BRANCH}
git submodule init
git submodule update
clear
export dir=$PWD
sudo curl -s https://yt-dl.org/latest/youtube-dl -o /usr/bin/youtube-dl
sudo chmod a+rx /usr/bin/youtube-dl

# Main functions
dl() {

mkdir $dir/tmp
cd $dir/tmp
[ "$2" = "" ] && filename="%(title)s.%(ext)s" || filename="$2"
youtube-dl --newline --output "$filename" "$1" 2>&1 | sed '/\%/!d;s/.*\]\s*//g;s/\s.*//g;s/^/DL /g'
}

dropbox() {
cd $dir/dropbox_sdk
sudo python setup.py install
cd $dir
python dropbox_ul.py --token "$1" "$dir/tmp/$2" "/dl2cloud/$2"
}


echo "Starting dl..."
dl "$url" "$filename"
echo "Starting ul..."
$target "$token" "$filename"

}
