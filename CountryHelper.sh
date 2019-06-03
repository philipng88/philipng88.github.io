#!/usr/bin/env bash

CATEGORY_COLOR='\033[1;34m'
INFO_COLOR='\033[0;32m'
ERROR_COLOR='\033[0;31m'
NO_COLOR='\033[0m'

if [[ "$OSTYPE" == "darwin"* || "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]] 
	then  
	which jq > /dev/null 2>&1
	if [[ $? -ne 0 ]]; then 
		echo "jq package not found: please install"
		exit 1 
	fi 
 
elif [[ "$OSTYPE" == "linux"* ]]; then 
	if [ -e /etc/os-release ]
	then 
		source /etc/os-release 
		if [[ "$ID" =~ (debian|ubuntu|solus) || "$ID_LIKE" =~ (debian|ubuntu) ]]
		then  
			which jq > /dev/null 2>&1
			if [[ $? -ne 0 ]]; then 
				echo "jq package not found"
				echo -e "${INFO_COLOR}Installing jq${NO_COLOR}" 
				sudo apt-get install jq
			fi  
		 
		elif [[ "$ID" =~ (centos|fedora) || "$ID_LIKE" =~ (rhel|fedora) ]] 
		then
			which jq > /dev/null 2>&1
			if [[ $? -ne 0 ]]; then 
				which dnf > /dev/null 2>&1
				if [[ $? -eq 0 ]]; then 
					echo -e "${INFO_COLOR}Installing jq with dnf${NO_COLOR}"
					sudo dnf install jq
					if [[ $? -ne 0 ]]; then 
						echo -e "${INFO_COLOR}installing jq with yum${NO_COLOR}"
						sudo yum install jq
					fi 
				else 
					echo -e "${INFO_COLOR}Installing epel-release with yum${NO_COLOR}"
					sudo yum install epel-release 
					echo -e "${INFO_COLOR}Installing dnf with yum${NO_COLOR}"
					sudo yum install dnf   
					echo -e "${INFO_COLOR}Installing jq with dnf${NO_COLOR}"
					sudo dnf install jq 
					if [[ $? -ne 0 ]]; then
						echo -e "${INFO_COLOR}Installing jq with yum${NO_COLOR}" 
						sudo yum install jq 
					fi  
				fi 
			fi 	
		
		elif [[ "$ID" =~ "opensuse"* || "$ID_LIKE" =~ "suse"* ]]
		then 
			which jq > /dev/null 2>&1
			if [[ $? -ne 0 ]]; then 
				echo -e "${INFO_COLOR}Installing jq${NO_COLOR}"
				sudo zypper install jq 
			fi 
		
		elif [[ "$ID" =~ (arch|gentoo) || "$ID_LIKE" =~ (archlinux|gentoo) ]]
		then 
			which jq > /dev/null 2>&1
			if [[ $? -ne 0 ]]; then 
				echo -e "${INFO_COLOR}Installing jq${NO_COLOR}"
				sudo pacman -Sy jq 
			fi 
		fi  
	fi 
fi

CIAWORLDFACTBOOK=https://raw.githubusercontent.com/iancoleman/cia_world_factbook_api/master/data/factbook.json 
RESTCOUNTRIES=https://restcountries.eu/rest/v2/name 

Get_Country_Information () {
	read -p "Enter a country name: " COUNTRY 
	OUT="${COUNTRY// /%20}"
	OUT2="${COUNTRY// /_}"

	# User input modification for alternative or common spellings
	case "${COUNTRY,,}" in 
		"america"|"usa"|"u.s.a."|"united states")
			OUT="United%20States%20Of%20America"
			OUT2="united_states"
			;; 
		"england"|"great britain"|"uk"|"u.k."|"united kingdom")
			OUT="United%20Kingdom%20of%20Great%20Britain%20and%20Northern%20Ireland"
			OUT2="united_kingdom"
			;;
		"czech republic")
			OUT2="czechia"
			;;
		"south korea")
			OUT="Korea%20(Republic%20of)" 
			OUT2="korea_south"
			;;
		"north korea")
			OUT="Korea%20(Democratic%20People's%20Republic%20of)"
			OUT2="korea_north"
			;;
		"bahamas"|"the bahamas")
			OUT2="bahamas_the"
			;;
		"virgin islands")
			echo -e "${ERROR_COLOR}ERROR:${NO_COLOR}Please specify either the 'British Virgin Islands' or the 'U.S. Virgin Islands'"
			OUT=""
			OUT2="" 
			;; 
		"british virgin islands")
			OUT="Virgin%20Islands%20(British)"
			OUT2="british_virgin_islands"
			;;
		"us virgin islands"|"u.s. virgin islands"|"united states virgin islands")
			OUT="Virgin%20Islands%20(U.S.)"
			OUT2="virgin_islands"
			;;
		"cape verde")
			OUT="Cabo%20Verde"
			OUT2="cabo_verde"
			;;
		"cocos keeling islands"|"cocos (keeling) islands"|"cocos islands")
			OUT="Cocos%20(Keeling)%20Islands"
			OUT2="cocos_keeling_islands"
			;;
		"congo"|"the congo")
			echo -e "${ERROR_COLOR}ERROR:${NO_COLOR}Please specify either the 'Republic of the Congo' or the 'Democratic Republic of the Congo'"
			OUT=""
			OUT2=""
			;;
		"republic of the congo")
			OUT="congo"
			OUT2="congo_republic_of_the"
			;;
		"democratic republic of the congo")
			OUT="congo%20(democratic%20republic%20of%20the)"
			OUT2="congo_democratic_republic_of_the"
			;;	
		"falkland islands")
			OUT="Falkland%20Islands%20(Malvinas)"
			OUT2="falkland_islands_islas_malvinas"
			;;	
		"gambia"|"the gambia")
			OUT="gambia" 
			OUT2="gambia_the" 
			;;
		"guinea-bissau")
			OUT2="guinea_bissau"
			;;
		"holy see"|"vatican city")
			OUT="holy%20see"
			OUT2="holy_see_vatican_city"
			;;
		"cote d'ivoire"|"ivory coast")
			OUT="cote%20d'ivoire"
			# OUT2=
			;;
	esac 
	
	echo 
	echo -e "${CATEGORY_COLOR}Native name:${NO_COLOR}"
	curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].nativeName" 
	echo 
	echo -e "${CATEGORY_COLOR}Historical Background:${NO_COLOR}"
	curl -# ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2,,}.data.introduction.background"
	echo 
	echo -e "${CATEGORY_COLOR}Location:${NO_COLOR}"
	curl -# ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2,,}.data.geography.location" 
	echo 
	echo -e "${CATEGORY_COLOR}Population:${NO_COLOR}"
	curl -# ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2,,}.data.people.population.total"
	echo 
	echo -e "${CATEGORY_COLOR}Population Distribution:${NO_COLOR}"
	curl -# ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2,,}.data.geography.population_distribution"
	echo 
	echo -e "${CATEGORY_COLOR}Economy:${NO_COLOR}"
	curl -# ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2,,}.data.economy.overview"
	echo 
	echo -e "${CATEGORY_COLOR}Flag Description:${NO_COLOR}"
	curl -# ${CIAWORLDFACTBOOK} | jq -r ".countries.${OUT2,,}.data.government.flag_description.description" 
	echo 
	echo -e "${CATEGORY_COLOR}Capital:${NO_COLOR}"
	curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].capital"
	echo 
	echo -e "${CATEGORY_COLOR}Languages:${NO_COLOR}" 
	curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].languages[].name"
	echo 
	echo -e "${CATEGORY_COLOR}Currency:${NO_COLOR}"
	curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].currencies[].name" 
	echo 
	echo -e "${CATEGORY_COLOR}Timezone(s):${NO_COLOR}"
	curl -s ${RESTCOUNTRIES}/${OUT} | jq -r ".[0].timezones[]"
	echo 
}

