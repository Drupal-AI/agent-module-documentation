DBAL Connection is a developer bridge that hands you a ready-configured Doctrine DBAL (`Doctrine\DBAL\Connection`) built from Drupal's existing `$databases` settings, so code that expects a Doctrine connection can talk to the Drupal database with no extra configuration.

---

The module exposes three services and no UI, config, permissions, plugins, or Drush. `ConnectionFactory` (service `dbal_connection_factory`) reads `Database::getAllConnectionInfo()` in its constructor and, via `get($target = 'default')`, translates a Drupal connection's info array into Doctrine `DriverManager` options — mapping the driver to `pdo_<driver>` (stripping any namespaced driver class), and passing `dbname`, `user`, `password`, and, when present, `host`, `port`, `unix_socket`, PDO `driverOptions`, and running any `init_commands`; for SQLite it attaches Drupal prefixes as databases. Connections are cached per target (and the cache is not serialized). The service `dbal_connection` is the default `Doctrine\DBAL\Connection` (the factory's `get()` with no target), and `Doctrine\DBAL\Connection` is registered as an alias to it so the connection can be autowired by type. When the optional `doctrine/persistence` library is installed, `DbalServiceProvider` also registers a private `Doctrine\Persistence\ConnectionRegistry` (a `DoctrineConnectionRegistry` wrapping the default connection), reachable via the `ConnectionRegistry::class` service alias. You then use the standard Doctrine DBAL API (query builder, `executeQuery`, `executeStatement`, schema manager, transactions) against the same database Drupal uses.

---

- Run raw or query-builder SQL through Doctrine DBAL against the Drupal database.
- Reuse Doctrine-based libraries or code inside a Drupal module without a second DB config.
- Get a `Doctrine\DBAL\Connection` by autowiring the `Doctrine\DBAL\Connection` type into a service.
- Use Doctrine's DBAL query builder for complex cross-table queries.
- Connect Doctrine DBAL to a non-default Drupal database target via `ConnectionFactory::get($target)`.
- Provide a Doctrine `ConnectionRegistry` to tooling that expects one (with doctrine/persistence).
- Use Doctrine's schema manager to introspect the Drupal database schema.
- Run parameterized statements with `executeStatement()` / `executeQuery()` and DBAL binding.
- Wrap operations in DBAL transactions (`beginTransaction`, `commit`, `rollBack`).
- Port code from a standalone Doctrine app into Drupal while keeping the DBAL API.
- Access the same MySQL/MariaDB/PostgreSQL/SQLite connection Drupal is configured for.
- Execute vendor-specific SQL not easily expressed via Drupal's Database API.
- Fetch scalar/associative results with DBAL's `fetchOne`/`fetchAssociative`/`fetchAllAssociative`.
- Build a Doctrine DBAL-backed repository/service layer inside a Drupal project.
- Attach SQLite prefix databases automatically when running on SQLite.
- Honor Drupal connection `init_commands` when opening the DBAL connection.
- Bridge to Doctrine migrations or DBAL-based schema tooling.
- Query a replica/secondary database target through Doctrine by naming the target.
- Keep credentials in `settings.php` only, with DBAL deriving them at runtime.
- Prototype Doctrine DBAL code quickly against a live Drupal database.
