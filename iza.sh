#! /bin/bash

# shellcheck disable=2162

declare -a ADDRESS
declare -a SHOPS
BASEDIR="$HOME/git/iza"
KURSE="$BASEDIR/misc/kurse.xml"
jpy2eur_fallback="143.02" # put appropriate value here

ReadAddr() {
    # TODO
    echo "$1"
    if [ ! -e "$BASEDIR/generated/$1" ]; then
        echo "generate xml from config"
    fi
    # append relevant parts to the files
}

CreateAddr() {
    # TODO
    cp "$BASEDIR/template/t-config.cfg" "$BASEDIR/private/config.tmp"
    echo "copied the template to the private folder, please fill it out"
}

# same for the shops

# similar for items

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

if [ -d "$BASEDIR/private" ]; then
    readarray -d '' ADDRESS < <(find "$BASEDIR/private" -type f -name "*.cfg" -print0)
    len=${#ADDRESS[@]}
    if [ "${ADDRESS[0]}" == "" ]; then
        CreateAddr
    elif [ "$len" == "1" ]; then
        read -p "use ${ADDRESS[0]} or create a new entry [n]?" input
        if [ "$input" == "n" ]; then
            CreateAddr
        else
            ReadAddr "${ADDRESS[0]}"
        fi
    else
        for (( i=0; i<"$len"; ++i )) do
            echo "$i - ${ADDRESS[$i]:${#BASEDIR}+9}"
        done
        read -p "select a address using the corresponding number. to create a new one type 'n': " input
        if [ "$input" -eq "$input" ] 2> /dev/null && [ "$input" -lt "$len" ]; then
            ReadAddr "${ADDRESS[$input]}"
        elif [ "$input" == "n" ]; then
            CreateAddr
        else
            echo "invalid input, aborting"
            exit 1
        fi
    fi
fi

eval "$BASEDIR/mpx.sh" "$BASEDIR" "jre.cfg" "amiami.cfg" "asuka.cfg"