#!/bin/bash
#Author: Viswanath S Chirravuri, Thales DIS SSG (Software Security Group)
#Date: September, 4th 2020
#Version: 1.0

gitrepoloc=/home/viswanath/webgoat/WebGoat-Legacy
cd $gitrepoloc
if test -f "allfiles.txt"; then
	rm allfiles.txt
fi
if test -f "orig_hashes.txt"; then
	rm orig_hashes.txt
fi
if test -f "computed_hashes.txt"; then
	rm computed_hashes.txt
fi
touch $gitrepoloc/allfiles.txt

git ls-tree -r HEAD | cut -d ' ' -f3- | cut -f2- >> allfiles.txt

echo "Total number of files to compare: " $(cat allfiles.txt | wc -l)

echo "Obtaining original hashes..."
touch $gitrepoloc/orig_hashes.txt
git ls-tree -r HEAD | cut -d ' ' -f 3 | cut -d$'\t' -f 1 >> orig_hashes.txt
printf "Original hashes count: " & cat orig_hashes.txt | wc -l

echo "Computing hashes for each file locally..."
touch $gitrepoloc/computed_hashes.txt
while read line ; do git hash-object "$gitrepoloc/$line" >> computed_hashes.txt ; done < allfiles.txt
printf "Computed hashes count: " & cat computed_hashes.txt | wc -l

echo "Comparing hashes now...please wait"
if [[ -z $(diff orig_hashes.txt computed_hashes.txt) ]] 
then 
	echo "Congratulations. Git hashes are verified for all files successfully!" 
else 
	echo "Hash verification failed! Run a *git diff* command to know the differences."
fi
rm allfiles.txt
rm orig_hashes.txt
rm computed_hashes.txt