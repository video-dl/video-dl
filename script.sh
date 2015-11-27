#!/usr/bin/env bash
[ "${TRAVIS_PULL_REQUEST}" = "false" ] && {
source data
git remote rm origin
git remote add origin https://$GH_TOKEN@github.com/video-dl/video-dl
git push origin :${TRAVIS_BRANCH}
git submodule init
clear
mkdir tmp
cd tmp
export PATH=$PATH:$PWD
export dir=$PWD

dl() {
[ "$2" = "" ] && filename="%(title)s.%(ext)s" || filename="$2"
youtube-dl --newline --output "$filename" "$1" 2>&1 | sed '/\%/!d;s/.*\]\s*//g;s/\s.*//g;s/^/DL /g'
}

dropbox() {

}


echo "Starting dl..."
dl "$url" "$filename"
echo "Starting ul..."
$target "$token" "$filename"

}
