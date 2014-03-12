#!/bin/bash
# Jacob Salmela
# 10 March 2014

# Geeklet to be used with GeekTool and the /var/root/.profile IDS

# Pings the IP address that any computer gets when booted to Single-User Mode
# Works best to set it to ping every 2 seconds (set refresh rate in Geektool)
ping -c 1 10.x.x.x &> /dev/null

# If that address is pingable,
if [ $? = 0 ];then
  # Set a variable to store the MAC address of that machine, captured from the ARP cache
	macAddr=$(arp -an | awk '/10.x.x.x/ {print $4}')
	echo $macAddr
	
	# Send a message to the admin computer via terminal-notifier
	echo "Sending notification of intrusion to admins..."
	ssh admin@10.x.x.x "/usr/local/bin/terminal-notifier \
							-title "\"INTRUDER ALERT\"" \
							-subtitle "\"Single-user Mode accessed on\"" \
							-message "\"$macAddr Click to copy to clipboard\"" \
							# Custom sound here, if desired
							# Othwerise, just choose a system sound
							-sound IDS \
							# Execute the command when the notification is clicked by the admin
							# In this case, it copies the MAC address to their clipboard
							# From there, it can be looked up in a DB to find out which computer it is
							-execute "\"echo $macAddr \| pbcopy \"""
	echo "Notification Center message sent to admins..."
	
	# Send a text message to the admin
	# http://osxdaily.com/2014/03/12/send-sms-text-message-from-command-line/
	curl http://textbelt.com/text -d number=<ten_digit_phone_number_here> -d "message=Single=user Mode Detected: $"
fi
