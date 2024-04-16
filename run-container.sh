docker stop my_postgres
docker rm my_postgres

docker build -t my_postgres .
docker run -d -p 5432:5432 --network grio-network --name my_postgres my_postgres

