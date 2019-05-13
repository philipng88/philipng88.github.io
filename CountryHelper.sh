#!/bin/bash

CIAWORLDFACTBOOK=https://raw.githubusercontent.com/iancoleman/cia_world_factbook_api/master/data/factbook.json 
RESTCOUNTRIES=https://restcountries.eu/rest/v2/name 

Get_Country_Information () {
	read -p "Enter a country name: " COUNTRY 
	OUT="${COUNTRY// /%20}"
	OUT2="${COUNTRY// /_}"

	if [ "$COUNTRY" == "Czech Republic" ]
	then 
		OUT2="czechia" 
	elif [ "$COUNTRY" == "South Korea" ] 
	then 
		OUT="Korea (Republic of)" 
		OUT2="korea_south"
	elif [ "$COUNTRY" == "North Korea" ]
	then 
		OUT="Korea (Democratic People's Republic of)"
		OUT2="korea_north" 
	fi 
	echo Native name:
	curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].nativeName" 
	echo 
	echo Historical Background:
	curl -# -m 15 ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2}.data.introduction.background"
	echo 
	echo Location:
	curl -# -m 15 ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2}.data.geography.location" 
	echo 
	echo Population:
	curl -# -m 15 ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2}.data.people.population.total"
	echo 
	echo Population Distribution:
	curl -# -m 15 ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2}.data.geography.population_distribution"
	echo 
	echo Capital:
	curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].capital"
	echo 
	echo Languages: 
	curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].languages[].name"
	echo 
	echo Currency:
	curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].currencies[].name" 
	curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].currencies[].code" 
	curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].currencies[].symbol" 
	echo 
	echo 'Timezone(s):'
	curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].timezones[]"
	echo 
}

