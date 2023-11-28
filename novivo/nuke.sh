nuke()
{
  echo "  removing $1"
  #pm uninstall --user 0 "$1" 1> /dev/null
  #pm clear "$1" 1> /dev/null
}

skip()
{
  echo "  skipping $1"
}

[ $1 = "all" ] && NC="nuke" || NC="skip"

while read -r l
do
  case "$l" in
    "#"* )
      echo "$l"
    ;;
    ":"* )
      $NC "$l"
    ;;
    "" )
      :
    ;;
    * )
      nuke "$l"
    ;;
  esac
done < "$(pwd)/target.txt"
