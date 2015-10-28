#!/bin/bash

if [ -x "$(command -v pamixer)" ]
then

    muted=''
    if pamixer --get-mute > /dev/null
    then 
        muted="(Muted)"
    fi
    volume="$(pamixer --get-volume)"
    v="${volume} $muted"
    
elif [ -x "$(command -v amixer)" ]
then
    str=`amixer sget Master,0`
    str1=${str#Simple*\[}
    v1=${str1%%]*]}
    il=`expr index "$str1" [`
    o="off"
    mutel=''
    if [ ${str1:$il:3} == $o ]; then mutel='M'; fi
    s=${str1:0:1}
    str2=${str1#${str1:0:1}*\[}
    str1=$str2
    str2=${str1#${str1:0:1}*\[}
    ir=`expr index "$str2" [`
    muter=''
    if [ $(echo $str2 | tr -d '[=\]=]') = $o ] ; then muter='M'; fi
    v2=$(echo $str2 | tr -d '[=\]=]')
    v=${v1}\ $mutel\ ${v2}\ $muter
else
    v="Can't get the volume level!"
fi

echo $v
