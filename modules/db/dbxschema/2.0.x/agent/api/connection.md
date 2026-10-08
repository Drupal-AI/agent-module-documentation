<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The cross-schema Connection & the `{n:table}` token syntax

Source: `src/Database/CrossSchemaConnectionInterface.php`, `src/Database/CrossSchemaConnectionTrait.php`,
`src/Database/DatabaseTool.php` (statics), plus the per-driver `Connection` classes under
`modules/dbxschema_{pgsql,mysql}/src/Database/Connection.php`.

## Getting a connection

```php
use Drupal\dbxschema\Database\DatabaseTool;

// A cross-schema connection whose "current schema" is 'myschema'.
$xconn = DatabaseTool::getConnection('myschema');
```

`DatabaseTool::getConnection(string $schema_name = '', $database = 'default', ?string $driver_name = NULL)`:
- `$schema_name` — the connection's *current* schema (token index `1`). Empty is allowed, but methods
  needing a default schema then throw.
- `$database` — a Drupal database **key** string (from `settings.php`) *or* a `\Drupal\Core\Database\Connection`.
  Used only to obtain credentials; defaults to the `default` key. Database **targets are not supported**.
- `$driver_name` — force a specific driver; otherwise inferred from the resolved connection's `driver`
  option, and the matching `CrossSchema` plugin is loaded (`getDriverImplementation()`).

The returned object is a subclass of Drupal's `\Drupal\Core\Database\Connection` (per driver, e.g.
`Drupal\dbxschema_pgsql\Database\Connection`) implementing `CrossSchemaConnectionInterface` — use
`->query()`, `->select()`, `->insert()`, transactions, etc. exactly as usual.

The service alias `dbxschema.database` and `dbxschema.tool` (factory-built `DatabaseTool`) are also
available, but `DatabaseTool::getConnection()` is the documented entry point (README example).

## The table token syntax

Beyond Drupal's `{table}` curly-brace tokens, a **numeric schema index prefix** selects the schema:

| Token        | Resolves to |
|--------------|-------------|
| `{table}`    | By default forced to `{1:table}` — the connection's current schema (see `prefixTables()` override). |
| `{0:table}`  | Drupal's own schema (the site's normal tables, e.g. `node`). |
| `{1:table}`  | The connection's current schema (set by `getConnection($schema_name)` / `setSchemaName()`). |
| `{2:table}`, `{3:table}`… | Extra schemas, in the order added (index `2` is the first extra). |

Example (from README):

```php
$xconn = DatabaseTool::getConnection('myfirstschema');
$xconn->addExtraSchema('myotherschema');            // becomes index 2
$result = $xconn->query('
  SELECT *
  FROM {0:node} n
    JOIN {1:sometable} t1 ON t1.node_identifier = n.nid
    LEFT JOIN {2:othertable} t2 ON t2.node_identifier = n.nid
  WHERE t1.title LIKE :title;',
  [':title' => 'Something%']
);
```

Parameter binding (`:placeholder`) is unchanged — bind **values**, not identifiers.

## Managing schemas on a connection

- `setSchemaName(string $schema_name)` / `getSchemaName()` — set/read the current (index-1) schema;
  resets extra schemas; throws `ConnectionException` on an invalid name (empty allowed).
- `addExtraSchema(string $schema_name): int` — append an extra schema; returns its index (≥ 2).
  Throws if the name is invalid or the schema doesn't exist or there is no current schema.
- `setExtraSchema(string $schema_name, int $index = 2)` — pin an extra schema to a chosen index.
- `getExtraSchemas(): array` — ordered list (indices start at 2).
- `clearExtraSchemas()`.
- `schema()` — returns a `CrossSchemaSchemaInterface` object (see [database-tool.md](database-tool.md)).
- `getDatabaseName()` / `getDatabaseKey()` / `getDriver()` / `getDatabaseTool()`.

## `useCrossSchemaFor()` — making plain `{table}` follow the schema

A service that emits plain `{table}` tokens (e.g. an entity storage class) normally hits Drupal's
default schema. Register it so its bare tokens resolve against **this** connection's schema instead:

```php
$xconn->useCrossSchemaFor($someStorageObject);   // or a class name
// ... work that runs its queries ...
$xconn->useDrupalSchemaFor($someStorageObject);  // restore default behavior
```

`prefixTables()` is overridden so non-static queries (`select()` etc.) that would otherwise use
Drupal's default schema are transparently rewritten to `{1:...}`.

## Logging

Query logging (`setLogger`/`getLogger`) stays reserved for Drupal's `\Drupal\Core\Database\Log`.
For message logging use `setMessageLogger()`/`getMessageLogger()` (PSR `LoggerInterface`); by default
the constructor uses the `dbxschema.logger` channel.

## Notes

- Cross-querying requires all schemas/databases to be reachable through **one** connection
  (same host+port+credentials). An extra `settings.php` database *key* can be targeted for its own
  schemas, but you then cannot join it against Drupal's tables.
- Incompatible with per-table prefixing (see `hook_requirements()` in `dbxschema.install`).
