#!/usr/bin/bash

#
#   This is a simple cli to manage bookmarks stored in a text file
#



# Specify bookmark file location
bmarks=/tmp/bookmarks
touch $bmarks

prompt=">> "

echo "Welcome to bookmarks_cli. To see available commands, type 'help'"
while true; do
    read -p "$prompt" var
    case $var in
        cp)
            printf "Which bookmark to copy?\n"
            read num
            grep URL $bmarks | sed "$num"'q;d' | awk '{printf $2}' | xclip -se c -i
            printf "Bookmark copied to clipboard!\n"
            ;;
        d)
            printf "Which bookmark to delete?\n"
            read num
            line=`grep -n Title $bmarks | sed "$num"'q;d' | sed 's/:.*//'`
            sed -i "$line"'d' $bmarks
            sed -i "$line"'d' $bmarks
            ;;
        h | help)
            printf "Commands:\n"
            printf "cp = copy bookmark to clipboard\n"
            printf "d = delete a bookmark\n"
            printf "h = display this help\n"
            printf "l = list bookmarks\n"
            printf "n = new bookmark\n"
            printf "q = quit\n"
            ;;
        l)
            n=1
            grep Title $bmarks | while read line; do
                echo $line | sed "s/Title/$n/1"
                ((n++))
            done
            ;;
        n)
            read -p "Title: " title
            read -p "URL: " url
            printf "Title: $title\n" >> $bmarks
            printf "URL: $url\n" >> $bmarks 
            printf "Bookmark created!\n"
            ;;
        q | quit)
            break
            ;;
        *)
            echo "Type 'help' for list of available commands"
            ;;
    esac
done
