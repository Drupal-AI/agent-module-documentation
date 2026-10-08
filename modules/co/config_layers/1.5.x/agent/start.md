<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# config_layers — agent start

info.yml name: **Config Layers**. Version **1.5.0**. Core `^11`. Package `Config`. No module deps.

Splits configuration into ordered **layers**. Each layer is a `config_layer` config entity with
its own on-disk `FileStorage` (the layer `path`) **and** its own database table
(`config_layer_<id>`). Layers are merged in `weight` order into an in-memory storage; the merged
result can be written into the site's **active** configuration. During the merge each layer is
de-duplicated so it keeps only the config that differs from the lower-weight layers (unless the
layer's `reset` flag is set, which makes it override as-is). Inspired by Config Split / Config
Overlay / Config Merge.

Primary driver is **Drush** (import/export/synchronize); the layer entities are created/edited in
the admin UI or via Drush. There is also an optional **event-driven** mode where a layer imports
or exports itself automatically when named config CRUD events fire.

## Access / routes
All 9 routes live under `/admin/config/development/configuration/config_layers` and are gated by
the single permission **`administer config layers`** (`config_layers.permissions.yml`,
`restrict access: true`). Collection/add/edit/delete/synchronize are entity list + Form API
pages; `enable`, `disable`, `import`, `export` are `ConfigLayerController::performOperation()`
redirects. Config schema in `config/schema/config_layers.schema.yml`.

## Subdocs
- Drush commands (the main interface: create/import/export/synchronize/get/set/status/…) → [drush/drush.md](drush/drush.md)
- Layer entity fields + event-triggered import/export + merge/update modes → [configure/layers.md](configure/layers.md)

## Key source
- `src/Entity/ConfigLayer.php` — the config entity; DB table `config_layer_<id>`, file storage at
  `path`, source = disk (`default`) or `active`; `import()`/`export()`/`delete()`.
- `src/ConfigLayerManager.php` — merge/dedupe engine (`mergeLayers`, `combine`, `getMergedLayer`,
  `getConfigDiff`) and the six update modes.
- `src/Commands/ConfigLayersCommands.php` — all Drush commands.
- `src/EventSubscriber/ConfigSubscriber.php` — per-layer `import_events`/`export_events`
  automation on `config.save/delete/rename/import`; skips while `isConfigSyncing()`.
- `src/Config/{NormalizedStorage,FilteredStorage,StorageDecorator,ConfigSorter,NormalizedStorageComparer}.php`
  — schema-sorted storage decorators used so comparisons/merges are order-insensitive.
