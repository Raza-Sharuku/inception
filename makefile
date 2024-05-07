include ./srcs/.env
COMPOSE_FILE    := ./srcs/docker-compose.yml
MKDIR_CMD        := mkdir -p $(HOME)/sraza/data/db $(HOME)/sraza/data/wordpress
RM_DATA_CMD        := sudo rm -rf $(HOME)/sraza/data
RM_PS_CMD        := docker rm -f $$(docker ps -qa)
RM_VOL_CMD        := docker volume rm -f $$(docker volume ls)
RM_IMAGE_CMD    := docker rmi -f $$(docker image ls -q)
DOWN            := docker compose -f $(COMPOSE_FILE) down
UP                := docker compose -f $(COMPOSE_FILE) up --build -d

all:
    @$(MKDIR_CMD)
    @$(UP)

dir_create:

down:
    @$(DOWN)

clean:
    -@$(RM_PS_CMD)
    -@$(RM_VOL_CMD)
    -@$(RM_IMAGE_CMD)
    -@$(RM_DATA_CMD)
    $(MAKE) down

re:
    make clean
    make all

.PHONY: all clean down re