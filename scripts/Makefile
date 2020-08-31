ifeq ($(OS),Windows_NT)
	# this is windows
	SYS_OS = windows
	SYS_OS_TRUNC = win

	# get SYS_ARCH
	ifeq ($(PROCESSOR_ARCHITEW6432),AMD64)
		SYS_ARCH = amd64
	else
		ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
			SYS_ARCH = amd64
		endif
		ifeq ($(PROCESSOR_ARCHITECTURE),x86)
				SYS_ARCH = 386
		endif
	endif
else
	# get SYS_OS
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		SYS_OS = linux
		SYS_OS_TRUNC = linux
	endif
	ifeq ($(UNAME_S),Darwin)
		SYS_OS = darwin
		SYS_OS_TRUNC = osx
	endif

	# get SYS_ARCH
	UNAME_P := $(shell uname -p)
	ifeq ($(UNAME_P),x86_64)
		SYS_ARCH = amd64
	endif
	ifneq ($(filter %86,$(UNAME_P)),)
		SYS_ARCH = 386
	endif
	ifneq ($(filter arm%,$(UNAME_P)),)
		SYS_ARCH = arm
	endif
endif

define HELP_OUTPUT

# WORK-IN-PROGRESS (basically, the default message was not changed)

endef
export HELP_OUTPUT

# print the help message
help_scripts:
	@printf -- "$${HELP_OUTPUT}"

sys_info:
	@printf -- "SYS_OS       : '$(SYS_OS)'\n"
	@printf -- "SYS_OS_TRUNC : '$(SYS_OS_TRUNC)'\n"
	@printf -- "SYS_ARCH     : '$(SYS_ARCH)'\n"
	@printf -- "BIN_EXT      : '$(BIN_EXT)'\n"

ssl:
	@mkdir -p $(PATH_TO_KEYS)
	@openssl genrsa -out $(PATH_TO_KEYS)/server.key 2048
	@mkdir -p $(PATH_TO_CERTS)
	@openssl req -new -x509 -sha256 \
		-days 3650 \
		-key $(PATH_TO_KEYS)/server.key \
		-out $(PATH_TO_CERTS)/server.crt \
		-subj "/C=SG/ST=Singapore/L=Singapore/O=Sia/CN=localhost"

check_prereq_docker:
	@printf -- 'checking for docker...\n'
	@which docker \
		&& ls -al "$$(which docker)" \
		&& docker version --format 'client/api:{{.Client.Version}}/{{.Server.Version}}'
	@printf -- 'docker found!\n'

check_prereq_docker_compose:
	@printf -- 'checking for docker-compose...\n'
	@which docker-compose \
		&& ls -al "$$(which docker-compose)" \
		&& docker-compose version
	@printf -- 'docker-compose found!\n'

check_prereq_go:
	@printf -- 'checking for go...\n'
	@which go \
		&& ls -al "$$(which go)" \
		&& go version
	@printf -- 'go found!\n'

check_prereq_kubectl:
	@printf -- 'checking for kubectl client...\n'
	@which kubectl \
		&& ls -al "$$(which kubectl)" \
		&& kubectl version --short --client
	@printf -- 'kubectl client found!\n'