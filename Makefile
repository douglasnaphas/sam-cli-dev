all : build push

build : build-image.sh
	./build-image.sh

push : push-image.sh
	./push-image.sh