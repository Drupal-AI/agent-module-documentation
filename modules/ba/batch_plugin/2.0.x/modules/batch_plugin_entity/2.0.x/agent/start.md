<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Batch Plugin Entity (batch_plugin_entity) — agent index

Sub-module of **batch_plugin** (dependency `batch_plugin:batch_plugin`) that adds a config entity
and admin UI to create, configure, enable/disable and **run** batch plugins with no code. Package
`Batch Plugin`. Core `^10 || ^11`. GPL-2.0-or-later. Version 2.0.9 (dir `2.0.x`).
`configure` route: `entity.batch_plugin_entity.collection`.

## Config entity `batch_plugin_entity`

- Class `src/Entity/BatchPluginEntity.php` (`@ConfigEntityType`), `config_prefix
  batch_plugin_entity`, `admin_permission "administer batch_plugin_entity"`.
- `config_export`: `id`, `label`, `description`, `plugin`, `settings`.
- Wraps one batch plugin via `BatchPluginEntityCollection` (a `DefaultSingleLazyPluginCollection`)
  keyed by the stored `plugin` id; `getPlugin()` returns the `BatchPluginInterface`.
- `postSave()` (on create) deletes the entity's queue if the chosen processor is not a cron
  processor and clears the queue-worker definition cache so derivatives are re-discovered.
- `delete()` removes the entity's queue (`QUEUE_NAME_ENTITY_PREFIX . id`).
- Schema `config/schema/batch_plugin_entity.schema.yml` (`id`, `label`, `description`, `plugin`,
  `processor`, `settings` mapping).

## Permission (`batch_plugin_entity.permissions.yml`)

- `administer batch_plugin_entity` — gates **every** route below.

## Routes (`batch_plugin_entity.routing.yml`) — all require that permission

| Route | Path | Handler |
|---|---|---|
| `entity.batch_plugin_entity.collection` | `/admin/structure/batch-plugin` | list builder (`BatchPluginEntityListBuilder`) |
| `entity.batch_plugin_entity.add_form` | `/admin/structure/batch_plugin/add` | `BatchPluginEntityLibraryController::listPlugins` (pick a plugin) |
| `batch_plugin_entity.admin_add` | `/admin/structure/batch_plugin/{plugin_id}` | `BatchPluginEntityAddController::batchPluginEntityAddConfigureForm` |
| `entity.batch_plugin_entity.edit_form` | `/admin/structure/batch-plugin/{batch_plugin_entity}` | entity form `batch_plugin_entity.edit` |
| `entity.batch_plugin_entity.delete_form` | `/admin/structure/batch-plugin/{batch_plugin_entity}/delete` | `EntityDeleteForm` |

Menu link `entity.batch_plugin_entity.overview` under `system.admin_structure`; local action to add.

## Forms / controllers

- `Form/BatchPluginEntityForm` — label, machine id, description, **Enabled** checkbox, and the
  wrapped plugin's own configuration sub-form. If the entity exists, a **Process** button
  (`::processPlugin` → `save()`) runs the plugin immediately after saving: it resolves the
  configured `processor_plugin_id`, sets the entity queue id for cron processors, and calls
  `$processor->process($plugin)`. `save()` also sets the plugin's config key to
  `batch_plugin_entity.batch_plugin_entity.<id>`.
- `Controller/BatchPluginEntityLibraryController::listPlugins` — table of addable plugins;
  **skips** definitions marked `hidden` and those whose `permission` the current user lacks.
- `Controller/BatchPluginEntityAddController` — creates a new entity for the chosen `plugin_id`.
- `BatchPluginEntityListBuilder` — collection table (label, machine name, plugin id, provider,
  processor, status); tolerates a missing plugin definition.

## Detail

→ [entity/reference.md](entity/reference.md)

Parent framework → [../../../../agent/start.md](../../../../agent/start.md)
