#!/bin/bash

for i in {1..9}; do
	echo -e "${i}m: \033[0;${i}mLorem Ipsum Dolor Sit Amen\033[0m"
done

for i in {30..37}; do
	echo -e "${i}m: \033[0;${i}mLorem Ipsum Dolor Sit Amen\033[0m"
done

for i in {40..47}; do
	echo -e "${i}m: \033[0;${i}mLorem Ipsum Dolor Sit Amen\033[0m"
done


for i in {90..100}; do
	echo -e "${i}m: \033[0;${i}mLorem Ipsum Dolor Sit Amen\033[0m"
done
