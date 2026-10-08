<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Database Cross-Schema Queries (dbxschema) — agent index

A developer **API/framework** (package *Cross-Schema*) that extends Drupal's database layer so one
SQL query can span several **PostgreSQL schemas** — or, with MySQL, several **databases** on one
server — all through a single Drupal connection. **No routes, no permissions, no forms, no admin UI,
no Drush** (only a one-paragraph `hook_help` on `help.page.dbxschema`). Core `^11 || ^12`. License
GPL-2.0-or-later. Version 2.1.0.

The base module is **database-agnostic and inert alone** — you must also enable at least one driver
submodule. A `runtime_requirements` hook raises a runtime **error** if no `CrossSchema` plugin is
enabled, and `hook_modules_installed()` warns on install.

## Solution docs

- **The cross-schema Connection: getting one, the `{n:table}` token syntax, extra schemas, `useCrossSchemaFor`** → [api/connection.md](api/connection.md)
- **DatabaseTool service: schema create/clone/rename/drop/size, name validation, the reservation registry** → [api/database-tool.md](api/database-tool.md)
- **The `CrossSchema` plugin type — writing a driver for another RDBMS** → [plugins/cross-schema-driver.md](plugins/cross-schema-driver.md)
- **Config object `dbxschema.settings` (reserved patterns, test schema names)** → [config/settings.md](config/settings.md)
- **Driver submodules** (own doc trees): [dbxschema_pgsql](../../../../db/dbxschema/modules/dbxschema_pgsql/2.1.x/agent/start.md) · [dbxschema_mysql](../../../../db/dbxschema/modules/dbxschema_mysql/2.1.x/agent/start.md)

## What it actually is (from source)

- **Plugin type `CrossSchema`** — manager `Drupal\dbxschema\CrossSchemaPluginManager` (service
  `plugin.manager.dbxschema`), declared with the PHP **attribute** `Drupal\dbxschema\Attribute\CrossSchema`
  (`id`, `driver`, `description`, optional `deriver`) — the legacy annotation
  `Drupal\dbxschema\Annotation\CrossSchema` is still supported (manager passes both to its parent).
  Interface `Plugin\CrossSchemaInterface`, base `Plugin\CrossSchemaBase`. Plugins live in
  `src/Plugin/CrossSchema/`. Each plugin's `getClass()` maps the categories `DatabaseTool` /
  `Connection` / `Schema` to concrete per-driver classes. Alter hook: `dbxschema_info`.
- **Services** (`dbxschema.services.yml`): `dbxschema.tool` (factory `DatabaseTool::getDatabaseTool`),
  `dbxschema.tool.factory` (`Database\DatabaseToolFactory`), `dbxschema.database`
  (factory `DatabaseTool::getConnection`), `dbxschema.logger` (channel `dbxschema`), plus the two
  autowired OOP **hook classes** `Hook\DbxschemaHooks` and `Hook\DbxschemaRequirementsHooks`.
- **Hooks (OOP, `#[Hook]`)**: `Hook\DbxschemaHooks::help()` (`#[Hook('help')]`, delegated from a
  `#[LegacyHook]` `dbxschema_help()` in `.module`); `Hook\DbxschemaRequirementsHooks::runtime()`
  (`#[Hook('runtime_requirements')]`) errors if no driver plugin is enabled. Install-time checks live
  in `Install\Requirements\DbxschemaRequirements` (`InstallRequirementsInterface`, the per-table-prefix
  warning); `dbxschema.install` keeps a `#[LegacyRequirementsHook]` `dbxschema_requirements()` and
  `hook_modules_installed()`.
- **Abstract `Database\DatabaseTool`** — driver-agnostic entry point. Statics `getConnection()`,
  `getDatabaseTool()`, `getDriverImplementation()`; schema lifecycle (`createSchema`, `cloneSchema`,
  `renameSchema`, `dropSchema`, `schemaExists`, `getSchemaSize`, `getDatabaseSize`); validation
  (`isInvalidSchemaName`, `SCHEMA_NAME_REGEXP`, `TABLE_NAME_REGEXP`); reservation registry
  (`reserveSchemaPattern`/`isSchemaReserved`/`freeSchemaPattern`, seeded from `dbxschema.settings`);
  `parseTableDdl()`.
- **`Database\CrossSchemaConnectionInterface`** (+ `CrossSchemaConnectionTrait`) — extends Drupal's
  `Connection`; adds `setSchemaName`/`getSchemaName`, `addExtraSchema`/`setExtraSchema`/`getExtraSchemas`/`clearExtraSchemas`,
  `useCrossSchemaFor`/`useDrupalSchemaFor`, `getMessageLogger`/`setMessageLogger`, and overrides
  `prefixTables()`/`tablePrefix()` to honor `{n:table}` tokens.
- **`Database\CrossSchemaSchemaInterface`** (+ `CrossSchemaSchemaTrait`) — extends Drupal's `Schema`;
  adds `schemaExists`/`createSchema`/`cloneSchema`/`renameSchema`/`dropSchema`/`getSchemaDef`/`findTables`/
  `getTables`/`getTableDef`/`getTableDdl`/`getReferencingTables`.
- **`ProprietarySchemaInterface`/`ProprietarySchemaTrait`** — load static schema definitions from YAML
  files (`source => 'file'`) for non-Drupal third-party layouts (`findVersion`/`getAvailableInstances`/`getVersion`).
- **Exceptions** (`src/Exception/`): `DatabaseToolException`, `ConnectionException`, `SchemaException`,
  `CrossSchemaException`.
- **Config**: `config/install/dbxschema.settings.yml` + schema `config/schema/dbxschema.schema.yml`
  (`reserved_schema_patterns`, `test_schema_base_names`). No `config_form`/settings route.

## Dependencies & install notes

- Requires **no** contrib modules. Enable `dbxschema` **plus** `dbxschema_pgsql` and/or `dbxschema_mysql`.
- **Not compatible with per-table prefixing** — the install requirements check warns if `settings.php`
  uses an array `prefix` with more than one entry or an `extra_prefix`. Set `prefix` to a plain string.
- Cross-query only works across schemas/databases reachable through **one** connection
  (same host+port+credentials).
