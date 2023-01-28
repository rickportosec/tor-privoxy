# vim:set ft=dockerfile:
FROM alpine:latest

EXPOSE 8118 9050 9051

RUN apk --update add privoxy tor runit tini py3-pip
RUN pip install stem
RUN rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

COPY service /etc/service/

RUN chmod +x /etc/service/privoxy/run
RUN chmod +x /etc/service/tor/run
RUN chmod +x /etc/service/setup
RUN chmod +x /etc/service/newnym.py

ENTRYPOINT ["tini", "--"]
CMD ["runsvdir", "/etc/service"]
