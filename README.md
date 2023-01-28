## tor-privoxy-rotating

`docker build . -t tor-privoxy-rotating`

`docker run -d -p 8118:8118 -p 9050:9050 -p 9051:9051 tor-privoxy-rotating:latest`

`curl --proxy 127.0.0.1:8118 https://check.torproject.org`

`curl --silent -x http://localhost:8118/ https://check.torproject.org/ | grep -o "<p>.</p>" | sed 's/<[^>]>//g'`
