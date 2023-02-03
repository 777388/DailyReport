#!/bin/bash

declare -A seen_ips

while read line; do
  ip=$(echo $line | awk '{print $2}')
  if [[ -z "${seen_ips[$ip]}" ]]; then
    ftp_response=$(ftp -v -n $ip <<END_SCRIPT
    user anonymous anonymous
    quit
END_SCRIPT
)
    if echo $ftp_response | grep "230 Login successful" > /dev/null; then
      echo "$ip allows anonymous FTP login"
    else
      echo "$ip does not allow anonymous FTP login"
    fi
    seen_ips[$ip]=1
  fi
done < port_21.txt
