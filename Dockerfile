FROM postgres

# Copy SQL scripts into the image
COPY sql_scripts/ /docker-entrypoint-initdb.d/

EXPOSE 5432
# Set environment variables
ENV POSTGRES_PASSWORD=mysecretpassword