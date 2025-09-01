#!/bin/bash
# Get the current volume level using wpctl
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}' | tr -d '.')
VOLUME_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ $2 = ($2 * 100); print }')

LAPTOP_BATTERY=80;
BLUETOOTH_BATTERY=80;

# Get the default sink name
DEFAULT_SINK=$(pactl info | grep "Default Sink" | awk '{print $3}')
DEVICE_NAME="VOSTRO"
# Extract the device name from the sink
if [[ $DEFAULT_SINK == *"bluez"* ]]; then
    BLUETOOTH_BATTERY=$(bluetoothctl info | grep Battery | awk '{print $4}' | tr -d '()');
    name=$(bluetoothctl info | grep "Name" | awk '{$1=""; print $0}' | sed 's/^ //');

    DEVICE_NAME="$name ($BLUETOOTH_BATTERY) -> "
else
    LAPTOP_BATTERY=$(acpi -b | awk '{print $4}' | tr -d '%,' | head -n 1)
    DEVICE_NAME="Laptop(vostro 3478) $LAPTOP_BATTERY -> "
fi

notify-send -a "volume" "$DEVICE_NAME" -r 1 -h int:value:"$VOLUME" -t 1000 "$VOLUME_INFO%" 



# Send the notification

# Check if the battery level is below 40%
if [ "$BLUETOOTH_BATTERY" -lt 50 ]; then
    notify-send -u low "$DEVICE_NAME Battery Low" "Battery level is at $BLUETOOTH_BATTERY% :-"
fi

