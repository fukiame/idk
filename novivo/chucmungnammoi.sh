while read -r l
do
  if [ "$l" = "#"* ]; then echo "$l"
  else if [ "$l" = "" ]; then :
  else if [ "$l" = ":"* ]; then echo "skipping $l"
  else
    pm uninstall --user 0 "$line"
    pm clear "$line"
  fi
done < "$(pwd)/happychristmas.txt"
