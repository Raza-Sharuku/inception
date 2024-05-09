
# include ./srcs/.env

# COMPOSE_FILE := ./srcs/docker-compose.yml
# MKDIR_CMD := mkdir -p $(VOLUME_DB) $(VOLUME_WEB)
# RM_PS_CMD := docker rm -f $$(docker ps -qa)
# RM_VOL_CMD := docker volume rm -f $$(docker volume ls -q)
# RM_IMAGE_CMD := docker rmi -f $$(docker images -q)
# RM_DATA_CMD := rm -rf $(VOLUME_DB) $(VOLUME_WEB)

# all: dir_create up

# dir_create:
# 	@$(MKDIR_CMD)

# up:
# 	@docker-compose -f $(COMPOSE_FILE) up --build

# down:
# 	@docker-compose -f $(COMPOSE_FILE) down

# clean: down
# 	-@$(RM_PS_CMD)
# 	-@$(RM_VOL_CMD)
# 	-@$(RM_IMAGE_CMD)

# fclean: clean
# 	-@$(RM_DATA_CMD)

# re: fclean all

# .PHONY: all dir_create up down clean fclean re

include ./srcs/.env

COMPOSE_FILE := ./srcs/docker-compose.yml
MKDIR_CMD := mkdir -p $(VOLUME_DB) $(VOLUME_WEB)
RM_PS_CMD := sudo docker rm -f $$(docker ps -aq 2>/dev/null) || true
RM_VOL_CMD := sudo docker volume rm -f $$(docker volume ls -q 2>/dev/null) || true
RM_IMAGE_CMD := sudo docker rmi -f $$(docker images -q 2>/dev/null) || true
RM_DATA_CMD := sudo rm -rf $(VOLUME_DB) $(VOLUME_WEB)

all: dir_create up

dir_create:
	@$(MKDIR_CMD)

up:
	sudo docker-compose -f $(COMPOSE_FILE) up --build

down:
	sudo docker-compose -f $(COMPOSE_FILE) down

clean: down
	$(RM_PS_CMD)
	$(RM_VOL_CMD)
	$(RM_IMAGE_CMD)

fclean: clean
	$(RM_DATA_CMD)

re: fclean all

.PHONY: all dir_create up down clean fclean re