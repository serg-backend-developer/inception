all:
	mkdir -p ${HOME}/data/mariadb/
	mkdir -p ${HOME}/data/wordpress/
	docker-compose -f ./srcs/docker-compose.yml up --build -d

clean:
	docker-compose -f ./srcs/docker-compose.yml down

stop:
	docker-compose -f ./srcs/docker-compose.yml stop

fclean: clean
	sudo rm -rf ${HOME}/data/mariadb/*
	sudo rm -rf ${HOME}/data/wordpress/*
	docker system prune -a --volumes

re:	fclean all