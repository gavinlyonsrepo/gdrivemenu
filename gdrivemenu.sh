#!/bin/bash
#=========================HEADER==========================================

#name: Gdrive menu
#Title : Gdrive menu
#Description: A CLI wrapper for the CLI google drive client "gdrive"
#Version : 1.0-1
#License: GPL
#Written by: Gavin Lyons
#URL: 

#=======================GLOBAL VARIABLES SETUP=============================
#colours for printf
RED=$(printf "\033[31;1m")
GREEN=$(printf "\033[32;1m")
YELLOW=$(printf "\033[33;1m")
BLUE=$(printf "\033[36;1m")
HL=$(printf "\033[42;1m")
NORMAL=$(printf "\033[0m")

#prompt for select menus
PS3="${BLUE}By your command:${NORMAL}"

DESTCONFIG_PATH="$HOME/.config/gdrivemenu/"
mkdir -p "$DESTCONFIG_PATH"
DESTCONFIG_FILE="gdrivemenu.conf"


#FUNCTION HEADER
# NAME : msgFunc
# DESCRIPTION :   prints to screen
#prints line, text and anykey prompts, yesno prompt
# INPUTS : $1 process name $2 text input
# PROCESS :[1]  print line [2] anykey prompt
# [3] print text  "green , red ,blue , norm yellow and highlight" [4] yn prompt, 
# OUTPUT yesno prompt return 1 or 0
function msgFunc
{
	case "$1" in 
	
		line) #print blue horizontal line of =
			printf '\033[36;1m%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
			printf '%s' "${NORMAL}"
		;;
		anykey) #any key prompt, appends second text input to prompt
		    printf '%s' "${GREEN}" 
			read -n 1 -r -s -p "Press any key to continue $2"
			printf '%s\n' "${NORMAL}"
		;;
		
		#print passed text string
		green) printf '%s\n' "${GREEN}$2${NORMAL}" ;;
		red) printf '%s\n' "${RED}$2${NORMAL}" ;;
		blue) printf '%s\n' "${BLUE}$2${NORMAL}" ;;
		yellow)printf '%s\n' "${YELLOW}$2${NORMAL}" ;;
		highlight)printf '%s\n' "${HL}$2${NORMAL}" ;;
		norm) printf '%s\n' "${NORMAL}$2" ;;
			
		yesno) #print yes no quit prompt
			local yesnoVar=""
			while true; do
				read -r yesnoVar
				case $yesnoVar in
					[Yy]*) return 0;;
					[Nn]*) return 1;;
					[Qq]*) exitHandlerFunc exitout;;
					*) printf '%s\n' "${YELLOW}Please answer: (y/Y for yes) OR (n/N for no) OR (q/Q to quit)!${NORMAL}";;
				esac
			done
		;;
		*) 
			printf '%s\n' "ERROR unknown input to msgFunc"
			 ;;
	esac
}

#FUNCTION HEADER
# NAME : makeDirFunc
# DESCRIPTION :  makes a directory with time/date stamp and enters it

function makeDirFunc
{
	local dirVar=""
	#makes dirs for output appends passed text to name
	#check if coming from system backup other path 1 yes 0 no.
	dirVar="/tmp/$(date +%H%M-%d%b%y)$1"
	mkdir "$dirVar"
	cd "$dirVar" || exitHandlerFunc "$dirVar"
	msgFunc norm "Directory for output made at:-"
	pwd	 
}

#FUNCTION HEADER
# NAME :  exitHandlerFunc 
# DESCRIPTION: error handler deal with user 
# INPUTS:  $2 text of filename 
function exitHandlerFunc
{
	case "$1" in
			exitout) msgFunc norm "";;
			DESTCONFIG) 
				msgFunc red "Path not found to Destination directory"
				msgFunc norm "$DESTCONFIG_PATH" ;;
			fileerror) msgFunc red "Problem with config file found: "
			msgFunc red "$DESTCONFIG_FILE"
			msgFunc red "File error $2"  ;;
			*) msgFunc yellow "Unknown input to error handler";;
	 esac
	msgFunc yellow "Goodbye $USER!"
	msgFunc anykey "and exit."
	if [ "$1" = "exitout" ]
	then
		#non-error exit
		exit 0
	fi 
	exit 1
}


#FUNCTION HEADER
# NAME :           readconfigFunc
# DESCRIPTION:read the config file into program if not there   
#use hardcoded defaults config file is for paths for backup function
#Called when needed by program also can be called by user option or main menu
# passed USERCALL
# INPUTS $1 USERCALL when called by user
# OUTPUTS : sets paths for backup function 
# PROCESS : read $DEST5/cylonCfg.conf
#NOTES :   file is optional       
function readconfigFunc
{
	#changepath
	cd "$DESTCONFIG_PATH"  || exitHandlerFunc DESTCONFIG_PATH	
	#read .conf 
	msgFunc green "Reading gdrivemenu config file  at:-"
	msgFunc norm "$DESTCONFIG_PATH""$DESTCONFIG_FILE"
	#check if file there if not use defaults.
	if [ ! -f "$DESTCONFIG_PATH""$DESTCONFIG_FILE" ]
		then
		exitHandlerFunc fileerror "$DESTCONFIG_FILE"
		
	fi
	source ./"$DESTCONFIG_FILE" || exitHandlerFunc fileerror "$DESTCONFIG_FILE"
	msgFunc green  "Paths read from file"
	cat ./"$DESTCONFIG_FILE" || exitHandlerFunc fileerror "$DESTCONFIG_FILE"
	msgFunc green "Done!"
	msgFunc anykey
	clear	
}

