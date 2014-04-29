#!/bin/bash
# housekeeping.sh

ARCHIVE_TO="$HOME"
ARCHIVE_DIR="old"
TTL="+14" 

function archive () {
	# command to put a file into its correct monthly thing
	bucket_month=$(date -r "$f" +%y-%m)
	dest="${ARCHIVE_TO}/${ARCHIVE_DIR}/${bucket_month}"
	mkdir -p "$dest" 
	printf 'mv -v "%s"   %s\n' "$(basename "$f")" "${dest}/"
}

function scan () {
	blacklist="$ARCHIVE_DIR config code bin Downloads rpmbuild Documents GNUstep spock.jpg"
	for bl in $blacklist; do grepvs="${grepvs} -e $bl "; done

	find -maxdepth 1 -mtime $TTL | egrep -v -e '^\.$' -e '^\./\.' $grepvs
}

scan | while read f; do
	eval $(archive "$f")
done