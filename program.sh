#make folders
function makeDirectoys01to12(){
	for i in {01..12}
	do	
		if [ ! -e $HOME/fredData/${i} ]
			then
				echo "making sub-directory ${i} in $fredData directory"
			mkdir $HOME/fredData/${i}
		else
			echo "sub-directory ${i} exists"
		fi
	done
}

function checkForFolderAndMake(){
	#1.b Create fredData folder if it dones't exist
	if [ ! -d /$HOME/fredData ] 
	then
		echo "fredData directory created! :)"
		mkdir $HOME/getfredData
		makeDirectoys01to12
	else
		echo "$fredData directory exists"
	fi

}

#place file into folder
function placeFileIntoFolder(){
	todaysMonth=`date +%m`
	appendDate=`date +%u-%B-%d-%Y-%N`
	dateOfme="$appendDate"
	
	#now place the file
	fileToGet=$HOME/	
	changeFileName=$inputFile.$appendDate
		echo "Placing file $getfredFile into folder $getfredData/$todaysMonth"
		`mv $fileToGet $HOME/$getfredData/$todaysMonth/$changeFileName`
}

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
elif [[ "$inputFile" = "" ]]; then
        usage
fi 
     
}
main $@
