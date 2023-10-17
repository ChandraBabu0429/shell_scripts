# FIRST PROJECT
#R=\e[31m
#Y=\e[33m
#N=\e[0m

#for i in $@
#do
 # yum install $R $Y $i -y  $N
#done

#!/bin/bash
RED='\e[31m'    # Red color
YELLOW='\e[33m' # Yellow color
RESET='\e[0m'   # Reset color

for i in "$@"; do
  echo -e "${RED}Installing${RESET} ${YELLOW}$i${RESET}..."
  sudo apt-get install "$i" -y
done

