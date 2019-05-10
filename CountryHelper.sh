#!/bin/bash


CIAWORLDFACTBOOK=https://raw.githubusercontent.com/iancoleman/cia_world_factbook_api/master/data/factbook.json 
RESTCOUNTRIES=https://restcountries.eu/rest/v2/name 


Get_Country_Information () {
	# Get country info
			read -p "Enter a country name: " COUNTRY 
			OUT="${COUNTRY// /%20}"
			OUT2="${COUNTRY// /_}"

			# TODO: input for South Korea, North Korea, Cote D'Ivoire(Ivory Coast)
			# ! Problems retrieving information for Cuba, Czech Republic, Democratic Republic of the Congo
			echo Native name:
			curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].nativeName" 
			echo 
			echo Historical Background:
			curl -s ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2}.data.introduction.background"
			echo 
			echo Location:
			curl -s ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2}.data.geography.location" 
			echo 
			echo Population:
			curl -s ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2}.data.people.population.total"
			echo 
			echo Population Distribution:
			curl -s ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2}.data.geography.population_distribution"
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
	read -p "Enter currency you are converting from (use three letter currency code; for list of currencies, type 'help'): " CONVERSIONFROM
			if [ $CONVERSIONFROM == "help" ]; then 
				echo =================================
				echo -e "Bulgarian Lev(BGN)\tNew Zealand Dollar(NZD)\tIsraeli Shekel(ILS)\tRussian Ruble(RUB)\tCanadian Dollar(CAD)\tUnited States Dollar(USD)\nPhilippine Peso(PHP)\tSwiss Franc(CHF)\tSouth African Rand(ZAR)\tAustralian Dollar(AUD)\tJapanese Yen(JPY)\tTurkish Lira(TRY)\nHong Kong Dollar(HKD)\tMalaysian Ringgit(MYR)\tThai Baht(THB)\t\tCroatian Kuna(HRK)\tNorwegian Krone(NOK)\tIndonesian Rupiah(IDR)\nDanish Krone(DKK)\tCzech Koruna(CZK)\tHungarian Forint(HUF)\tBritish Pound(GBP)\tMexican Peso(MXN)\tSouth Korean Won(KRW)\nIcelandic Krona(ISK)\tSingapore Dollar(SGD)\tBrazilian Real(BRL)\tPolish Zloty(PLN)\tIndian Rupee(INR)\tRomanian Leu(RON)\nChinese Yuan(CNY)\tSwedish Krona(SEK) "
				echo =================================
				read -p "Enter currency you are converting from: " CONVERSIONFROM
			fi 
			echo 
			read -p "Enter currency you are converting to (use three letter currency code; for list of currencies, type 'help'): " CONVERSIONTO
			if [ $CONVERSIONTO == "help" ]; then 
				echo =================================
				echo -e "Bulgarian Lev(BGN)\tNew Zealand Dollar(NZD)\tIsraeli Shekel(ILS)\tRussian Ruble(RUB)\tCanadian Dollar(CAD)\tUnited States Dollar(USD)\nPhilippine Peso(PHP)\tSwiss Franc(CHF)\tSouth African Rand(ZAR)\tAustralian Dollar(AUD)\tJapanese Yen(JPY)\tTurkish Lira(TRY)\nHong Kong Dollar(HKD)\tMalaysian Ringgit(MYR)\tThai Baht(THB)\t\tCroatian Kuna(HRK)\tNorwegian Krone(NOK)\tIndonesian Rupiah(IDR)\nDanish Krone(DKK)\tCzech Koruna(CZK)\tHungarian Forint(HUF)\tBritish Pound(GBP)\tMexican Peso(MXN)\tSouth Korean Won(KRW)\nIcelandic Krona(ISK)\tSingapore Dollar(SGD)\tBrazilian Real(BRL)\tPolish Zloty(PLN)\tIndian Rupee(INR)\tRomanian Leu(RON)\nChinese Yuan(CNY)\tSwedish Krona(SEK) "
				echo =================================
				read -p "Enter currency you are converting to: " CONVERSIONTO
			fi 
			echo 
			read -p "Enter amount to convert: " CONVERSIONFROMAMOUNT 
			TARGETRATE=$(curl -s https://api.exchangeratesapi.io/latest?base=${CONVERSIONFROM^^} | jq ".rates.${CONVERSIONTO^^}")
			CONVERTEDAMOUNT=$(echo "$CONVERSIONFROMAMOUNT * $TARGETRATE" | bc) 
			echo =================================
			echo "$CONVERSIONFROMAMOUNT ${CONVERSIONFROM^^} equals $CONVERTEDAMOUNT ${CONVERSIONTO^^}"
}
while true; do 
	CHOICES=("Get country information" "Use currency converter" "Quit")
	echo "What would you like to do?"
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
# curl 