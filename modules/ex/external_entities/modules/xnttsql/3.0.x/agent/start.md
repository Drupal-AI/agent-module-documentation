<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# xnttsql — agent index

Submodule of **[external_entities](../../../../3.0.x/agent/start.md)**. Adds a **`sql` storage client**
so an external entity type can be backed by an **external SQL database or schema** (MySQL/PostgreSQL):
you write CRUD + List/Count SQL queries and each returned column becomes an entity field. Core
`^9 || ^10 || ^11`. Depends on `external_entities` and **`dbxschema`** (Database Cross-Schema Query
API) for the cross-connection. No settings page, no permissions (governed by the parent). External
database credentials are defined in `settings.php` (`$databases`), never in this module's config.

- **Configure the SQL storage client (connection, queries, placeholders, filters)** → [configure/sql-storage-client.md](configure/sql-storage-client.md)

Key facts:
- Storage client id: `sql` (`Plugin/ExternalEntities/StorageClient/Database`, extends `QueryLanguageClientBase`).
- Config schema: `xnttsql.storage_client.schema.yml` (`...storage_client.xnttsql`).
- Config keys: `queries.{create,read,update,delete,list,count}`, `connection.{dbkey,schemas}`, `placeholders[]`, `filter_mappings[]`.
- Table notation `{#:table}` (# = schema index, 1-based); `{table}`/`{0:table}` = Drupal tables.
- Query placeholders: `:id`, `:id[]`, `:filters`, plus user `:name` / `:name[]` placeholders.
