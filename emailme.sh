function check_arg(){
while getopts s:a:i: opt; do
case $opt in
	 s) sedsrc="$OPTARG"
		echo "You gave a sed file :)! $OPTARG"
		;;
	 a) awksrc="$OPTARG"
		#step 3
		echo "You gave an awk file :)! $OPTARG"
		;;
	 i) inputFile="$OPTARG"
		echo "You have an input file :)! $OPTARG"
		echo "Here are the files: -s $sedsrc, -a $awksrc, -i $inputFile"
		echo "Getting file from server"
		#makes the folder and sub directories
		checkForFolderAndMake

		# steps 3 and 4. sedsrc output is piped into awksrc file then puts into the output.txt
		sed -f $sedsrc $inputFile | awk -f $awksrc > $HOME/output.txt
		cat output.txt
		;;
		
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