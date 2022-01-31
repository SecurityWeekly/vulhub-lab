docker-compose -f docker-compose.yml down --rmi all --remove-orphans
docker-compose -f docker-compose.yml build --force-rm --no-cache --parallel
docker-compose -f docker-compose.yml up -d
