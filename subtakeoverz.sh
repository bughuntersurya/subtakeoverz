#! /bin/bash

if [ ! -d "subtakeoverz" ];then
	mkdir subtakeoverz
fi

echo "subtakeoverz Started" | notify
subfinder -silent -dL $1 | anew ~/subtakeoverz/subs.txt
echo "Total Subdomains" | notify
cat ~/subtakeoverz/subs.txt | wc -l | notify
sleep 60
cat ~/subtakeoverz/subs.txt | httpx -threads 30 | tee ~/subtakeoverz/live.txt
echo "Total Livedomains" | notify
sleep 5
cat ~/subtakeoverz/live.txt | wc -l | notify
sleep 5
while :
do
echo "Takeover Scan Started" | notify
cat ~/subtakeoverz/live.txt | nuclei -rl 100 -c 50 -t /root/nuclei-templates -tags takeover | tee ~/subtakeoverz/nuclei.txt | notify
echo "Takeover Scan Finished" | notify
echo "subtakeoverz Finished" | notify
sleep 3600
done
