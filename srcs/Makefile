COMPOSE = docker compose

all: up

up:
	sudo mkdir -p /opt/cloud-1/data/wordpress
	sudo mkdir -p /opt/cloud-1/data/mariadb
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

re: down up

nginx:
	$(COMPOSE) restart nginx

wordpress:
	$(COMPOSE) restart wordpress

mariadb:
	$(COMPOSE) restart mariadb

phpmyadmin:
	$(COMPOSE) restart phpmyadmin

ps:
	$(COMPOSE) ps

logs:
	$(COMPOSE) logs -f

logs-nginx:
	$(COMPOSE) logs -f nginx

logs-wordpress:
	$(COMPOSE) logs -f wordpress

logs-mariadb:
	$(COMPOSE) logs -f mariadb

volumes:
	docker volume ls
	@echo "\n--- WordPress volume ---"
	docker volume inspect wordpress
	@echo "\n--- MariaDB volume ---"
	docker volume inspect mariadb

clean: down
	$(COMPOSE) down -v --remove-orphans

fclean: clean
	docker system prune -af --volumes
	sudo rm -rf /opt/cloud-1/data/wordpress
	sudo rm -rf /opt/cloud-1/data/mariadb

.PHONY: all up down re nginx wordpress mariadb phpmyadmin redis \
        ps logs logs-nginx logs-wordpress logs-mariadb volumes clean fclean
