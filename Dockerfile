FROM haskell:8.8.1


EXPOSE 5000

COPY . /opt/tg-meetups

WORKDIR /opt/tg-meetups

RUN stack build

CMD ["stack", "run"]