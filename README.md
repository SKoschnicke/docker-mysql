# Container with MySQL

The `Dockerfile` creates a container with MySQL-Server installed.

* access is allowed from any host
* a password for the MySQL root user is set (default `rootpw`, configurable in `Dockerfile`)
* a new MySQL user is created (default username `mysql`, configurable in `Dockerfile`)
* anonymous user and test databases are removed

Mount a directory from the host to `/var/lib/mysql` (or, if you changed the `DATADIR` in
`Dockerfile`, to the `DATADIR` path) to make the databases persistent:

```
docker run -v="$HOME/db":"/var/lib/mysql" <container-id>
```

The directory is initialized by the `start`-script on every run if no database is already present.