#FUNCTION HEADER
# NAME :         gdriveFunc
# DESCRIPTION:gdrive sync to google drive
# INPUTS:  configfile from readconfigFunc   
# PROCESS : syncs to google drive + provides information and search 
#NOTES :    needs gdrive and gnu-netcat installed 
function gdriveFunc
{
clear
msgFunc line
msgFunc green "gdrive, connect to google drive via the terminal" 
msgFunc norm "gdrivemenu : CLI wrapper for gdrive"
msgFunc line
gdrive version

while true; do # loop until exit
msgFunc blue "gdrive options"
local optionsGdArr=("List all syncable directories on drive" "Sync local directory to google drive: $gdriveSource1" \
"Sync local directory to google drive: $gdriveSource2" "Sync local directory to google drive: $gdriveSource3" \
 "Sync local directory to google drive: $gdriveSource4" "List content of syncable directory" \
 "Google drive metadata, quota usage" "List files" "Get file info" "gdrive version"  \
  "Quit")
	select  choiceGD in "${optionsGdArr[@]}"
	do
	case "$choiceGD" in
		"${optionsGdArr[0]}")#List all syncable directories on drive
			msgFunc green "gdrive List all syncable directories on drive"
			gdrive sync list
		;;
		"${optionsGdArr[1]}")#Sync upload to remote directory  path 1
			msgFunc green "gdrive sync with remote directory path 1:-"
			msgFunc norm "Source: $gdriveSource1"
			msgFunc norm "Destination: $gdriveDest1"
			msgFunc anykey
			gdrive sync upload --delete-extraneous "$gdriveSource1" "$gdriveDest1"
		;;
		"${optionsGdArr[2]}")#Sync upload to remote directory  path 2
			msgFunc green "gdrive sync with remote directory path 2:-"
			msgFunc norm "Source: $gdriveSource2"
			msgFunc norm "Destination: $gdriveDest2"
			msgFunc anykey
			gdrive sync upload --delete-extraneous "$gdriveSource2" "$gdriveDest2"
		;;
		"${optionsGdArr[3]}")#Sync upload to remote directory  path 3
			msgFunc green "gdrive sync with remote directory path 3:-"
			msgFunc norm "Source: $gdriveSource3"
			msgFunc norm "Destination: $gdriveDest3"
			msgFunc anykey
			gdrive sync upload --delete-extraneous "$gdriveSource3" "$gdriveDest3"
		;;
		"${optionsGdArr[4]}")#Sync upload to remote directory  path 4
			msgFunc green "gdrive sync with remote directory path 4:-"
			msgFunc norm "Source: $gdriveSource4"
			msgFunc norm "Destination: $gdriveDest4"
			msgFunc anykey
			gdrive sync upload --delete-extraneous "$gdriveSource4" "$gdriveDest4"
		;;
		"${optionsGdArr[5]}")#List content of syncable directory
			makeDirFunc "-SYNCINFO"
			msgFunc green "List content of syncable directory (output to file)"
			local fileIdVar=""
			msgFunc norm "Enter fileId:-"
			read -r  fileIdVar
			gdrive sync content "$fileIdVar" > Syncinfo
		;;
		"${optionsGdArr[6]}")#gdrive about
			msgFunc green "Google drive metadata, quota usage"
			gdrive about
		;;
		"${optionsGdArr[7]}")#gdrive list files
			
			local numVar=""
			local quyVar=""
			local orderVar=""
			
			msgFunc green "List files "
			msgFunc norm "Enter Max files to list, Just press enter for all:-"
			read -r  numVar
			msgFunc norm "Enter Query (see https://developers.google.com/drive/search-parameters)"
			msgFunc norm "Common Example: name contains 'foo' "
			msgFunc norm "Just press enter to to leave Query blank :-"
			read -r  quyVar
			msgFunc norm "Enter Order (see https://godoc.org/google.golang.org/api/drive/v3#FilesListCall.OrderBy)"
			msgFunc norm "Common Example: quotaBytesUsed desc "
			msgFunc norm "Just press enter to to leave order blank :-"
			read -r  orderVar
			msgFunc norm "Output to file? [y/n] :-"

			if msgFunc yesno
				then
					#yes > output to file
					makeDirFunc "-LISTINFO"
					gdrive list  -q "$quyVar" --order "$orderVar" -m "$numVar" > Listinfo
				else #no > output to screen 
					gdrive list  -q "$quyVar" --order "$orderVar" -m "$numVar" 
			fi
			;;
		"${optionsGdArr[8]}")# get file info
			msgFunc green "Get file info"
			msgFunc norm "Enter fileId:-"
			local fileIdVar2=""
			read -r  fileIdVar2
			gdrive info "$fileIdVar2"
		;;
		"${optionsGdArr[9]}")# about gdrive
			msgFunc green "Gdrive version"
			gdrive version
		;;
		*)return  ;;
	esac
	break 
	done
msgFunc green "Done!"
msgFunc anykey
clear
done
}

#==================MAIN CODE====================================
clear
readconfigFunc
gdriveFunc
exitHandlerFunc exitout
#====================== END ==============================
