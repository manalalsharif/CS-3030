#step 3
sed -i -e 's/\//./g' presidents.csv


#steop 4. 
awk -F"," 'NR==27, NR==45 { printf "%-30s %-15s %0s\n", $2, "from " $4, "to " $5  }' presidents.csv
echo "presidents----"

#step 5

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
