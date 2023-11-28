while read -r l
do
  if [ "$l" = "#"* ]; then echo "$l"
  elif [ "$l" = ":"* ]; then echo "  skipping $l"
  elif [ "$l" = "" ]; then :
  else
    echo "  removing $l"
    pm uninstall --user 0 "$l" 1> /dev/null
    pm clear "$l" 1> /dev/null
  fi
done < "$(pwd)/target.txt"
