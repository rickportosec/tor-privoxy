## tor-privoxy-rotating

## Project is in progress

`docker build . -t tor-privoxy-rotating`

`docker run -d -p 8118:8118 -p 9050:9050 -p 9051:9051 tor-privoxy-rotating:latest`

`docker ps`

`docker exec -it [name] /bin/sh`

`cd /etc/service`

`sh setup --address 0.0.0.0 ---passwd [password]`

`curl --silent -x http://172.17.0.1:8118 https://check.torproject.org/`

`curl --silent -x http://172.17.0.1:8118 https://check.torproject.org/ | grep '<strong>.*</strong>' `
