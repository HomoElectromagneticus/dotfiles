#!/usr/bin/env bash
# This script will rotate a table of values. For example, it can turn this:
#    2024-01-01  10  Red
#    2024-02-01  6   Green
#    2024-03-10  17  Blue
#    2024-04-07  21  Green
#    2024-06-21  1   Yellow
#
# into this:
#    2024-01-01    2024-02-01    2024-03-10    2024-04-07    2024-06-21
#    10            6             17            21            1
#    Red           Green         Blue          Green         Yellow
#
# Usage
# ./rotate-table.sh your-filename.dat 'delimiter'
# where the delimiter could be a comma ',' or whitespace ' ' etc

number_output_columns=$(wc -l < $1)

# set the options for pr into an array so that the variables get expanded
# correctly. i know the "echo" here is stupid, but i don't know how to make it
# work otherwise
pr_options=( -$(echo $number_output_columns) -t -s$2)

tr -s "$2" '\n' < $1 | pr "${pr_options[@]}"
