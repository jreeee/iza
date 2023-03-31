#! /bin/bash

# shellcheck disable=1001

if [ $# -gt "1" ]; then
    year="$1"
    path="$2"
else
    year=$(date +%Y)
    path="misc"
fi

if [ ! -d private ]; then
    mkdir private
    # ask to create file
fi

if [ ! -d generated ]; then
    mkdir generated
fi

if [ ! -d items ]; then
    mkdir items
fi

echo "getting current conversion rate"
curl https://www.zoll.de/SiteGlobals/Functions/Kurse/KursExport.xml\?view\=xmlexportkursesearchresultZOLLWeb\&kursart\=1\&iso2code2\=JP\&startdatum_tag2\=01\&startdatum_monat2\=01\&startdatum_jahr2\="$year"\&enddatum_tag2\=31\&enddatum_monat2\=12\&enddatum_jahr2\="$year"\&sort\=asc\&spalte\=gueltigkeit > misc/kurse.tmp
lines=$(wc -l "$path/kurse.tmp" | awk '{print $1}')
if [[ $lines -gt "0" ]]; then
    mv "$path/kurse.tmp" "$path/kurse.xml"
else
    echo "Do you have a active internet connection?"
    rm misc/kurse.tmp
fi