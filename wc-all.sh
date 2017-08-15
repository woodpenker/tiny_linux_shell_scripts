#!/bin/bash
############
# Usage:
#" ./wc-all.sh -l1 /home"
#" ./wc-all.sh -l2 /home"
############
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
            name=$(file "$i"| grep "ELF")
            if [ "$name" = "" ];then
               wc $i
              lcount=$(($lcount + $(wc -l $i |cut -d ' ' -f1)))
              wcount=$(($wcount + $(wc -w $i |cut -d ' ' -f1)))
              ccount=$(($ccount + $(wc -c $i |cut -d ' ' -f1)))
              mcount=$(($mcount + $(wc -m $i |cut -d ' ' -f1)))
              fi
        fi
    done
}


function loop2()
{
   files=$(find $1)
   for i in $files; do
    if [ ! -d $i ];then
      name=$(file "$i"| grep "ELF")
      if [ "$name" = "" ];then
       wc $i
       lcount=$(($lcount + $(wc -l $i |cut -d ' ' -f1)))
        wcount=$(($wcount + $(wc -w $i |cut -d ' ' -f1)))
        ccount=$(($ccount + $(wc -c $i |cut -d ' ' -f1)))
        mcount=$(($mcount + $(wc -m $i |cut -d ' ' -f1)))
      fi
   fi
   done
}
if [ "$1" = "-l1" ];then
    shift
    nowpwd=$(pwd)
    cd $1
    loop1
    echo -e "Total: l:$lcount w:$wcount c:$ccount m:$mcount"
    cd $nowpwd
    unset nowpwd
elif [ "$1" = "-l2" ];then
      shift
     loop2 $1
      echo -e "Total: l:$lcount w:$wcount c:$ccount m:$mcount"
else
    echo -e "Usage: \n\" ./wc-all.sh -l1 /home\"\n\" ./wc-all.sh -l2 /home\" "
fi
