include ./srcs/.env

COMPOSE_FILE := ./srcs/docker-compose.yml
MKDIR_CMD := sudo mkdir -p $(VOLUME_DB) $(VOLUME_WEB)
RM_PS_CMD := sudo docker rm -f $$(docker ps -aq 2>/dev/null) || true
RM_VOL_CMD := sudo docker volume rm -f $$(docker volume ls -q 2>/dev/null) || true
RM_IMAGE_CMD := sudo docker rmi -f $$(docker images -q 2>/dev/null) || true
RM_DATA_CMD := sudo rm -rf $(VOLUME_DB) $(VOLUME_WEB)

all: dir_create up

dir_create:
	@$(MKDIR_CMD)

up:
	sudo docker-compose -f $(COMPOSE_FILE) up --build -d

down:
	sudo docker-compose -f $(COMPOSE_FILE) down

clean: down
	sudo $(RM_PS_CMD)
	sudo $(RM_VOL_CMD)
	sudo $(RM_IMAGE_CMD)

fclean: clean
	sudo $(RM_DATA_CMD)

re: fclean all

.PHONY: all dir_create up down clean fclean re