#!/bin/bash

if [ $# -lt 1 ]
then
	echo "must put files you want to collate in as arguments"
	exit 1
fi

#globals and functions
nOfChars=0
dashes=""
outputFileName="summary.txt"

countCharsInStringAssignTonOfChars()
{
	local charCount=$(grep -o "." <<< "$1" | wc -l)
	nOfChars=$charCount
	return 0
}

createDashedStringOfLengthNAssignToDashesVar()
{

	#loop and append dashes
	for i in $(seq $1)
	do
		dashes="${dashes}-"
	done
}


# make file to append to
if [ -f $outputFileName ] 
then
	echo "removing existing collated file"
	rm $outputFileName
fi

echo "re-creating file"
touch $outputFileName

echo "COLLATING $# FILES TOGETHER INTO FILE: $outputFileName"

for f in $*
do
	dashes=""
	title="BEGINNING OF FILE: -- $f --" 
	# call func and assign n of chars to nOfChars global var
	countCharsInStringAssignTonOfChars "$title"
	createDashedStringOfLengthNAssignToDashesVar "$nOfChars"
	
	#head/title of file	
	echo "" >> $outputFileName
	echo "$dashes" >> $outputFileName	
	echo "$title" >> $outputFileName
	echo "$dashes" >> $outputFileName

	#body of file
	echo "" >> $outputFileName
	cat $f >> $outputFileName
	echo "" >> $outputFileName	
done
