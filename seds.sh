#step 3
sed -i -e 's/\//./g' presidents.csv


#steop 4. 
awk -F"," 'NR==27, NR==45 { printf "%-30s %-15s %0s\n", $2, "from " $4, "to " $5  }' presidents.csv
echo "presidents----"


