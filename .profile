#!/bin/bash
#----------VARIABLES---------
	ethernetID="en0"	
	ethernetIP="10.x.x.x 255.x.x.x"
	orgName="com.organization.casper"
	currentDate=$(date "+%Y-%m-%d %H:%M:%S")

#----------FUNCTIONS---------
#######################
function mountAndLoad()
  {
	/sbin/mount -uw /
	sleep 2
	#launchctl load /System/Library/LaunchDaemons/com.apple.kextd.plist
	#launchctl load /System/Library/LaunchDaemons/com.apple.notifyd.plist
	launchctl load /System/Library/LaunchDaemons/com.apple.configd.plist &&
	sleep 15
	launchctl load /System/Library/LaunchDaemons/com.apple.syslogd.plist
	}

##########################
function setWiredAddress()
	{
	ifconfig $ethernetID $ethernetIP
	#ipconfig set $ethernetID INFORM $ethernetIP	
	}

##########################
function setPromptCommand()
	{
	PROMPT_COMMAND='history -a;tail -n1 ~/.sh_history | logger -t SUM-IDS'
	}

##########################
function logDateInPlist()
	{
	/usr/libexec/PlistBuddy -c "Print :SingleUserModeAccessedOn" /Library/Preferences/"$orgName".plist &>/dev/null
	if [ $? = 0 ];then
		/usr/libexec/PlistBuddy -c "Delete :SingleUserModeAccessedOn" /Library/Preferences/"$orgName".plist &>/dev/null
		/usr/libexec/PlistBuddy -c "Add :SingleUserModeAccessedOn string '$currentDate'" /Library/Preferences/"$orgName".plist &>/dev/null	

	else
		/usr/libexec/PlistBuddy -c "Add :SingleUserModeAccessedOn string '$currentDate'" /Library/Preferences/"$orgName".plist &>/dev/null
	fi
	}

####################
function warnUser()
	{
	clear
	echo "\n\n\n\nShould you really be here?  You might not like the consequences."
	echo "\n\tThe network administrator has already been notified."
	echo "\nType reboot, then press Enter.\n"
	}

#---------------------------------#
#----------SCRIPT BEGINS----------#
#---------------------------------#
if [ $TERM = "vt100" ];then
	mountAndLoad
	setWiredAddress
	setPromptCommand
	logDateInPlist
	warnUser
fi
