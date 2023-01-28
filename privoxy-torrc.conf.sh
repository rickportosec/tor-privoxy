#!/bin/bash
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
--address)
addr="$2"
portion="${addr%..}"
sed -i '385 s/^/# /' /etc/privoxy/config
sed -i '386 s/^/# /' /etc/privoxy/config
sed -i '387 s/^/# /' /etc/privoxy/config
sed -i '794 s/./listen-address '"${addr}"':8118/' /etc/privoxy/config
sed -i '1089 s#.# permit-access '"${portion}"'.0.0/16 #' /etc/privoxy/config
sed -i '1456 s#.# forward-socks5t / '"${addr}"':9050 .#' /etc/privoxy/config
sed -i '1467 s#.# forward '"${portion}"'../ .#' /etc/privoxy/config
sed -i '18 s/./SocksPort '"${addr}"':9050/' /etc/tor/torrc
sed -i '56 s/#//' /etc/tor/torrc
sed -i '26 s/#//' /etc/tor/torrc
sed -i '48 s/#//' /etc/tor/torrc
sed -i '60 s/#//' /etc/tor/torrc
sed -i '178 s/#//' /etc/tor/torrc
shift
;;
--passwd)
passwd="$2"
hash=$(tor --hash-password "$passwd")
sed -i '59 s/#HashedControlPassword .*/HashedControlPassword '"${hash}"'/' /etc/tor/torrc
sed -i '6 s/password=.*/password='"${passwd}"')/' newnym-rotacion.py
shift
;;
esac
shift
done
if [[ -z "$addr" ]] && [[ -z "$passwd" ]]; then
echo "How to use:'"
fi