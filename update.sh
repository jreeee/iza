#! /bin/bash
year=2023 

if [ ! -d private ]; then
    mkdir private
    # ask to create file
fi

if [ ! -d generated ]; then
    mkdir generated
fi

curl https://www.zoll.de/SiteGlobals/Functions/Kurse/KursExport.xml\?view\=xmlexportkursesearchresultZOLLWeb\&kursart\=1\&iso2code2\=JP\&startdatum_tag2\=01\&startdatum_monat2\=01\&startdatum_jahr2\=$year\&enddatum_tag2\=31\&enddatum_monat2\=12\&enddatum_jahr2\=$year\&sort\=asc\&spalte\=gueltigkeit > misc/kurse.tmp
lines=$(wc -l misc/kurse.tmp | awk '{print $1}')
if [[ $lines -gt "0" ]]; then
    mv misc/kurse.tmp misc/kurse.xml
else
    echo "Do you have a active internet connection?"
    rm misc/kurse.tmp
fi