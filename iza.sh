#! /bin/bash

BASEDIR="$HOME/git/iza"
KURSE="$BASEDIR/misc/kurse.xml"
jpy2eur_fallback="143.02" # put appropriate value here

# getting the conversion rate
datecheck="$(grep "$(date +%m.%Y)" "$KURSE")"
if [ "$datecheck" == "" ]; then
    eval "$BASEDIR/update.sh" "$(date +%Y)" "$BASEDIR/misc"
fi
jpy2eur=$(grep -B 2 "$(date +%m.%Y)" "$KURSE" | grep "kurswert" | cut -d ">" -f 2 | cut -d "<" -f 1 | sed -r 's/,/./')
if [ "$jpy2eur" == "" ]; then
    echo "your exchange rate file is missing or incomplete, using fallback"
    jpy2eur="$jpy2eur_fallback"
fi
echo "using conversion rate of $jpy2eur jpy to 1 eur"

# next steps:

# list reciever-files to choose from
# list shop-files to choose from
# list items to choose from / create new in CLI
# generate ad and pd files