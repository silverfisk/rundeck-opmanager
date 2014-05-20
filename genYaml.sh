#!/bin/bash

~/bin/getnodes.rb |								# Make sure we've got rundeck in the right path
sed "s/'//g" |									# remove all single quotes (we'll add some below)
awk '{ if ($1=="---") print $1 } {if ($1=="-") print $1} {if ($1!="---" && $1!="-") print "  "$1, " \x27"$2" "$3" "$4" "$5" "$6"\x27"}' |	# Rundeck wants quotes on the last word in every line
grep -v "img src=/images/devices/statu"	|
sed 's/deviceName/hostname/g'	|						# Convert element to something that RunDeck understands
sed 's/type:/osVersion:/g'	|						# Convert element to something that RunDeck understands
sed 's/vendorName:/osFamily:/g'	|						# Convert element to something that RunDeck understands
sed 's/displayName/nodename/g' > /tmp/nodes.yaml				# Convert element to something that RunDeck understands

# Errr... remove bad whitespaces...
for x in {1..6}
do
	sed -i "s/ '/'/g" /tmp/nodes.yaml
done
sed -i "s/:'/: '/g" /tmp/nodes.yaml						# Reset a whitespace that shouldnt be changed
cat ~rundeck/nodes.yaml								# Output the data to stdout so RunDeck can make sense of it
