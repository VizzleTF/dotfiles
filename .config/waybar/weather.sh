#!/bin/sh

get_icon() {
    case $1 in
        # Nerd Font icons
        01d) icon="☀️";;   # ясно день
        01n) icon="🌙";;   # ясно ночь
        02d) icon="⛅";;   # малооблачно день
        02n) icon="☁️";;   # малооблачно ночь
        03*) icon="☁️";;   # облачно
        04*) icon="☁️";;   # пасмурно
        09*) icon="🌧️";;  # ливень
        10d) icon="🌦️";;  # дождь день
        10n) icon="🌧️";;  # дождь ночь
        11*) icon="⛈️";;   # гроза
        13*) icon="❄️";;   # снег
        50*) icon="🌫️";;  # туман
        *) icon="🌡️";;    # неизвестно
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

