#!/bin/bash

while read line; do
  ip=$(echo $line | awk '{print $2}')
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
done < port_21.txt
