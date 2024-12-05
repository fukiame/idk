echo ; echo ; echo ; echo ; echo ; echo
echo 'fukiame@melody\n--------------'
fastfetch -l none | grep -ve Batt -e Window -e Shell -e Terminal -e Locale -e localhost -e Packages -e wlan0 -e ccmni -e 'Disk (/)' -e ------ | sed 's/ - .*//g' | sed 's/\/mnt\/media_rw\///' | sed 's/\/storage\/emulated.*):/Internal):/' | sed 's/ - fuse//'
#| sed 's/^/  /'
