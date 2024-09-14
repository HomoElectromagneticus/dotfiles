#!/usr/bin/env bash
# adds row numbers / an index to a data table. depending on your use case, you 
# may find it simpler to copy the one-liner and modify it yourself. note that
# this will also write to the header line if there is one. you'll probably want
# to edit this out later.
#
#   /------------------------- sets the character to add after the number
#   |      /------------------ sets what number to start the index on
#   |      |    /------------- bash shortcut for the filename passed to the 
#   |      |    |              script (your filename here)
#   |      |    |       /----- deletes characters specified (here a single 
#   |      |    |       |      space)
#   |      |    |       |
nl -s "," -v 0 $1 | tr -d " "
