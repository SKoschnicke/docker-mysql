# Container with MySQL

The `Dockerfile` creates a container with MySQL-Server installed.

* access is allowed from any host for the `mysql` user.
* a password for the MySQL root user (which can only be used to connect from inside the container) is set (default `rootpw`, configurable in `Dockerfile`)
* a new MySQL user is created (default username `mysql`, configurable in `Dockerfile`)
* anonymous user and test databases are removed

Mount a directory from the host to `/var/lib/mysql` (or, if you changed the `DATADIR` in
`Dockerfile`, to the `DATADIR` path) to make the databases persistent:

```
docker run -v="$HOME/db":"/var/lib/mysql" -d -name mysql <image-id>

```

The directory is initialized by the `start`-script on every run if no database is already present.

Note that you can only connect with the `mysql` user from outside the container,
not with the `root` user.
