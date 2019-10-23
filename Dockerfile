FROM haskell:8.6.5


EXPOSE 5000

COPY . /opt/tg-meetups

WORKDIR /opt/tg-meetups

RUN stack build

CMD ["stack", "run"]