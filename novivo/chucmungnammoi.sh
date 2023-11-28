while read -r line
do
  pm uninstall --user 0 "$line"
  pm clear "$line"
done < "$(pwd)/happychristmas.txt"
