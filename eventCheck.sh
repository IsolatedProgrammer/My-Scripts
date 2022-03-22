#!/bin/bash
#eventCheck=START
# SCRIPT (SOURCE) FILE
#PLUGIN SCRIPT // USAGE: eventCHECK on PACKAGE

######PACKAGES to CHECK:
echo "Checking for the following PACKAGES:"
echo "- inxi"

# CUSTOM VARIABLES
commandONE="inxi"

# USING DPKG TO CHECK PACKAGE AVAILABILITY (DEFINED USING ABOVE VARIABLES):
dpkg -s $inxi &> /dev/null;
if [ $? -eq 0 ]; # BOOLING COMMAND FOR TRUE/FALSE (REGARDING USAGE/AVAILABILITY [CAN THE CMD BE RUN])
then
    echo " "
    echo "PACKAGE INSTALLED!"
    echo "CONTINUING SCRIPT WITH EXTERNAL PACKAGE... RUNNING PACKAGE..."
    echo " "
    echo "----------------------------------------------------------------------------"
    command inxi

elif [ $? -eq 1 ]; # BOOLING COMMAND FOR UNAVAILABILITY (Double-checking the EventChecker)
then # INXI
    echo " "
    echo "[INXI] PACKAGE NOT INSTALLED!"
    echo "ENTER THIS COMMAND: 'sudo apt-get install inxi' TO INSTALL THIS PACKAGE..." # INXI
    echo "CONTINUING SCRIPT WITHOUT EXTERNAL PACKAGE..."
    echo " "
    echo "----------------------------------------------------------------------------"
fi
#eventCheck=END