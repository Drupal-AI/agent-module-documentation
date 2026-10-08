# API — getting and using the DBAL connection

The whole module is three service definitions (`dbal.services.yml`) plus the
`DbalServiceProvider`. There is nothing to configure.

## Services

| Service id | Class / resolves to | Use |
|---|---|---|
| `dbal_connection_factory` | `Drupal\dbal\ConnectionFactory` | Factory; call `->get($target)` for any Drupal DB target. |
| `dbal_connection` | `Doctrine\DBAL\Connection` | The **default** connection (factory `get()` with no target). |
| `Doctrine\DBAL\Connection` (alias) | → `@dbal_connection` | Autowire the connection by type. |
| `Doctrine\Persistence\ConnectionRegistry` (alias, private) | `Drupal\dbal\DoctrineConnectionRegistry` | Only when `doctrine/persistence` is installed. |

## Get a connection

```php
// Default connection:
/** @var \Doctrine\DBAL\Connection $conn */
$conn = \Drupal::service('dbal_connection');

// A specific Drupal database target (as named in $databases), e.g. a replica:
$conn = \Drupal::service('dbal_connection_factory')->get('replica');
```

Prefer autowiring in your own services:

```php
public function __construct(private readonly \Doctrine\DBAL\Connection $dbal) {}
```

## Use the Doctrine DBAL API

```php
$conn->executeStatement('CREATE TABLE dbal_demo (id INT, label VARCHAR(64))');
$conn->executeStatement('INSERT INTO dbal_demo (id, label) VALUES (?, ?)', [1, 'hello']);
$label = $conn->executeQuery('SELECT label FROM dbal_demo WHERE id = ?', [1])->fetchOne();
$rows  = $conn->fetchAllAssociative('SELECT * FROM dbal_demo');

// Query builder:
$qb = $conn->createQueryBuilder();
$rows = $qb->select('id', 'label')->from('dbal_demo')
  ->where('id = :id')->setParameter('id', 1)
  ->executeQuery()->fetchAllAssociative();
```

(This project ships `doctrine/dbal` `^2.5 || ^3.0`; on DBAL 3 the result methods are
`fetchOne`/`fetchAssociative`/`fetchAllAssociative` and statements use `executeStatement`.)

## How the factory maps Drupal → Doctrine (`ConnectionFactory::get()`)

- Reads `Database::getAllConnectionInfo()` (falls back to `default` if the target is unknown).
- `driver` → `pdo_<driver>` (a namespaced driver class like
  `Drupal\mysql\Driver\Database\mysql` is reduced to its last segment, `mysql`).
- Passes `dbname`, `user`, `password`, and, when set, `host`, `port`, `unix_socket`, PDO
  `driverOptions`; runs any `init_commands`.
- For SQLite, attaches Drupal table prefixes as separate databases.
- Connections are cached per target and not serialized (`__sleep` keeps only `info`).
