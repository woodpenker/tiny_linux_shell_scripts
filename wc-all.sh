#!/bin/bash
function loop1()
{
    for i in $(ls  .)
    do
        #echo -e "i:$i"
        if [ -d  $i ];then
            cd $i
            loop1 $i
            cd ..
        elif [ -f $i ];then
            wc $i
            lcount=$(($lcount + $(wc -l $i |cut -d ' ' -f1)))
            wcount=$(($wcount + $(wc -w $i |cut -d ' ' -f1)))
            ccount=$(($ccount + $(wc -c $i |cut -d ' ' -f1)))
            mcount=$(($mcount + $(wc -m $i |cut -d ' ' -f1)))

        fi
    done
}


function loop2()
{
   files=$(find $1)
   for i in $files; do
    if [ ! -d $i ];then
       wc $i
       lcount=$(($lcount + $(wc -l $i |cut -d ' ' -f1)))
        wcount=$(($wcount + $(wc -w $i |cut -d ' ' -f1)))
        ccount=$(($ccount + $(wc -c $i |cut -d ' ' -f1)))
        mcount=$(($mcount + $(wc -m $i |cut -d ' ' -f1)))
   fi
   done
}
if [ "$2" = "1" ];then
    nowpwd=$(pwd)
    cd $1
    loop1
    echo -e "Total: l:$lcount w:$wcount c:$ccount m:$mcount"
    cd $nowpwd
    unset nowpwd
else
     loop2 $1
      echo -e "Total: l:$lcount w:$wcount c:$ccount m:$mcount"
fi
