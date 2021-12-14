#!/usr/bin/bash
figlet "kayrecon"
echo "#####################################"
echo "# kayrecon                          #"
echo "# by: Kaythecyberguy                #"
echo "# contact:14734167230               #"
echo "# https://github.com/kaythecyberguy #"
echo "#                                   #"
echo "#####################################"

if [ -z "$1" ]
then
	echo "Usage: ./kayrecon.sh <IP>"
	echo "Example ./kayrecon.sh 192.168.1.10"
	read 1
fi
printf "\n------------------------------- NMAP----------------------------\n\n" >crawler.txt
echo "[-]Running Nmap[-]"
nmap -sT -Pn -v $1 | tail -n +5 | head -n -3>crawler.txt 
while read line
do
	if [[ $line == *open* ]] && [[ $line == *http* ]]
	then
		echo "[-] Running Gobuster[-]"
		gobuster dir -u $1 -w /usr/share/wordlists/dirb/common.txt -x php>temp1
	echo "[-] Running Whatweb[-]"
	whatweb $1 -v > temp2
	echo "[-] Running Nikto [-]"
	nikto  $1 > temp3
	fi
done <crawler.txt

if [ -e temp1 ]
then
	printf "\n-------------------------Directories---------------------------------\n\n[+]" >>crawler.txt
	cat temp1 >>crawler.txt
fi

if [ -e temp2 ]
then
	printf "\n---------------------------WEB-----------------------------\n\n">>crawler.txt
		cat temp2 >>crawler.txt
		rm temp2
fi

if [ -e temp3 ]
then
	printf "\n------------------------Nikto------------------------------\n\n">>crawler.txt
		cat temp3 >>crawler.txt
		rm temp3
fi
cat crawler.txt
echo "Scan Completed Happy hacking"
