#!/bin/bash
#scans all Wi-Fi channels and prints terminal-graphically its occupation
#(this source code sucks and should be rewritten, but you got the idea...)

BARCHAR="❚"
maxch=13
aChannels=`iwlist wlp3s0 scan | grep \(Channel | grep -Eo "[0-9]+)$" | tr -d ")" | sort -n`
uChannels=`echo "$aChannels" | sort | uniq`
test $maxch -gt 0 || exit 99

echo ${aChannels}
echo "---"

declare -A Stats
for (( i=1;i<=${maxch};i++ )); do
  Stats[$i]=`echo "$aChannels" | grep "^${i}$" | wc -l`
done

for (( i=1;i<=${maxch};i++ )); do
  bars=""
  count=${Stats[$i]}
  for (( b=1;b<=${count};b++ )); do
    bars+="$BARCHAR"
  done
  printf "channel %2d (%d) %s\n" $i $count $bars
done
