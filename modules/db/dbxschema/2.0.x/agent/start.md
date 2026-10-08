<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Database Cross-Schema Queries (dbxschema) — agent index

A developer **API/framework** (package *Cross-Schema*) that extends Drupal's database layer so one
SQL query can span several **PostgreSQL schemas** — or, with MySQL, several **databases** on one
server — all through a single Drupal connection. **No routes, no permissions, no forms, no admin UI,
no Drush.** Core `^10 || ^11`. License GPL-2.0-or-later. Version 2.0.0 (beta).

The base module is **database-agnostic and inert alone** — you must also enable at least one driver
submodule. `hook_requirements()` (`dbxschema.install`) raises a runtime **error** if no `CrossSchema`
plugin is enabled, and `hook_modules_installed()` warns on install.

## Solution docs

- **The cross-schema Connection: getting one, the `{n:table}` token syntax, extra schemas, `useCrossSchemaFor`** → [api/connection.md](api/connection.md)
- **DatabaseTool service: schema create/clone/rename/drop/size, name validation, the reservation registry** → [api/database-tool.md](api/database-tool.md)
- **The `CrossSchema` plugin type — writing a driver for another RDBMS** → [plugins/cross-schema-driver.md](plugins/cross-schema-driver.md)
- **Config object `dbxschema.settings` (reserved patterns, test schema names)** → [config/settings.md](config/settings.md)
- **Driver submodules** (own doc trees): [dbxschema_pgsql](../../../../db/dbxschema/modules/dbxschema_pgsql/2.0.x/agent/start.md) · [dbxschema_mysql](../../../../db/dbxschema/modules/dbxschema_mysql/2.0.x/agent/start.md)

## What it actually is (from source)

- **Plugin type `CrossSchema`** — manager `Drupal\dbxschema\CrossSchemaPluginManager` (service
  `plugin.manager.dbxschema`), annotation `Drupal\dbxschema\Annotation\CrossSchema`
  (`id`, `driver`, `description`), interface `Plugin\CrossSchemaInterface`, base `Plugin\CrossSchemaBase`.
  Plugins live in `src/Plugin/CrossSchema/`. Each plugin's `getClass()` maps the categories
  `DatabaseTool` / `Connection` / `Schema` to concrete per-driver classes. Alter hook: `dbxschema_info`.
- **Services** (`dbxschema.services.yml`): `dbxschema.tool` (factory `DatabaseTool::getDatabaseTool`),
  `dbxschema.tool.factory` (`Database\DatabaseToolFactory`), `dbxschema.database`
  (factory `DatabaseTool::getConnection`), `dbxschema.logger` (channel `dbxschema`).
- **Abstract `Database\DatabaseTool`** — driver-agnostic entry point. Statics `getConnection()`,
  `getDatabaseTool()`, `getDriverImplementation()`; schema lifecycle (`createSchema`, `cloneSchema`,
  `renameSchema`, `dropSchema`, `schemaExists`, `getSchemaSize`, `getDatabaseSize`); validation
  (`isInvalidSchemaName`, `SCHEMA_NAME_REGEXP`, `TABLE_NAME_REGEXP`); reservation registry
  (`reserveSchemaPattern`/`isSchemaReserved`/`freeSchemaPattern`, seeded from `dbxschema.settings`);
  `parseTableDdl()`.
- **`Database\CrossSchemaConnectionInterface`** (+ `CrossSchemaConnectionTrait`) — extends Drupal's
  `Connection`; adds `setSchemaName`/`getSchemaName`, `addExtraSchema`/`setExtraSchema`/`getExtraSchemas`,
  `useCrossSchemaFor`/`useDrupalSchemaFor`, and overrides `prefixTables()` to honor `{n:table}` tokens.
- **`Database\CrossSchemaSchemaInterface`** (+ `CrossSchemaSchemaTrait`) — extends Drupal's `Schema`;
  adds `schemaExists`/`createSchema`/`cloneSchema`/`renameSchema`/`dropSchema`/`getSchemaDef`/`findTables`.
- **`ProprietarySchemaInterface`/`ProprietarySchemaTrait`** — load static schema definitions from YAML
  files (`source => 'file'`) for non-Drupal third-party layouts.
- **Exceptions** (`src/Exception/`): `DatabaseToolException`, `ConnectionException`, `SchemaException`,
  `CrossSchemaException`.
- **Config**: `config/install/dbxschema.settings.yml` + schema `config/schema/dbxschema.schema.yml`
  (`reserved_schema_patterns`, `test_schema_base_names`). No `config_form`/settings route.

## Dependencies & install notes

- Requires **no** contrib modules. Enable `dbxschema` **plus** `dbxschema_pgsql` and/or `dbxschema_mysql`.
- **Not compatible with per-table prefixing** — `hook_requirements()` warns if `settings.php` uses an
  array `prefix` with more than one entry or an `extra_prefix`. Set `prefix` to a plain string.
- Cross-query only works across schemas/databases reachable through **one** connection
  (same host+port+credentials).
