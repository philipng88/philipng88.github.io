#!/bin/bash

CIAWORLDFACTBOOK=https://raw.githubusercontent.com/iancoleman/cia_world_factbook_api/master/data/factbook.json 
RESTCOUNTRIES=https://restcountries.eu/rest/v2/name 

Get_Country_Information () {
	read -p "Enter a country name: " COUNTRY 
	OUT="${COUNTRY// /%20}"
	OUT2="${COUNTRY// /_}"

	if [[ "$COUNTRY" == "Czech Republic" ]] || [[ "$COUNTRY" == "czech republic" ]]
	then 
		OUT2="czechia" 
	elif [[ "$COUNTRY" == "South Korea" ]] || [[ "$COUNTRY" == "south korea" ]]
	then 
		OUT="Korea%20(Republic%20of)" 
		OUT2="korea_south"
	elif [[ "$COUNTRY" == "North Korea" ]] || [[ "$COUNTRY" == "north korea" ]]
	then 
		OUT="Korea%20(Democratic%20People's%20Republic%20of)"
		OUT2="korea_north" 
	fi 
	echo Native name:
	curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].nativeName" 
	echo 
	echo Historical Background:
	curl -# ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2,,}.data.introduction.background"
	echo 
	echo Location:
	curl -# ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2,,}.data.geography.location" 
	echo 
	echo Population:
	curl -# ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2,,}.data.people.population.total"
	echo 
	echo Population Distribution:
	curl -# ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2,,}.data.geography.population_distribution"
	echo 
	echo Flag Description:
	curl -# ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2,,}.data.government.flag_description.description" 
	echo 
	echo Capital:
	curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].capital"
	echo 
	echo Languages: 
	curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].languages[].name"
	echo 
	echo Currency:
	curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].currencies[].name" 
	echo 
	echo 'Timezone(s):'
	curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].timezones[]"
	echo 
}

Currency_Converter () {
	echo =============================================================================================
	echo -e "Bulgarian Lev(BGN)\tNew Zealand Dollar(NZD)\tIsraeli Shekel(ILS)\tRussian Ruble(RUB)\tCanadian Dollar(CAD)\tUnited States Dollar(USD)\nPhilippine Peso(PHP)\tSwiss Franc(CHF)\tSouth African Rand(ZAR)\tAustralian Dollar(AUD)\tJapanese Yen(JPY)\tTurkish Lira(TRY)\nHong Kong Dollar(HKD)\tMalaysian Ringgit(MYR)\tThai Baht(THB)\t\tCroatian Kuna(HRK)\tNorwegian Krone(NOK)\tIndonesian Rupiah(IDR)\nDanish Krone(DKK)\tCzech Koruna(CZK)\tHungarian Forint(HUF)\tBritish Pound(GBP)\tMexican Peso(MXN)\tSouth Korean Won(KRW)\nIcelandic Krona(ISK)\tSingapore Dollar(SGD)\tBrazilian Real(BRL)\tPolish Zloty(PLN)\tIndian Rupee(INR)\tRomanian Leu(RON)\nChinese Yuan(CNY)\tSwedish Krona(SEK)\tEuro(EUR)"
	echo =============================================================================================
	CURRENCIES=(BGN NZD ILS RUB CAD USD PHP CHF ZAR AUD JPY TRY HKD MYR THB HRK NOK IDR DKK CZK HUF GBP MXN KRW ISK SGD BRL PLN INR RON CNY SEK EUR \n 
	            bgn nzd ils rub cad usd php chf zar aud jpy try hkd myr thb hrk nok idr dkk czk huf gbp mxn krw isk sgd brl pln inr ron cny sek eur) 
	read -p "Enter currency you are converting from: " CONVERSIONFROM
	i=0 
	len=${#CURRENCIES[*]}
	while [ $len -gt $i ]
		do
			if [ "${CURRENCIES[$i]}" == "$CONVERSIONFROM" ]
				then 
					read -p "Enter currency you are converting to: " CONVERSIONTO
					j=0
					len2=${#CURRENCIES[*]}
					while [ $len2 -gt $j ]
						do 
							if [ "${CURRENCIES[$j]}" == "$CONVERSIONTO" ]
								then 
								read -p "Enter amount to convert: " CONVERSIONFROMAMOUNT 
								RE='^[0-9]+([.][0-9]+)?$'
								while ! [[ $CONVERSIONFROMAMOUNT =~ $RE ]]
									do 
										echo "ERROR: Please enter a valid amount" 
										echo 
										read -p "Enter amount to convert: " CONVERSIONFROMAMOUNT
									done  
								TARGETRATE=$(curl -s https://api.exchangeratesapi.io/latest?base=${CONVERSIONFROM^^} | jq ".rates.${CONVERSIONTO^^}")
								# CONVERTEDAMOUNT=$(echo "$CONVERSIONFROMAMOUNT * $TARGETRATE" | bc)
								CONVERTEDAMOUNT=$(awk "BEGIN {printf \"%.9f\n\", $CONVERSIONFROMAMOUNT * $TARGETRATE}")
								echo =================================
								echo "$CONVERSIONFROMAMOUNT ${CONVERSIONFROM^^} equals $CONVERTEDAMOUNT ${CONVERSIONTO^^}"
								echo 
								break  
								else 
								j=$(( $j + 1 ))
							fi 
							
							if [ $j -eq $(( $len2 )) ]
								then
								echo "ERROR: Please enter a valid option"
								read -p "Enter currency you are converting to: " CONVERSIONTO 
								j=0 
							fi 
						done
				break  
				else 
				i=$(( $i + 1 ))
			fi 
			
			if [ $i -eq $(( $len )) ]
				then
				echo "ERROR: Please enter a valid option"
				read -p "Enter currency you are converting from: " CONVERSIONFROM 
				i=0 
			fi 
		done 
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