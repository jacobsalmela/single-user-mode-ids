  **BTC donations**: `1NANWvtGH8u3bzwT17DgYfBqxbjjuQZKrx`

  **LTC donations**: `LWpc6xfL2W9CH9Qse7Pci6CEvuSQUyEyD6`

![SUM-IDS](http://i.imgur.com/QOdSg59.jpg)
## Requirements
0. Admin computer running OS X 10.8-10.9
1. [terminal-notifier](https://github.com/alloy/terminal-notifier) installed on the admin computer
2. [GeekTool](http://projects.tynsoe.org/en/geektool/ "Combine GeekTool with this script to sound a klaxon when someone loads Single User Mode and then send the admin a notification") running on a server (it can be any OS X machine; it is just _acting_ as the server).
3. Static IPs set on the admin and server computers (preferred) or at least a DHCP reservation
4. An available static IP for the computers that will have the IDS installed 
5. **[.profile](https://github.com/jakesalmela/dotfiles/blob/master/.profile) installed on to each computer you want to monitor for Single-user Mode intrustion**--_very important!_
6. SSH keys for passwordless-login between the admin computer and the server
 

## What does it do?
When a computer with the [.profile script](https://github.com/jacobsalmela/dotfiles/blob/master/.profile "This script runs when booted to single user mode and is necssecary for the Geektool portion to work correctly.") is booted into Single-user Mode, it will assign itself a static IP.  This IP is constantly being pinged by another computer (the server) via a GeekTool script.  If it successfully pings that address, it sends a Notification Center message to an admin over ssh using terminal-notifier.

The .profile script will also log all commands entered into `/var/log/system/log` (timestampped).  In addition, a plist with the date Single-user mode was accessed is created in `/Library/Preferences/`.  Customize the plist name and key in the [.profile script](https://github.com/jacobsalmela/dotfiles/blob/master/.profile).

This works great if your organization does not use EFI passwords.  This way, you at least always know when someone boots into this mode.

## How it Works
This is a geeklet that runs in GeekTool every 2-10 seconds.  It needs to be used in conjunction with the [/var/root/.profile script](https://github.com/jakesalmela/dotfiles/blob/master/.profile) that assigns the computer an IP address when it is booted into Single-user Mode.

## Usage 
0. Set up a new GeekTool shell module and have it execute once every 2-10 seconds
1. Copy and paste the code in and save it (modifying it per your enviornment)
2. Any time that IP address is pingable, it will send a Notification to the admin 10.8+ computer
3. If the alert it triggered, the admin can then click the Notification to copy the MAC address to the clipboard
4. From there, they can manually paste it into a DB to find which computer it is

## Customizing

### Make Changes to the Variables
Modify the variables to suit the environment (specific IP addresses, usernames, etc.)

