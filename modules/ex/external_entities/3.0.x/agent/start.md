<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Entities (external_entities) — agent index

Exposes **remote data sources (REST APIs, SQL, files, …) as native Drupal content entities**, read
and (where the source allows) write. No data is imported: records are fetched live and mapped to
Drupal fields, so an external entity behaves like a node (Views, view modes, references, fields,
path aliases) while the source stays authoritative. Resolved release **3.0.0-rc2**. Core `^10 || ^11`.
Requires the `galbar/jsonpath` PHP library (composer). No hard module deps.

You configure it by creating an **`external_entity_type`** config entity (one per remote dataset).
Each type picks a **data aggregator** → one or more **storage clients** (data sources), then maps
raw source data to Drupal fields via **field mappers** → **property mappers** → **data processors**.
Admin UI: `/admin/structure/external-entity-types` (route `entity.external_entity_type.collection`,
menu also under `/admin/config/external`). No single settings form; each type is its own config form.

- **Define / edit an external entity type (config keys, PHP, YAML)** → [configure/external-entity-type.md](configure/external-entity-type.md)
- **Configure the REST / JSON:API / Files storage client** → [configure/rest-storage-client.md](configure/rest-storage-client.md)
- **Add a storage client / field mapper / property mapper / data processor / data aggregator** → [plugins/plugin-types.md](plugins/plugin-types.md)
- **Call the storage/query API, services, tokens** → [api/services.md](api/services.md)
- **React to fetch/map with events** → [events/events.md](events/events.md)
- **Permissions (admin + per-type)** → [permissions/permissions.md](permissions/permissions.md)

Submodules (each documented separately): `xnttsql` (SQL-database storage client),
`xntt_views` (Views integration), `xntt_file_field` (file/image fields for external sources),
`external_entities_pathauto` (pathauto aliases), `external_entities_drupalorg` (example configs),
`xntt_example_d7import` (D7-import example).

Key facts:
- Config entity: `external_entity_type` (prefix `external_entities.external_entity_type.*`), admin
  permission `administer external entity types`.
- Plugin managers: `plugin.manager.external_entities.{storage_client,field_mapper,property_mapper,data_processor,data_aggregator}`.
- Storage handler: `Drupal\external_entities\ExternalEntityStorage`; entity query service `entity.query.external`.
- Native storage clients: `rest`, `jsonapi`, `files`. Aggregators: `single`, `group`, `horizontal`, `vertical`.
- Cron cleans the `xntt_rest_queries` table (REST rate-limit tracking). `hook_requirements` checks `galbar/jsonpath`.
- No settings page (`configure` = none), no Drush commands.
