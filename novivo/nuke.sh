while read -r l
do
  if [ $(expr "$l" : "#*") -gt 0 ]; then echo "$l"
  elif [ $(expr "$l" : ":*") -gt 0 ]; then echo "  skipping $l"
  elif [ "$l" = "" ]; then :
  else
    echo "  removing $l"
    #pm uninstall --user 0 "$l" 1> /dev/null
    #pm clear "$l" 1> /dev/null
  fi
done < "$(pwd)/target.txt"
