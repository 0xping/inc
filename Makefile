all:
	docker compose -f ./srcs/docker-compose.yml up  --build

fclean:
	-docker stop $$(docker ps -a -q)
	-docker rm $$(docker ps -a -q)
	-docker rmi $$(docker images -a -q)
	-docker network rm $$(docker network ls -q) 2> /dev/null
	-docker volume rm $$(docker volume ls -q)
	-docker system prune -a y
	sudo rm -rf ~/data/wordpress/* ~/data/db/*

re : fclean all