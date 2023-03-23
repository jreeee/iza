#! /bin/bash

# parameters are :
# conversion rate ($1)
# basepath ($2) 
# userfile ($3)
# shopfile ($4)
# itemfile ($5)

# all them arrays
POSDATA=( "ROHMASSE" "EIGENMASSE" "ARTIKELPREIS" "ZOLLWERT" "EUST_KOSTEN" "E_AHSTAT_WERT" "WARENBEZEICHNUNG_FIRMA" )
ZADATA=( "REGNR_DIENSTSTELLE" "Dienststelle" "Bezugsnummer" "Betrag" "E_LB_ORT" "E_VORPAPIERNUMMER" "E_BESTIMMUNGSBUNDESLAND" "Ort" "Unterzeichner" "Stellung" "Telefonnummer" "EMail" )
VSEMDATA=( "Firmenbezeichnung" "Strasse" "Anschriftsortsteil" "PLZ_Strasse" "Anschriftsort" )
SECTION=( "Versender" "Empfaenger" )

ITEMDATA=( "\[masse_ges\]" "\[masse\]" "preis" "preis_ges" "pueb" "lnr" "name" "\[month\]" )
SHOPDATA=( "name" "strasse" "\[ortsteil\]" "plz" "ort" )
USERDATA=( "name" "strasse" "\[ortsteil\]" "plz" "ort" "vorname" "zollstelle" "bundesland" "tel" "\[mail\]" )

cp "$2/template/AD.xml" "$2/generated/ad.tmp"
cp "$2/template/PD.xml" "$2/generated/pd.tmp"

AddVal() {
    # $1 - name in document $2 - value $3 - file
    sed -i "s#$1.*#$1\">$2</element>#g" "$3"
}

GetVal() {
    # $1 - name in cfg $2 - path to cfg
    var=$(grep "^$1:" "$2" | cut -d " " -f2-)
}