echo
echo "Min refresh rate : $(su -c settings get system min_refresh_rate | cut -d. -f1) Hz"
echo "Max refresh rate : $(su -c settings get system peak_refresh_rate | cut -d. -f1) Hz"
ret=$(su -c cat /proc/gpufreq/gpufreq_opp_freq)
if echo "$ret" | grep disabled > /dev/null ; then
  ret=disabled
else
  freq_mhz=$(echo $ret | cut -d= -f2 | tr -d ' ' | cut -d, -f1)
  freq_ghz=$(echo "scale=3;$freq_mhz/1000000" | bc)
  ret="$freq_ghz Ghz"
fi
echo
echo -n "GPU OPP freq : $ret\n\n"
case "$(su -c cat /sys/class/power_supply/battery/input_suspend)" in
  1) e=on ;;
  0) e=off ;;
  *) e=unk ;;
esac
echo "Charging suspend: $e"
printf "
TZ:  CPU %5s
     CHA %5s
     PMIC %4s
" \
 "$(su -c cat /proc/mtktz/mtktscpu | head -n 1 | awk '{printf("%.1f\n", $1/1000)}')" \
 "$(su -c cat /proc/mtktz/mtktscharger | head -n 1 | awk '{printf("%.1f\n", $1/1000)}')" \
 "$(su -c cat /proc/mtktz/mtktspmic | head -n 1 | awk '{printf("%.1f\n", $1/1000)}')"
printf "
EEM: L %3s  CCI %3s
     B %3s  GPU %3s
" \
 "$(su -c cat /proc/eem/EEM_DET_L/eem_offset)" \
 "$(su -c cat /proc/eem/EEM_DET_CCI/eem_offset)" \
 "$(su -c cat /proc/eem/EEM_DET_B/eem_offset)" \
 "$(su -c cat /proc/eem/EEM_DET_GPU/eem_offset)"
h="$(su -c cat /sys/class/power_supply/battery/capacity)"
if [ "$h" -le 85 ]; then
  echo 0 | su -c tee /sys/class/power_supply/battery/input_suspend > /dev/null
fi
