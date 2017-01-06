APP = homeonrails

default: build

build:
	docker build -t $(APP) .

console:
	docker run -it --rm -v "$PWD":/go/src/app -p "1313:1313" $(APP) /bin/bash

run:
	docker run -it --rm -v "$PWD":/go/src/app -p "1313:1313" $(APP)
