<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service API, admin UI, routes, and Drush commands

## Install & enable

```bash
composer require drupal/auto_increment_alter
drush en auto_increment_alter -y
```

Requires the core **`mysql`** module (declared `dependencies: - drupal:mysql`). The module works
**only** on the MySQL driver; on any other driver every operation logs
`"The <type> database engine is not supported by the mysql driver."` and makes no change
(`AutoIncrementAlter::isDatabaseTypeSupported()`).

## Permission

Single permission in `auto_increment_alter.permissions.yml`:

- **`administer auto_increment table values`** — title "Administer AUTO_INCREMENT table values",
  `restrict access: true`. Required by all five routes below. Grant only to trusted admins: the
  tool rewrites table ID sequences directly.

## Routes (all under `/admin/config/development/auto-increment-alter`)

| Route id | Path suffix | Handler | Purpose |
|---|---|---|---|
| `auto_increment_alter.list_tables` | `` (base) | `AutoIncrementAlterController::listTables` | Read-only table + AUTO_INCREMENT list; the module's `configure` link. |
| `auto_increment_alter.table` | `/table` | `AutoIncrementAlterTableForm` | Set value for one table. |
| `auto_increment_alter.content_entity` | `/content-entity` | `AutoIncrementAlterContentEntityForm` | Set base/revision values for one content entity. |
| `auto_increment_alter.tables` | `/tables` | `AutoIncrementAlterTablesForm` | Confirm form; bulk from `$settings`. |
| `auto_increment_alter.content_entities` | `/content-entities` | `AutoIncrementAlterContentEntitiesForm` | Confirm form; bulk from `$settings`. |

Menu link under *Configuration → Development*; local tasks (List / Alter single table / Alter
single content entity) and two action links ("Alter multiple tables", "Alter multiple content
entities") are declared in the `*.links.*.yml` files.

### The forms

- **`AutoIncrementAlterTableForm`** — `#type select` of `getTableList()` tables (real tables only)
  + `#type number` (`#min 1`) value. Reads `?name=<table>` from the query to preselect a row and
  show its current value; the submit handler casts the value to int and calls
  `alterTable($table, (int) $value)`.
- **`AutoIncrementAlterContentEntityForm`** — `#type select` of content-entity types (from
  `getEntityList('content')`, keyed by machine name, labelled by `getLabel()`), a required base
  `#number` and optional revision `#number`; calls `alterContentEntity($id, $base, $revision)`.
- **`AutoIncrementAlterTablesForm` / `AutoIncrementAlterContentEntitiesForm`** — `ConfirmFormBase`
  subclasses. They display the settings-driven plan (each entry `Html::escape()`d), disable the
  submit button when the corresponding `$settings` array is empty/not an array, and on confirm call
  `alterTables()` / `alterContentEntities()`. See [../config/settings.md](../config/settings.md).

## Service: `auto_increment_alter.mysql`

Class `Drupal\auto_increment_alter\AutoIncrementAlterMysql` (final) extends abstract
`AutoIncrementAlter`, implementing `AutoIncrementAlterInterface`. Inject it or fetch
`\Drupal::service('auto_increment_alter.mysql')`.

Interface methods (`AutoIncrementAlterInterface`):

| Method | Effect |
|---|---|
| `alterTable(string $table, int $value): void` | Set one table's AUTO_INCREMENT (checks existence, rejects `< 0`). |
| `alterTables(): void` | Apply `$settings['auto_increment_alter_tables']`. |
| `alterContentEntity(string $entity_name, int $base, ?int $revision = NULL): void` | Set base and (if present) revision table; falls back to base value when revision omitted. |
| `alterContentEntities(): void` | Apply `$settings['auto_increment_alter_content_entities']`. |
| `getEntityList(?string $group = NULL): array` | Entity-type definitions, optionally filtered by group (`content` / `configuration`). |
| `getTableList(): array` | `SHOW TABLES`. |
| `getTableAutoIncrementValue(string $table): ?string` | One table's current AUTO_INCREMENT (NULL + warning if unset/missing). |
| `getTableAutoIncrementValues(?bool $all = FALSE): array` | Map of table → AUTO_INCREMENT from `information_schema.tables`; `$all=TRUE` includes NULLs. |

Internals: `alterTableAutoIncrement()` (MySQL impl) runs
`ALTER TABLE {<table>} AUTO_INCREMENT = <value>` through `$this->database->query()`, guarding on
`schema()->tableExists()` (skippable via the `$ensure_table` arg for entity-resolved tables) and on
a non-negative value, logging notice/error via the `auto_increment_alter` logger channel. The read
query is parameterized on the schema name (`:table_schema` from `getConnectionOptions()['database']`).

## Drush commands (`AutoIncrementAlterCommands`, all `#[ValidateModulesEnabled(['mysql'])]`)

| Command (aliases) | Args / options | Does |
|---|---|---|
| `auto-increment-alter:table` (`aia-t`) | `table value` | `alterTable()`. |
| `auto-increment-alter:tables` (`aia-ts`) | — | `alterTables()` from settings. |
| `auto-increment-alter:content-entity` (`aia-ce`) | `entity_name base [revision]` | `alterContentEntity()`. |
| `auto-increment-alter:content-entities` (`aia-ces`) | — | `alterContentEntities()` from settings. |
| `auto-increment-alter:value` (`aia-v`) | `table` | Log one table's value. |
| `auto-increment-alter:values` (`aia-vs`) | `--all` | Table of table → value (`--all` includes unset). |
| `auto-increment-alter:entity-list` (`aia-el`) | `--group=content|configuration` | Table of entity name + group. |
| `auto-increment-alter:table-list` (`aia-tl`) | — | Table of raw table names. |

```bash
drush auto-increment-alter:table node 500
drush auto-increment-alter:content-entity node 500 1000
drush auto-increment-alter:values --all
```
