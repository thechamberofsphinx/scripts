#!/usr/bin/bash

echo 'How many words do you want your password to consist of?'
while true; do
    read l
    if ! [[ "$l" =~ ^[0-9]+$ ]]; then
        echo 'Input must be a single number'
    elif (( "$l" > 100 )); then
        echo 'Please enter a number smaller than 100'
    else
        break
    fi
done

touch /tmp/diceware

curl https://raw.githubusercontent.com/agreinhold/Diceware-word-lists/master/diceware-eu.txt \
> /tmp/diceware

touch /tmp/numbers
echo -n > /tmp/numbers

for (( i = 1; i <= l; i++)); do
    echo `seq 5 | shuf | tr -d '\n'` >> /tmp/numbers
done

touch /tmp/password
echo -n > /tmp/password

while read n; do
    echo `grep $n /tmp/diceware | awk '{printf $2}'` >> /tmp/password
done < /tmp/numbers

echo 'Your password is:'
cat /tmp/password | tr -d '\n'
echo

rm /tmp/numbers
rm /tmp/diceware
rm /tmp/password
