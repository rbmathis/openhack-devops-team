#!/bin/bash

#Will set a GH env var called SITESTATUS to either true or false

declare endpoint
declare textToCheck

endpoint=$1			#Url to curl
textToCheck=$2		#Text to check for existence in the curl result, fails if not found


result=$(curl $endpoint)
declare status
if [[ -z $result ]]; then 
	status="N/A"
	echo "Site not found at $endpoint"
	APISTATUS="Down"
	echo ::set-env name=SITESTATUS::false

	else

		if [[ $result == *"$textToCheck"* ]]; then

			echo "yep"
			APISTATUS="Up"
			echo ::set-env name=SITESTATUS::true

		else
			echo "nope"
			APISTATUS="Down"
			echo ::set-env name=SITESTATUS::false
		fi

fi


exit 0;
