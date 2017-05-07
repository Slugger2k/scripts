#!/bin/bash

trap catch_errors ERR;

wavpath=/mnt/record


#########################################
## functions
#########################################

function wav2mp3() {
  wav=$1
  mp3=$(echo $1 | sed -e 's/wav/mp3/g')
  [ -x $wavpath/$mp3 ] && mp3="__$mp3"
  lame --preset insane -V0 $wavpath/$wav $wavpath/$mp3 && rm -rf $wavpath/$wav
}

function catch_errors() {
   echo "script aborted, because of errors $1. exiting...";
   exit 1;
}


########################################
### MAIN
########################################

#find wav files
for i in $(cd $wavpath && ls *.wav); do
  wav2mp3 $i 
done


exit 0
