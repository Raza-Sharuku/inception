COMPOSE_FILE    := ./srcs/docker-compose.yml
MKDIR_CMD        := mkdir -p $(HOME)/data/sql $(HOME)/data/wordpress
RM_DATA_CMD        := sudo rm -rf $(HOME)/data
RM_PS_CMD        := docker rm -f $$(docker ps -qa)
RM_VOL_CMD        := docker volume rm -f $$(docker volume ls)
RM_IMAGE_CMD    := docker rmi -f $$(docker image ls -q)
START            := docker compose -f $(COMPOSE_FILE) start
STOP            := docker compose -f $(COMPOSE_FILE) stop
DOWN            := docker compose -f $(COMPOSE_FILE) down
UP                := docker compose -f $(COMPOSE_FILE) up --build -d

all:
    @$(MKDIR_CMD)
    @sudo sh tools/add.sh
    @$(UP)

dir_create:

restart:
    @$(STOP)
    @$(START)

down:
    @$(DOWN)

clean:
    -@$(RM_PS_CMD)
    -@$(RM_VOL_CMD)
    -@$(RM_IMAGE_CMD)
    -@$(RM_DATA_CMD)
    -@sudo sh tools/delete.sh
    $(MAKE) down

re:
    make clean
    make all

.PHONY: all clean restart down re