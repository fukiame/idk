while read -r l
do
  case "$l" in
    "#"* )
      echo "$l"
    ;;
    ":"* )
      echo "  skipping $l"
    ;;
    "" )
      :
    ;;
    * )
      echo "  removing $l"
      pm uninstall --user 0 "$l" 1> /dev/null
      pm clear "$l" 1> /dev/null
    ;;
  esac
done < "$(pwd)/target.txt"
