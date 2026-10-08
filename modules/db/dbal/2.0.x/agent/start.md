# DBAL Connection — agent index

Gives you a Doctrine DBAL `Doctrine\DBAL\Connection` built from Drupal's `$databases` settings.
Pure developer bridge: **no** config, UI, permissions, plugins, Drush, or schema — just services.

- **The services, getting a connection, non-default targets, ConnectionRegistry** →
  [api/connection.md](api/connection.md)

Key facts:
- `dbal_connection_factory` → `Drupal\dbal\ConnectionFactory`; `->get($target = 'default')` returns
  a `Doctrine\DBAL\Connection` (cached per target).
- `dbal_connection` → the default `Doctrine\DBAL\Connection`.
- `Doctrine\DBAL\Connection` (service alias) → `@dbal_connection`, so the connection is autowireable
  by type.
- With `doctrine/persistence` installed, `ConnectionRegistry::class` resolves to a private
  `Doctrine\Persistence\ConnectionRegistry` wrapping the default connection.
- Connection options are derived from `Database::getAllConnectionInfo()`; driver becomes
  `pdo_<driver>`.
