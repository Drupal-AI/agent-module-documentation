<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# A12S MaPS Sync (a12s_maps_sync) — agent index

Imports objects, media and library taxonomy from the **MaPS System** PIM/DAM Web API into Drupal
entities and fields, driven by configuration entities (**profiles** and **converters**) and a
batch/queue import engine. Package `A12S`. Depends only on core **`content_translation`**. Core
`^9 || ^10 || ^11`. PHP `>=7.1`. License GPL-2.0-or-later. Version 2.0.23.

The remote connection is configured **only** through two environment variables read by
`MapsApi` (`src/MapsApi.php`): `A12S_MAPS_SYNC_API_URL` (base URL) and `A12S_MAPS_SYNC_API_KEY`
(sent as the `X-Maps-Api-Key` request header). Keep both in env / a Key entity — never in config.

## Solution docs

- **Global settings, config objects, routes & permissions** → [config/settings.md](config/settings.md)
- **Profile / Converter / Contextualized-Attribute entities + the GID base field** →
  [entities/entities.md](entities/entities.md)
- **The MaPS API client and the import/batch/state engine** → [api/maps-api.md](api/maps-api.md)
- **The three plugin types (source / mapping / sync handlers)** → [plugins/handlers.md](plugins/handlers.md)
- **Drush commands (import, rollback, batch, locks, auto-config)** → [drush/commands.md](drush/commands.md)

## What it provides (from source)

- **Config entities**: `maps_sync_profile` (`Entity/Profile.php`) and `maps_sync_converter`
  (`Entity/Converter.php`); config prefixes `a12s_maps_sync.maps_sync_profile.*` /
  `.maps_sync_converter.*`. Both use `admin_permission = "administer site configuration"` and
  custom HTML route providers under `/admin/a12s_maps_sync/…`.
- **Content entity**: `contextualized_attribute` + bundle type `contextualized_attribute_type`
  (`Entity/ContextualizedAttribute*.php`), base table `contextualized_attribute`, with its own
  access handler `ContextualizedAttributeAccessControlHandler`.
- **Base field**: `BaseInterface::GID_FIELD` ("MaPS Sync ID") added to allowed entity types by
  `a12s_maps_sync_entity_base_field_info_alter()`.
- **Services** (`*.services.yml`): `a12s_maps_sync.maps_api` (MapsApi), `.auto_config_manager`,
  `.maps_object_manager` / `.maps_media_manager` / `.maps_library_manager`, three plugin managers,
  a route subscriber, and a logger channel `a12s_maps_sync`.
- **Plugin types**: `maps_sync_source_handler`, `maps_sync_mapping_handler`, `maps_sync_handler`
  (annotations in `src/Annotation/`, managers in `src/Plugin/`).
- **Drush**: `A12sMapsSyncCommands` (`drush.services.yml`) — ~20 `a12s_maps_sync:*` commands.
- **Routes** (`*.routing.yml`): admin menu block plus Settings, Dashboard, Config explorer and
  Import-object forms under `/admin/config/a12s-maps-sync`, each gated by a dedicated permission.
- **Permissions** (`*.permissions.yml`): `administer a12s maps sync`, `use … dashboard`,
  `use … config explorer`, `import a12s maps sync object/profile/converter`,
  `reimport a12s maps sync entities`, plus the contextualized-attribute CRUD set.
- **Config schema** in `config/schema/`; install defaults `a12s_maps_sync.settings` +
  `a12s_maps_sync.languages_mapping` in `config/install/`.
