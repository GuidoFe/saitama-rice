#!/bin/bash

APIKEY=`cat $HOME/.owm-key.txt | head -z -n 1 | cut -f 2 -d ' '`
ID=`cat $HOME/.owm-key.txt | head -z -n 1 | cut -f 1 -d ' '`
CITYNAME='Ferrara'
COUNTRYCODE='IT'
# UNITS can be metric or imperial. To have Kelvin, delete &units=$UNITS from the url entirely
UNITS="metric"
RESPONSE=""
BLANK=0
URL='api.openweathermap.org/data/2.5/weather?id='"$ID"'&APPID='"$APIKEY"'&units='"$UNITS"'&q='"$CITYNAME,$COUNTRYCODE"

function getData {
    BLANK=0
    echo " " >> "$HOME/.weather.log"
    echo `date`" ################################" >> "$HOME/.weather.log"
    RESPONSE=`curl -s $URL`
    CODE="$?"
    echo "Response: $RESPONSE" >> "$HOME/.weather.log"
    RESPONSECODE=0
    if [ $CODE -eq 0 ]; then
        RESPONSECODE=`echo $RESPONSE | jq .cod`
    fi
    if [ $CODE -ne 0 ] || [ $RESPONSECODE -ne 200 ]; then
        if [ $CODE -ne 0 ]; then
            echo "curl Error $CODE" >> "$HOME/.weather.log"
        else
            echo "API Error $RESPONSECODE" >> "$HOME/.weather.log"
        fi
        if [ -f "$HOME/.weather-last" ]; then
            OLDRESPONSE=`cat "$HOME/.weather-last" | head -n 1`
            DATE=`date +%s`
            OLDDATE=`cat "$HOME/.weather-last" | tail -n 1`
            DIFF=`echo "$DATE - $OLDDATE" | bc`
            if [ $DIFF -gt 7200 ]; then
                BLANK=1
                rm "$HOME/.weather-last"
            else
                RESPONSE="$OLDRESPONSE"
            fi
        else
            BLANK=1
        fi
    else
        echo "$RESPONSE" > "$HOME/.weather-last"
        echo `date +%s` >> "$HOME/.weather-last"
    fi
}

function setIcons {
    if [ $WID -le 232 ]; then
        #Thunderstorm
        ICON="%{F#8f3f71}%{F-}"
    elif [ $WID -le 311 ]; then
        #Light drizzle
        ICON="%{F#427b58}%{F-}"
    elif [ $WID -le 321 ]; then
        #Heavy drizzle
        ICON="%{F#427b58}%{F-}"
    elif [ $WID -le 531 ]; then
        #Rain
        ICON="%{F#076678}%{F-}"
    elif [ $WID -le 622 ]; then
        #Snow
        ICON="%{F#bdae93}%{F-}"
    elif [ $WID -le 771 ]; then
        #Fog
        ICON="%{F#665c54}%{F-}"
    elif [ $WID -eq 781 ]; then
        #Tornado
        ICON="%{F#504945}%{F-}"
    elif [ $WID -eq 800 ]; then
        #Clear sky
        if [ $DATE -ge $SUNRISE -a $DATE -le $SUNSET ]; then
            ICON="%{F#b57614}%{F-}"
        else
            ICON="%{F#bdae93}%{F-}"
        fi
    elif [ $WID -eq 801 ]; then
        if [ $DATE -ge $SUNRISE -a $DATE -le $SUNSET ]; then
            ICON="%{F#bdae93}%{F-}"
        else
            ICON="%{F#bdae93}%{F-}"
        fi
    elif [ $WID -le 804 ]; then
        ICON="%{F#bdae93}%{F-}"
    else
        ICON=""
    fi
    WINDFORCE=`echo "$RESPONSE" | jq .wind.speed`
    if [ `echo "$WINDFORCE >= 5" | bc` -eq 1 ]; then
        WIND="%{F#076678}%{F-} "
    fi
    
    TEMP=`echo "$TEMP" | cut -d "." -f 1`
    
    if [ "$TEMP" -le 0 ]; then
        TEMP="%{F#076678}%{T2}%{T-}%{F-} $TEMP°C"
    elif [ `echo "$TEMP >= 25" | bc` -eq 1 ]; then
        TEMP="%{F#9d0006}%{T2}%{T-}%{F-} $TEMP°C"
    else
        TEMP="%{T2}%{T-} $TEMP°C"
    fi
}

function outputCompact {
    OUTPUT="%{T2}$WIND$ICON%{T-} $DESCRIPTION | $TEMP"
    echo "Output: $OUTPUT" >> "$HOME/.weather.log"
    echo "$OUTPUT"
}

getData
if [ $BLANK -eq 0 ]; then
    MAIN=`echo $RESPONSE | jq .weather[0].main`
    WID=`echo $RESPONSE | jq .weather[0].id`
    DESC=`echo $RESPONSE | jq .weather[0].description`
    SUNRISE=`echo $RESPONSE | jq .sys.sunrise`
    SUNSET=`echo $RESPONSE | jq .sys.sunset`
    DATE=`date +%s`
    WIND=""
    TEMP=`echo $RESPONSE | jq .main.temp`
    DESCRIPTION=`echo $RESPONSE | jq .weather[0].description | tr -d '"' | sed 's/.*/\L&/; s/[a-z]*/\u&/g'`
    PRESSURE=`echo $RESPONSE | jq .main.pressure`
    HUMIDITY=`echo $RESPONSE | jq .main.humidity`
    setIcons
    outputCompact
else
    echo " "
fi
