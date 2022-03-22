#!/bin/bash


# SCRIPT RUN COMMAND "sudo bash ./iptables_script"


# NAME: IPTABLES_SCRIPT (Temporary)
# ASSIGNMENT INFO: ISEC2022 Assignment1 Information
# AUTHOR: Rialey, K-J.
# CREATION DATE: January 28, 2022
# LATEST UPDATE: February 10 (23:36PM), 2022


#SCRIPT START
# CUSTOM VARIABLES
USER="architect" # [Case Sensitive] MUST BE THE CURRENT USER FOR SCRIPT TO FUNCTION.
SERVER=192.168.4.2
TECHSUPPORT=192.168.4.5
UPDATESERVER=192.168.4.7



# DIRECTORY CONFIGURATION (INCLUDES TESTING PATHs; COMMENTED PATHS DUE TO LATER UPDATES)
FILEPATH=/home/$USER/Desktop/Scripts/Bash/fwConf
FILEDIR=/home/$USER/Desktop/Scripts/Bash/fwConf/logs
#LOGGING=/home/$USER/Desktop/Scripts/Bash/fwConf/logs/changes.log # LOGGING COMMANDS; NOTED [LOGGING] FOR EACH USE.



# POLICY CONFIGURATION
sudo iptables --policy INPUT DROP
sudo iptables --policy OUTPUT ACCEPT
sudo iptables --policy FORWARD DROP



# LOOPBACK INTERFACE (ALL TRAFFIC)
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT



# FIREWALL CONFIGURATION
#FLUSH CURRENT FIREWALL RULES & DISPLAY OUTPUT (TERMINAL)
# -F for Flush | -L for Listing the (Updated) Rules | Verbose to read the info easier (+more info)
echo " "
echo "FLUSHING CURRENT TABLES..."
echo "---------------------------------------------------------"
sudo iptables -F -v # Flushes Rules Each Time Script Executes



# (Output) Terminal Formatting...
echo " "



sudo iptables -F -v > $FILEDIR/initialstate.log # [LOGGING] # Terminal will NOT display THIS command. [NOTE: RESETS THE PREVIOUS LOG FILES UPON EACH SCRIPT EXECUTION - TO DISABLE, COMMENT THIS ENTIRE LINE OUT FROM THE VERY BEGINNING OF THE LINE (FARTHEST TO THE LEFT).
echo "REFRESHED TABLES..."
echo "---------------------------------------------------------"
sudo iptables -L -v # Lists the (NEW) current ruleset.
sudo iptables -L -v >> $FILEDIR/initialstate.log # [LOGGING] # Terminal will NOT display THIS command.



echo " "
echo "UPDATING INBOUND & OUTBOUND TRAFFIC + PORTS..."
echo "---------------------------------------------------------"



# ALLOWING / DISALLOWING INBOUND OR OUTBOUND TRAFFIC
#[ALLOW] INBOUND SSH (TECH SUPPORT)
sudo iptables -A INPUT -p tcp -d 0/0 -s $TECHSUPPORT --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT


#[ALLOW] OUTBOUND FTP (SERVER)
sudo iptables -A OUTPUT -p tcp -s 0/0 -d $SERVER --dport 21 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT


#[ALLOW] INBOUND FTP (UPDATE SERVER)
sudo iptables -A INPUT -p tcp -s $UPDATESERVER -d 0/0 --dport 21 -m conntrack --ctstate NEW,ESTABLISHED -j DROP


#sudo iptables -L -v >> $FILEDIR/initialstate.log [Unsure of Order]


# (Output) Terminal Formatting...
echo "INBOUND & OUTBOUND + PORT CONFIGURATIONS COMPLETE..."
echo " "
echo "LISTING CURRENTLY CONFIGURED TABLES..."
echo "---------------------------------------------------------"



# SAVING IPTABLES CONFIGURATION (CONFIGUREDSTATE)
#SEE UPDATED LIST OF RULES (ALONG WITH SAVING CONFIG)
sudo iptables -L -v
echo " " >> $FILEDIR/configuredstate.log
echo " " >> $FILEDIR/configuredstate.log
sudo iptables-save > $FILEDIR/configuredstate.log
sudo iptables -L -v >> $FILEDIR/configuredstate.log


# (Output) Terminal Formatting...
echo "---------------------------------------------------------"
echo "SCRIPT COMPLETE... CONFIGURATION COMPLETE & UPDATED TABLES FOR NEW & ESTABLISHED CONNECTIONS..."



# SAVING IPTABLES CONFIGURATION (INITIALSTATE) [Unused]
#echo " " >> $FILEDIR/initialstate.log
#echo " " >> $FILEDIR/initialstate.log
#sudo iptables-save >> $FILEDIR/initialstate.log
#SCRIPT END
