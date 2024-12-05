echo '\n -------------------- Wi-Fi'
termux-wifi-connectioninfo | rg -Fve '{' -e '}' -e '02:00:00:00:00:00' -e '<unknown ssid>' -e 'network_id' -e 'ssid_hidden' | sed 's/  "/ /g' | sed 's/": /: /g' | sed 's/supplicant_state:/supp_state:/'
echo '\n ------------------ Battery'
termux-battery-status | rg -Fve '{' -e '}' -e health -e status | sed 's/  "/ /g' | sed 's/": /: /g' | sed 's/\(\.[0-9][0-9]\)[0-9]*/\1/g'
