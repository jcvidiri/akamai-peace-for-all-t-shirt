#!/bin/bash

# Congratulations! You found the easter egg! ❤️
# おめでとうございます！隠されたサプライズを見つけました！❤️

# Define the text to animate
text="♥PEACE♥FOR♥ALL♥PEACE♥FOR♥ALL♥PEACE♥FOR♥ALL♥PEACE♥FOR♥ALL♥PEACE♥FOR♥ALL♥"

# Get terminal dimensions
cols=$(tput cols)
lines=$(tput lines)

# Calculate the length of the text
text_length=${#text}

# Hide the cursor
tput civis

# Trap CTRL+C to show the cursor before exiting
trap "tput cnorm; exit" SIGINT

# Set frequency scaling factor
freq=0.2

# Infinite loop for continuous animation
for (( t=0; ; t+=1 )); do
    # Extract one character at a time
    char="${text:t % text_length:1}"
    
    # Calculate the angle in radians
    angle=$(echo "($t) * $freq" | bc -l)

    # Calculate the sine of the angle
    sine_value=$(echo "s($angle)" | bc -l)

    # Calculate x position using the sine value
    x=$(echo "($cols / 2) + ($cols / 4) * $sine_value" | bc -l)
    x=$(printf "%.0f" "$x")

    # Ensure x is within terminal bounds
    if (( x < 0 )); then x=0; fi
    if (( x >= cols )); then x=$((cols - 1)); fi

    # Calculate color gradient between 12 (cyan) and 208 (orange)
    color_start=12
    color_end=208
    color_range=$((color_end - color_start))
    color=$((color_start + (color_range * t / lines) % color_range))

    # Print the character with 256-color support
    echo -ne "\033[38;5;${color}m"$(tput cup $t $x)"$char\033[0m"

    # Line feed to move downward
    echo ""

done