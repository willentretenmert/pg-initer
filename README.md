# pg-initer

pg-initer is my own makefile script to make local postgres dumps from remote db containers which i'd like to share with my associates
## Usage

```bash
# makes a dump in ./backup_dump file
make dump

# ups a local container
make restore
```
## Parameters
```bash
# not really required to be changed but oh well
DUMP_FILE_PATH=./backup.dump

# must be a non-existing container name
POSTGRES_CONTAINER=

# these params are shared to establish remote db connection and upping a new db
DB_USER=postgres
DB_PASSWORD=postgres
DB_NAME=
DB_HOST=
DB_PORT=
```