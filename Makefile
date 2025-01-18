DUMP_FILE_PATH=./backup.dump
POSTGRES_CONTAINER=z

DB_USER=postgres
DB_PASSWORD=postgres
DB_NAME=
DB_HOST=
DB_PORT=

init-db:
	@echo "Launching a Docker container and creating a database..."
	@docker run --name $(POSTGRES_CONTAINER) -p $(DB_PORT):5432 -e POSTGRES_USER=$(DB_USER) -e POSTGRES_PASSWORD=$(DB_PASSWORD) -e POSTGRES_DB=$(DB_NAME) -d postgres
	@echo "Waiting for database to be ready..."
	@sleep 10

wait-for-db:
	@echo "Waiting for PostgreSQL to start accepting connections..."
	@until docker exec $(POSTGRES_CONTAINER) pg_isready -U $(DB_USER); do \
		sleep 1; \
	done

restore-db: wait-for-db
	@echo "Restoring database from dump..."
	@docker exec -i $(POSTGRES_CONTAINER) pg_restore -U $(DB_USER) -d $(DB_NAME) --no-owner -1 < $(DUMP_FILE_PATH)

.PHONY: database restore-db
database: init-db
	@echo "Local database ready."

restore: database restore-db
	@echo "Database restoration complete."

dump:
	@echo "Creating database dump..."
	pg_dump -h $(DB_HOST) -p $(DB_PORT) -U $(DB_USER) -W -F custom -b -v -f "backup.dump" $(DB_NAME)
	@echo "Database dump created."
