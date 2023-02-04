ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

helm:
	helm package -d ${ROOT_DIR}/bin/ ${ROOT_DIR}/helm