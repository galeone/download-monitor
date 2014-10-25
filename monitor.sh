#!/usr/bin/env bash

[ $# -lt 1 ] && echo -e "Usage: $0 download-folder" && exit -1

function organize {
    NEWDIR=$(echo "$1" | cut -d'_' -f1)
    NEWFILE=$(echo "$1" | sed 's/^.*_//g')

    if [ "$NEWDIR" != "$NEWFILE" ]; then
        NEWDIR="$2/$NEWDIR"
    else
        NEWDIR="$2/misc"
    fi

    [ ! -d "$NEWDIR" ] && mkdir "$NEWDIR"

    mv "$2/$1" "$NEWDIR/$NEWFILE"
    echo -e "Moved $2/$1 into $NEWDIR/$NEWFILE"
}

while FILE=$(inotifywait -e moved_to --format %f --excludei "(\.crdownload$)|(^\.com\.google\.Chrome)" "$1")
do
    MIME_TYPE=$(file -b --mime-type "$1/$FILE")
    TYPE="$(echo $MIME_TYPE | cut -f1 -d'/')"

    if [ "$(echo $MIME_TYPE | cut -f1 -d'/')" == "application" ]; then
        TYPE="$(echo $MIME_TYPE | cut -f2 -d'/')"
    fi

    DIR="$1/$TYPE"
    [ ! -d "$DIR" ] && mkdir "$DIR"
    mv "$1/$FILE" "$DIR"/
    organize "$FILE" "$DIR"
done

