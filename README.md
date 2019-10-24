# Tg Meetups App


## Hub image
```
https://hub.docker.com/r/zxc123zxc2/tg-meetups
```

## Parent image
```
https://hub.docker.com/_/haskell
```

## Run detached with open 80 port
```
docker run -d -p 80:5000 zxc123zxc2/tg-meetups
```

## Dev info:

Be aware about Haskell version consistency in *Dockerfile/FROM* and *stack.yaml/resolver*

### Libs required:
-  libpq-dev (brew install libpq)


### Local development commands
```
docker image build --tag local/tg-meetups:dev .
docker run --rm local/tg-meetups:dev

docker run --rm -i -t local/tg-meetups:dev sh  
```

### Haskell dependencies
```
https://www.stackage.org/nightly-2019-10-23
```