Currency_Converter () {
	echo =============================================================================================
	echo -e "Bulgarian Lev(BGN)\tNew Zealand Dollar(NZD)\tIsraeli Shekel(ILS)\tRussian Ruble(RUB)\tCanadian Dollar(CAD)\tUnited States Dollar(USD)\nPhilippine Peso(PHP)\tSwiss Franc(CHF)\tSouth African Rand(ZAR)\tAustralian Dollar(AUD)\tJapanese Yen(JPY)\tTurkish Lira(TRY)\nHong Kong Dollar(HKD)\tMalaysian Ringgit(MYR)\tThai Baht(THB)\t\tCroatian Kuna(HRK)\tNorwegian Krone(NOK)\tIndonesian Rupiah(IDR)\nDanish Krone(DKK)\tCzech Koruna(CZK)\tHungarian Forint(HUF)\tBritish Pound(GBP)\tMexican Peso(MXN)\tSouth Korean Won(KRW)\nIcelandic Krona(ISK)\tSingapore Dollar(SGD)\tBrazilian Real(BRL)\tPolish Zloty(PLN)\tIndian Rupee(INR)\tRomanian Leu(RON)\nChinese Yuan(CNY)\tSwedish Krona(SEK)\tEuro(EUR)"
	echo =============================================================================================
	read -p "Enter currency you are converting from: " CONVERSIONFROM
	while 
		   [[ $CONVERSIONFROM != 'EUR' ]] && [[ $CONVERSIONFROM != 'eur' ]] \
		&& [[ $CONVERSIONFROM != 'BGN' ]] && [[ $CONVERSIONFROM != 'bgn' ]] \
		&& [[ $CONVERSIONFROM != 'NZD' ]] && [[ $CONVERSIONFROM != 'nzd' ]] \
		&& [[ $CONVERSIONFROM != 'ILS' ]] && [[ $CONVERSIONFROM != 'ils' ]] \
		&& [[ $CONVERSIONFROM != 'RUB' ]] && [[ $CONVERSIONFROM != 'rub' ]] \
		&& [[ $CONVERSIONFROM != 'CAD' ]] && [[ $CONVERSIONFROM != 'cad' ]] \
		&& [[ $CONVERSIONFROM != 'USD' ]] && [[ $CONVERSIONFROM != 'usd' ]] \
		&& [[ $CONVERSIONFROM != 'PHP' ]] && [[ $CONVERSIONFROM != 'php' ]] \
		&& [[ $CONVERSIONFROM != 'CHF' ]] && [[ $CONVERSIONFROM != 'chf' ]] \
		&& [[ $CONVERSIONFROM != 'ZAR' ]] && [[ $CONVERSIONFROM != 'zar' ]] \
		&& [[ $CONVERSIONFROM != 'AUD' ]] && [[ $CONVERSIONFROM != 'aud' ]] \
		&& [[ $CONVERSIONFROM != 'JPY' ]] && [[ $CONVERSIONFROM != 'jpy' ]] \
		&& [[ $CONVERSIONFROM != 'TRY' ]] && [[ $CONVERSIONFROM != 'try' ]] \
		&& [[ $CONVERSIONFROM != 'HKD' ]] && [[ $CONVERSIONFROM != 'hkd' ]] \
		&& [[ $CONVERSIONFROM != 'MYR' ]] && [[ $CONVERSIONFROM != 'myr' ]] \
		&& [[ $CONVERSIONFROM != 'THB' ]] && [[ $CONVERSIONFROM != 'thb' ]] \
		&& [[ $CONVERSIONFROM != 'HRK' ]] && [[ $CONVERSIONFROM != 'hrk' ]] \
		&& [[ $CONVERSIONFROM != 'NOK' ]] && [[ $CONVERSIONFROM != 'nok' ]] \
		&& [[ $CONVERSIONFROM != 'IDR' ]] && [[ $CONVERSIONFROM != 'idr' ]] \
		&& [[ $CONVERSIONFROM != 'DKK' ]] && [[ $CONVERSIONFROM != 'dkk' ]] \
		&& [[ $CONVERSIONFROM != 'CZK' ]] && [[ $CONVERSIONFROM != 'czk' ]] \
		&& [[ $CONVERSIONFROM != 'HUF' ]] && [[ $CONVERSIONFROM != 'huf' ]] \
		&& [[ $CONVERSIONFROM != 'GBP' ]] && [[ $CONVERSIONFROM != 'gbp' ]] \
		&& [[ $CONVERSIONFROM != 'MXN' ]] && [[ $CONVERSIONFROM != 'mxn' ]] \
		&& [[ $CONVERSIONFROM != 'KRW' ]] && [[ $CONVERSIONFROM != 'krw' ]] \
		&& [[ $CONVERSIONFROM != 'ISK' ]] && [[ $CONVERSIONFROM != 'isk' ]] \
		&& [[ $CONVERSIONFROM != 'SGD' ]] && [[ $CONVERSIONFROM != 'sgd' ]] \
		&& [[ $CONVERSIONFROM != 'BRL' ]] && [[ $CONVERSIONFROM != 'brl' ]] \
		&& [[ $CONVERSIONFROM != 'PLN' ]] && [[ $CONVERSIONFROM != 'pln' ]] \
		&& [[ $CONVERSIONFROM != 'INR' ]] && [[ $CONVERSIONFROM != 'inr' ]] \
		&& [[ $CONVERSIONFROM != 'RON' ]] && [[ $CONVERSIONFROM != 'ron' ]] \
		&& [[ $CONVERSIONFROM != 'CNY' ]] && [[ $CONVERSIONFROM != 'cny' ]] \
		&& [[ $CONVERSIONFROM != 'SEK' ]] && [[ $CONVERSIONFROM != 'sek' ]]  
	
	do 
		echo "ERROR: Please enter a valid option"
		echo 
		read -p "Enter currency you are converting from: " CONVERSIONFROM 
	done 
	echo 
	read -p "Enter currency you are converting to: " CONVERSIONTO
	while 
		   [[ $CONVERSIONTO != 'EUR' ]] && [[ $CONVERSIONTO != 'eur' ]] \
		&& [[ $CONVERSIONTO != 'BGN' ]] && [[ $CONVERSIONTO != 'bgn' ]] \
		&& [[ $CONVERSIONTO != 'NZD' ]] && [[ $CONVERSIONTO != 'nzd' ]] \
		&& [[ $CONVERSIONTO != 'ILS' ]] && [[ $CONVERSIONTO != 'ils' ]] \
		&& [[ $CONVERSIONTO != 'RUB' ]] && [[ $CONVERSIONTO != 'rub' ]] \
		&& [[ $CONVERSIONTO != 'CAD' ]] && [[ $CONVERSIONTO != 'cad' ]] \
		&& [[ $CONVERSIONTO != 'USD' ]] && [[ $CONVERSIONTO != 'usd' ]] \
		&& [[ $CONVERSIONTO != 'PHP' ]] && [[ $CONVERSIONTO != 'php' ]] \
		&& [[ $CONVERSIONTO != 'CHF' ]] && [[ $CONVERSIONTO != 'chf' ]] \
		&& [[ $CONVERSIONTO != 'ZAR' ]] && [[ $CONVERSIONTO != 'zar' ]] \
		&& [[ $CONVERSIONTO != 'AUD' ]] && [[ $CONVERSIONTO != 'aud' ]] \
		&& [[ $CONVERSIONTO != 'JPY' ]] && [[ $CONVERSIONTO != 'jpy' ]] \
		&& [[ $CONVERSIONTO != 'TRY' ]] && [[ $CONVERSIONTO != 'try' ]] \
		&& [[ $CONVERSIONTO != 'HKD' ]] && [[ $CONVERSIONTO != 'hkd' ]] \
		&& [[ $CONVERSIONTO != 'MYR' ]] && [[ $CONVERSIONTO != 'myr' ]] \
		&& [[ $CONVERSIONTO != 'THB' ]] && [[ $CONVERSIONTO != 'thb' ]] \
		&& [[ $CONVERSIONTO != 'HRK' ]] && [[ $CONVERSIONTO != 'hrk' ]] \
		&& [[ $CONVERSIONTO != 'NOK' ]] && [[ $CONVERSIONTO != 'nok' ]] \
		&& [[ $CONVERSIONTO != 'IDR' ]] && [[ $CONVERSIONTO != 'idr' ]] \
		&& [[ $CONVERSIONTO != 'DKK' ]] && [[ $CONVERSIONTO != 'dkk' ]] \
		&& [[ $CONVERSIONTO != 'CZK' ]] && [[ $CONVERSIONTO != 'czk' ]] \
		&& [[ $CONVERSIONTO != 'HUF' ]] && [[ $CONVERSIONTO != 'huf' ]] \
		&& [[ $CONVERSIONTO != 'GBP' ]] && [[ $CONVERSIONTO != 'gbp' ]] \
		&& [[ $CONVERSIONTO != 'MXN' ]] && [[ $CONVERSIONTO != 'mxn' ]] \
		&& [[ $CONVERSIONTO != 'KRW' ]] && [[ $CONVERSIONTO != 'krw' ]] \
		&& [[ $CONVERSIONTO != 'ISK' ]] && [[ $CONVERSIONTO != 'isk' ]] \
		&& [[ $CONVERSIONTO != 'SGD' ]] && [[ $CONVERSIONTO != 'sgd' ]] \
		&& [[ $CONVERSIONTO != 'BRL' ]] && [[ $CONVERSIONTO != 'brl' ]] \
		&& [[ $CONVERSIONTO != 'PLN' ]] && [[ $CONVERSIONTO != 'pln' ]] \
		&& [[ $CONVERSIONTO != 'INR' ]] && [[ $CONVERSIONTO != 'inr' ]] \
		&& [[ $CONVERSIONTO != 'RON' ]] && [[ $CONVERSIONTO != 'ron' ]] \
		&& [[ $CONVERSIONTO != 'CNY' ]] && [[ $CONVERSIONTO != 'cny' ]] \
		&& [[ $CONVERSIONTO != 'SEK' ]] && [[ $CONVERSIONTO != 'sek' ]]  
		
		do
			echo "ERROR: Please enter a valid option"
			echo 
			read -p "Enter currency you are converting to: " CONVERSIONTO
		done 
	echo 
	read -p "Enter amount to convert: " CONVERSIONFROMAMOUNT
	RE='^[0-9]+([.][0-9]+)?$'
	while ! [[ $CONVERSIONFROMAMOUNT =~ $RE ]]
		do 
			echo "ERROR: Please enter a valid amount" 
			echo 
			read -p "Enter amount to convert: " CONVERSIONFROMAMOUNT
		done  
	TARGETRATE=$(curl -s https://api.exchangeratesapi.io/latest?base=${CONVERSIONFROM^^} | jq ".rates.${CONVERSIONTO^^}")
	CONVERTEDAMOUNT=$(echo "$CONVERSIONFROMAMOUNT * $TARGETRATE" | bc)
	# CONVERTEDAMOUNT=$(awk "BEGIN {printf \"%.9f\n\", $CONVERSIONFROMAMOUNT * $TARGETRATE}") 
	echo =================================
	echo "$CONVERSIONFROMAMOUNT ${CONVERSIONFROM^^} equals $CONVERTEDAMOUNT ${CONVERSIONTO^^}"
	echo 
}

while true; do 
	CHOICES=("Get country information" "Use currency converter" "Quit")
	echo "What would you like to do?"
	PS3=">>> "
	select CHOICE in "${CHOICES[@]}"; do 
		case $CHOICE,$REPLY in 
		"Get country information",*|*,"Get country information")
			Get_Country_Information; 
			break 
			;;
		"Use currency converter",*|*,"Use currency converter")
			Currency_Converter;
			break
			;; 
		"Quit",*|*,"Quit")
			break 2
			;;
		*)
			echo "ERROR: Please try again" >&2
		esac  
	done
done 

# Required tools
# jq(JSON processor)
# bc 
# curl 