# a collection of useful one-liners for awk


# compute the average / mean of a column of data
#
# column where the data you want to take the mean of is (column one here)
#                    |
#                    |   the file with the data
# data separator     |        |
# (a comma here)     |        |
#       |            |        |
awk -F ', ' '{print $1}' <data_file> | awk '{x+=$0}END{print x/NR}'


# compute the median of a dataset (uses more than just awk ;-)
#
# column where the data you want to take the median of is (column one here)
#                    |
#                    |   the file with the data
# data separator     |        |
# (a comma here)     |        |
#       |            |        |
awk -F ', ' '{print $1}' <data_file> | sort -n | awk '{ a[i++]=$1; }END{ print a[int(i/2)];}'


# compute the sample standard deviation (biased) of a column of data
#
# column where the data you want to take the st dev of is (column one here)
#                    |
#                    |   the file with the data
# data separator     |        |
# (a comma here)     |        |
#       |            |        |
awk -F ', ' '{print $1}' <data_file> | awk '{sum+=$0;a[NR]=$0}END{for(i in a)y+=(a[i]-(sum/NR))^2;print sqrt(y/(NR-1))}'
