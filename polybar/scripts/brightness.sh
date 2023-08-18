#!/bin/bash

min_brightness=5
max_brightness=100
current_brightness=$(xbacklight -get)

function icon {
  if (( $(echo "$current_brightness < $min_brightness" | bc -l) )); then
    echo "%{F#F0C674}%{F-}"   # ícone de brilho mínimo
  elif (( $(echo "$current_brightness < 30" | bc -l) )); then
    echo "%{F#F0C674}%{F-}"   # ícone de brilho baixo
  elif (( $(echo "$current_brightness < 70" | bc -l) )); then
    echo "%{F#F0C674}%{F-}"   # ícone de brilho médio
  elif (( $(echo "$current_brightness < $max_brightness" | bc -l) )); then
    echo "%{F#F0C674}%{F-}"   # ícone de brilho alto
  else
    echo "%{F#F0C674}%{F-}"   # ícone de brilho máximo
  fi
}

case $1 in
  up)
    new_brightness=$(echo "$current_brightness + 5" | bc)
    if (( $(echo "$new_brightness > $max_brightness" | bc -l) )); then
      new_brightness=$max_brightness
    fi
    xbacklight -set $new_brightness
    ;;
  down)
    new_brightness=$(echo "$current_brightness - 5" | bc)
    if (( $(echo "$new_brightness < $min_brightness" | bc -l) )); then
      new_brightness=$min_brightness
    fi
    xbacklight -set $new_brightness
    ;;
  icon)
    icon
    ;;
  *)
    brightness=$(echo "scale=2; $current_brightness / 1" | bc)
    echo "$(icon) $(printf "%.0f" "$brightness")%"
    ;;
esac
