#!/usr/bin/env bash
[ "${TRAVIS_PULL_REQUEST}" = "false" ] && {
source data
git remote rm origin
git remote add origin https://$GH_TOKEN@github.com/video-dl/video-dl
git push origin :${TRAVIS_BRANCH}
clear
cd ..
rm -rf video-dl
mkdir tmp
cd tmp


dl() {
[ "$2" = "" ] && filename="%(title)s.%(ext)s" || filename="$2"
youtube-dl --newline --output "$filename" "$1" 2>&1 | sed '/\%/!d;s/.*\]\s*//g;s/\s.*//g;s/^/DL /g'
}

dropbox() {
curl "https://raw.githubusercontent.com/andreafabrizi/Dropbox-Uploader/master/dropbox_uploader.sh" -o dropbox_uploader.sh
chmod +x dropbox_uploader.sh
echo "$1" >../token
./dropbox_uploader.sh -p -f ../token upload "$2" "$2"
}


echo "Starting dl..."
dl "$url" "$filename"
echo "Starting ul..."
$target "$token" "$filename"

}
