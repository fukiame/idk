e="$(su -c dumpsys media_session)"
case "$(echo "$e" | grep -m1 '      state=Play' | sed 's/, /\n/g' | grep state= | cut -d= -f3)" in
  3) echo " |> Playing" ;;
  2) echo " || Paused" ;;
  *)
    echo " [] Stopped"
    q=1
    ;;
esac
echo
mtd=$(echo "$e" | grep -m1 '      metadata' | cut -d= -f3-)
artist=$(echo $mtd | cut -d, -f2 | sed 's/.//')
song=$(echo $mtd | cut -d, -f1 )
[ "$q" != 1 ] && echo " $song\n\n $artist" || echo " -\n\n -"
echo '\n ---------------------------------- '
e=$(termux-volume | jq '.[] | select(.stream=="music")')
p=$(echo "$e" | jq '.volume')
m=$(echo "$e" | jq '.max_volume')
printf "\n media volume %16s / %s\n" "$p" "$m"
w=31
pr=$(printf "%*s" "$(( $p*$w/$m ))" "" )
pr=$(echo "$pr" | sed 's/ /:/g')
h=$(printf "%-*s" "$w" "$pr")
echo  -n "\n $h "
e="$(termux-audio-info)"
if [ "$(echo "$e" | jq '.BLUETOOTH_A2DP_IS_ON')" = true ] ; then
  echo -n " B"
else
  case "$(echo "$e" | jq '.WIREDHEADSET_IS_CONNECTED')" in
    false) echo -n "🔉" ;;
    true) echo -n "🎧" ;;
    *) echo -n u ;;
  esac
fi
