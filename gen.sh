#!/bin/bash
#cat $1 #| base64 -d
# T=trojan://
# TEROJAN=`echo "$T" | sed 's/\./\\\\./g'`
# sed -i_bak -e "/[\t]$TEROJAN/d" $1
# clear
# cat $1_bak
cat $1 | grep vmess:// >> $1.out
clear
sed -i 's/vmess:\/\///g' $1.out 
cat $1.out | base64 -d >> $1.oout 
rm -rf $1.out 
mv $1.oout $1.out
sed -i 's/ps":"/ps":"@VipVpnCenter/g' $1.out
sed -i 's/}/}\n/g' $1.out

input="$1.out"
while IFS= read -r line
do
  code= echo "$line" | base64 -w 1000 >> out.txt
done < "$input"
rm -rf $1.out 
 input="out.txt"
while IFS= read -r line
do
  code= echo "vmess://$line" >> output1.txt
done < "$input"
rm -rf out.txt
rm -rf output.txt
cat output1.txt | base64 -w 0 >> output.txt
cat output.txt