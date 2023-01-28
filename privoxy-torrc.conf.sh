#!/bin/bash
while [[ $# -gt 0 ]] do
   key="$1"

   case $key in

      --address)
         addr="$2"
         portion="${addr%..}"

         sed -i '{
            385 s/^/# /
            386 s/^/# /
            387 s/^/# /
            794 s/./listen-address '"${addr}"':8118/
            1089 s#.# permit-access '"${portion}"'.0.0/16 #
            1456 s#.# forward-socks5t / '"${addr}"':9050 .#
            1467 s#.# forward '"${portion}"'../ .#

         }' config

         sed -i '{
            18 s/./SocksPort '"${addr}"':9050/
            56 s/#//
            26 s/#//
            48 s/#//
            60 s/#//
            178 s/#//
         }' torrc

         shift
         ;;

   --passwd)
      passwd="$2"
      hash=$(tor --hash-password "$passwd")
      sed -i '59 s/#HashedControlPassword .*/HashedControlPassword '"${hash}"'/' torrc
      sed -i '6 s/password=.*/password='"${passwd}"')/' newnym-rotacion.py
      shift
      ;;
   esac

   shift
done

if [[ -z "$addr" ]] && [[ -z "$passwd" ]]; then
   echo "How to use:'"
fi
