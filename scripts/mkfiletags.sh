#!/bin/sh

usage()
{
    echo "Usage: `basename $0` prjname"
    exit 1
}

if [ $# = 0 ]
then
    usage
fi

prjdir=./.$1
if [ ! -d $prjdir ]
then
    echo "create prjdir:$prjdir"
    mkdir -p $prjdir
fi

#cscope.files
echo "cscope.files..."
find . \( -path ./scripts -o -path $prjdir -o -path ./project -o -path ./driver/ssp/broadcom3 -o -path ./driver/ssp/marvell \) -prune -o -name "*.[ch]" -print | awk '!/\.mod\.c$/{print $0}' > $prjdir/cscope.files
#find ./ -name "*.h" -o -name "*.c" -o -name "*.cc" > $prjdir/cscope.files

#filetags for lookupfile
echo "lookupfile name tags..."
echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > $prjdir/filenametags

find . \( -path ./scripts -o -path $prjdir -o -path ./project -o -path ./driver/ssp/broadcom3 -o -path ./driver/ssp/marvell \) -prune -o -name "*.[ch]" -type f -printf "%f\t%p\t1\n" | sort -f >> $prjdir/filenametags 

exit 0
