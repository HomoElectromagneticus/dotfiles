#! /usr/bin/env awk -f
# build a histogram dynamically from an input data set. all you need to provide
# is the data (where the value to be binned is in the first column) and the
# bin size

# usage:
# ./histogram.awk -v bin_size=<bin_size> <input-file>

# example usage:
# ./histogram.awk -v bin_size=100 mydata.tsv > histogram.tsv

{   
    # initialize the minimum bin value - for datasets with positive numbers,
    # this value will end up being null since null > 0 in awk
    if (NR==1)
        bin_min = $1

    # divide the value by the given bin size, and cast that as an integer. this
    # produces a value that's essentially which bin number the line belongs to,
    # from the first to last bin.
    bin = int($1 / bin_size)
    # we can then use this value to index into an array that is essentially
    # bin number -> counts
    bin_counts[bin]++

    # keep track of the maxes and mins
    if (bin > bin_max)
        bin_max = bin
    if (bin < bin_min)
        bin_min = bin
}

END {
    print "Upper limit is", (bin_max + 1)*bin_size, "Lower limit is", bin_min*bin_size
    print "Total number of bins =", int(bin_max - bin_min / bin_size), "where the bin size =", bin_size
    
    # print the histogram (bin low, bin high, number of counts in bin)
    for (i = bin_min; i <= bin_max; i++) {
        # for empty bins, awk will naturally print nothing instead of zero. we
        # have to override this
        if (bin_counts[i] == "")
            print i*bin_size, (i+1)*bin_size, 0
        else
            print i*bin_size, (i+1)*bin_size, bin_counts[i]
    }
}

