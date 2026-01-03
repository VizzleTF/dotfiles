#!/bin/sh

get_icon() {
    case $1 in
        # Icons for weather-icons
        01d) icon="";;
        01n) icon="";;
        02d) icon="";;
        02n) icon="";;
        03*) icon="";;
        04*) icon="";;
        09d) icon="";;
        09n) icon="";;
        10d) icon="";;
        10n) icon="";;
        11d) icon="";;
        11n) icon="";;
        13d) icon="";;
        13n) icon="";;
        50d) icon="";;
        50n) icon="";;
        *) icon="";
    esac

    echo $icon
}

KEY="e434b5435a979de6e155570590bee89b"
CITY="Limassol"  # ← Измени город
LAT="34.6741"    # ← Координаты Лимассола
LON="33.0413"
UNITS="metric"
SYMBOL="°"

API="https://api.openweathermap.org/data/2.5"

# Используй координаты вместо названия города (быстрее и точнее)
weather=$(curl -sf "$API/weather?appid=$KEY&lat=$LAT&lon=$LON&units=$UNITS")

if [ -n "$weather" ]; then
    weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
    weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")

    echo "$(get_icon "$weather_icon")" "$weather_temp$SYMBOL"
fi

