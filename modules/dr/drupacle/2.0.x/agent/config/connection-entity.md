<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `drupacle_connection` config entity

## Install & enable

```bash
composer require drupal/drupacle
drush en drupacle -y
```

No Drupal module dependencies. The **`oci8`** PHP extension (Oracle Instant Client) must be present
on the server for connections to actually open; without it the list page reports
`"oci8 extension not found"` (see `DrupacleConnectionListBuilder::testOracleConnection()`).

## Entity definition

`src/Entity/DrupacleConnection.php` is a `@ConfigEntityType` named **`drupacle_connection`**
(`config_prefix: drupacle_connection`) extending `ConfigEntityBase`. Handlers:

- `access` → `DrupacleConnectionAccessControlHandler`
- `list_builder` → `DrupacleConnectionListBuilder`
- `form` → `add`/`edit` = `DrupacleConnectionForm`, `delete` = `DrupacleConnectionDeleteForm`
- `route_provider.html` → `DrupacleConnectionHtmlRouteProvider`

`entity_keys`: `id`, `label`, `uuid`. `admin_permission`: `administer drupacle connections`.
`links`: `add-form`, `edit-form`, `delete-form`, `collection` (all under `/admin/drupacle`).

## Stored fields (`config_export` + schema)

`config_export` and `config/schema/drupacle_connection.schema.yml`
(`drupacle.drupacle_connection.*`, type `config_entity`) define these keys:

| Key | Schema type | Meaning |
|---|---|---|
| `id` | string | Machine name |
| `label` | label | Connection name (also used as the lookup/return key) |
| `db_name` | string | Oracle database name |
| `host` | string | Host / IP |
| `port` | number | Port (0–65535) |
| `username` | string | Oracle username |
| `password` | string | Oracle password |
| `db_service_name` | string | Service name / SID (optional) |

Because these are `config_export` keys, a saved connection is an exportable configuration object
(`drupacle.drupacle_connection.<id>.yml`) held in Drupal's active config like any other config entity.

Helper method: `getHostWithPortAndService(): string` returns `"$host:$port/$service"` when a service
name is set, otherwise `"$host:$port"` — this is the connect string handed to `oci_connect()` by the
controller.

## Add / edit form (`DrupacleConnectionForm`)

Extends `EntityForm`. Fields: `label` (required), `id` (machine_name, `exists` =
`DrupacleConnection::load`), `db_name` (required), `host` (required, placeholder `100.100.100.100`),
`port` (number, min 0 max 65535, optional), `username` (required), `password` (required),
`db_service_name` (optional, "Service Name / SID"). `save()` calls `$entity->save()`, shows a
Created/Saved status message, and redirects to the `collection`.

## Delete form (`DrupacleConnectionDeleteForm`)

Extends `EntityConfirmFormBase` — a standard confirm form. `getQuestion()` asks "Are you sure…",
cancel URL is the collection, `submitForm()` calls `$entity->delete()`, adds a status message and
redirects back. Deletion is therefore a POST behind a confirmation step.

## Config schema note

`config/install/drupacle.settings.yml` ships `{status: true, title: 'Connection Access'}`, but there
is **no** `drupacle.settings` entry in the schema file (only the connection-entity schema exists), so
that install object has no matching schema. The connection entity itself is fully schema-covered.
