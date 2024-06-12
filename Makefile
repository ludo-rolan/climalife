
#############################
# Dockers
#############################

up:
	SRCDIR=. DATADIR=.  HTTPPORT=80 RESTART=no docker-compose -p climalife up
	
killall:
	sudo docker kill $$(sudo docker ps -q)

start:
	docker-compose start

stop:
	docker-compose stop

status:
	docker-compose ps

docker-rebuild:
	docker-compose stop
	docker-compose pull
	docker-compose build --no-cache --pull
	docker-compose up -d --force-recreate

