BEGIN {FS=","}
NR==27, NR==45 { printf "%-30s %-15s %0s\n", $2, "from " $4, "to " $5 }
END { printf "END \n"}