#step 1
#!/bin/bash

filepath="/home/hvalle/submit/cs3030/files/presidents.csv"
directory="fredData/"

# Get date

DATE=$(date "+%Y-%m-%d")
copydate=".${DATE}"

mm=$(echo ${DATE} | cut -d'-' -f2)

# Get filename

filename=$(basename $filepath)
datedfilename="${filename}.${DATE}"

# Check for folder structure or make folder structure

check_make_folder_structure()
{
	(cd ~/fredData/ || mkdir ~/fredData/)2>/dev/null
	(cd ~/fredData/01 || mkdir ~/fredData/01)2>/dev/null
	(cd ~/fredData/02 || mkdir ~/fredData/02)2>/dev/null
	(cd ~/fredData/03 || mkdir ~/fredData/03)2>/dev/null
	(cd ~/fredData/04 || mkdir ~/fredData/04)2>/dev/null
	(cd ~/fredData/05 || mkdir ~/fredData/05)2>/dev/null
	(cd ~/fredData/06 || mkdir ~/fredData/06)2>/dev/null
	(cd ~/fredData/07 || mkdir ~/fredData/07)2>/dev/null
	(cd ~/fredData/08 || mkdir ~/fredData/08)2>/dev/null
	(cd ~/fredData/09 || mkdir ~/fredData/09)2>/dev/null
	(cd ~/fredData/10 || mkdir ~/fredData/10)2>/dev/null
	(cd ~/fredData/11 || mkdir ~/fredData/11)2>/dev/null
	(cd ~/fredData/12 || mkdir ~/fredData/12)2>/dev/null
}

check_make_folder_structure

#step 2
cd ${directory}${mm}

if [[ -f "${filename}" ]]; then
	cd ~
	scp kc98571@icarus:${filepath} ${directory}${mm}/${datedfilename}
else
	cd ~
	scp kc98571@icarus:${filepath} ${directory}${mm}

#step 3
sed -i -e 's/\//./g' presidents.csv


#steop 4. 
awk -F"," 'NR==27, NR==45 { printf "%-30s %-15s %0s\n", $2, "from " $4, "to " $5  }' presidents.csv
echo "presidents----"
#----------------------------------------
#step 5 (getops)

function helpp(){
          echo "Usage: ./$(basename "$0") -s sedsrc -a awksrc -i inputFile"
}
function main(){
if [[ "$@" == "--help" ]]; then
	helpp
else
	check_arg $@
fi
}
function usage(){
	echo "Missing arguments"
	echo "Usage: ./$(basename "$0") -s sedsrc -a awksrc -i inputFile"
}
#----------------------------------------
function check_arg(){
while getopts s:a:i: opt; do
case $opt in
	 s) sedsrc="$OPTARG";;
	 a) awksrc="$OPTARG";;
	 i) inputFile="$OPTARG";;
	\?) echo "Invalid argument"
	    echo "Usage: ./$(basename "$0") -s sedsrc -a awksrc -i inputFile"
            exit 1;;
	    esac
done
shift $((OPTIND-1))
if [[ "$sedsrc" = "" ]]; then
        usage
elif [[ "$awksrc" = "" ]]; then
        usage
elif [[ "$inputFile" = "" ]]; then
        usage
fi      
}
main $@