Currency_Converter () {
	echo =================================================================================================================
	echo -e "Bulgarian Lev(BGN)\t\tNew Zealand Dollar(NZD)\t\tIsraeli Shekel(ILS)\t\tRussian Ruble(RUB)\nCanadian Dollar(CAD)\t\tUnited States Dollar(USD)\tPhilippine Peso(PHP)\t\tSwiss Franc(CHF)\nSouth African Rand(ZAR)\t\tAustralian Dollar(AUD)\t\tJapanese Yen(JPY)\t\tTurkish Lira(TRY)\nHong Kong Dollar(HKD)\t\tMalaysian Ringgit(MYR)\t\tThai Baht(THB)\t\t\tCroatian Kuna(HRK)\nNorwegian Krone(NOK)\t\tIndonesian Rupiah(IDR)\t\tDanish Krone(DKK)\t\tCzech Koruna(CZK)\nHungarian Forint(HUF)\t\tBritish Pound(GBP)\t\tMexican Peso(MXN)\t\tSouth Korean Won(KRW)\nIcelandic Krona(ISK)\t\tSingapore Dollar(SGD)\t\tBrazilian Real(BRL)\t\tPolish Zloty(PLN)\nIndian Rupee(INR)\t\tRomanian Leu(RON)\t\tChinese Yuan(CNY)\t\tSwedish Krona(SEK)\nEuro(EUR)"
	echo =================================================================================================================
	CURRENCIES=(BGN NZD ILS RUB CAD USD PHP CHF ZAR AUD JPY TRY HKD MYR THB HRK NOK IDR DKK CZK HUF GBP MXN KRW ISK SGD BRL PLN INR RON CNY SEK EUR \n 
	            bgn nzd ils rub cad usd php chf zar aud jpy try hkd myr thb hrk nok idr dkk czk huf gbp mxn krw isk sgd brl pln inr ron cny sek eur) 
	echo 
	read -p "Enter currency you are converting from: " CONVERSIONFROM
	i=0 
	len=${#CURRENCIES[*]}
	while [ $len -gt $i ]
		do
			if [ "${CURRENCIES[$i]}" == "$CONVERSIONFROM" ]
				then 
					echo 
					read -p "Enter currency you are converting to: " CONVERSIONTO
					j=0
					len2=${#CURRENCIES[*]}
					while [ $len2 -gt $j ]
						do 
							if [ "${CURRENCIES[$j]}" == "$CONVERSIONTO" ]
								then 
								echo 
								read -p "Enter amount to convert: " CONVERSIONFROMAMOUNT 
								local RE='^[0-9]+([.][0-9]+)?$'
								while ! [[ $CONVERSIONFROMAMOUNT =~ $RE ]]
									do 
										echo -e "${ERROR_COLOR}ERROR:${NO_COLOR} Please enter a valid amount (e.g., 500)" 
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
								echo -e "${ERROR_COLOR}ERROR:${NO_COLOR} You must enter a valid three-letter currency code (e.g., USD)"
								echo 
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
				echo -e "${ERROR_COLOR}ERROR:${NO_COLOR} You must enter a valid three-letter currency code (e.g., USD)"
				echo 
				read -p "Enter currency you are converting from: " CONVERSIONFROM 
				i=0 
			fi 
		done 
}

while true; do 
	CHOICES=("Get country information" "Use currency converter" "Quit")
	echo 
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
			echo -e "${ERROR_COLOR}ERROR:${NO_COLOR} Please try again" >&2
		esac  
	done
done 