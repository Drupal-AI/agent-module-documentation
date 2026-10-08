<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, settings & field lifecycle

## Install & enable

```bash
composer require drupal/entity_recycle
drush en entity_recycle -y
```

Only dependency is core **`node`** (`entity_recycle.info.yml`). On enable, the module imports
`config/install/entity_recycle.settings.yml` (empty defaults) and
`config/install/views.view.content_recycle_bin.yml` (the recycle-bin listing view). No fields are
created until you enable entity types on the settings form.

## Settings form

Route **`entity_recycle.settings`** → `/admin/config/content/entity_recycle`, permission
**`administer entity recycle bin`**, menu link under *Configuration → Content authoring*
(`entity_recycle.links.menu.yml`). Handled by
`Form\EntityRecycleSettingsForm` (`ConfigFormBase`, edits `entity_recycle.settings`).

`buildForm()`:
- **Purge Time (minutes)** — `general[purge_time]` textfield. Empty/0 disables auto-purge.
- **Enable Entity Recycle Bin for** — `general[entity_types]` checkboxes of every
  `ContentEntityTypeInterface` definition.
- Per bundleable type, a nested **bundles** checkboxes element (states-visible when its type is
  checked). Leaving all bundles unchecked = "all bundles" for that type.

`submitForm()` calls `updateRecycleBinField()` then saves `purge_time` and per-type `types.<id>`
into config, and runs `drupal_flush_all_caches()`.

## Config object & schema

Config object **`entity_recycle.settings`** (schema `config/schema/entity_recycle.schema.yml`):

```yaml
purge_time: <integer>          # minutes; falsy = purge disabled
types:                         # sequence keyed by entity_type_id
  <entity_type_id>:            # sequence of bundle machine names (empty = all bundles)
    - <bundle>
```

`EntityRecycleManager::isEnabled($entity, $bundle)` returns TRUE only when
`types[<entityTypeId>][<bundle>]` is set — i.e. recycle behaviour is per type **and** bundle.

## Field lifecycle (`EntityRecycleManager`)

Enabling a type/bundle triggers `createField()`:
- Ensures a shared **field storage** for `recycle_bin` via `getFieldStorageData()` — a **boolean**,
  `locked = TRUE`, cardinality 1, per entity type.
- Creates a `field_config` per bundle labelled *"Recycle Bin"*, then `setDefaultFieldValue()` runs a
  **batch** setting `recycle_bin = 0` on existing entities (static
  `EntityRecycleManager::setEntityFieldValue()`).

Disabling a type/bundle triggers `deleteField()` (removes field configs, and field storage when no
bundle is given). `hook_uninstall` (`entity_recycle.install`) calls `deleteField()` for every
enabled type and deletes `views.view.content_recycle_bin`, then flushes caches.

`hook_entity_presave` (`entity_recycle.module`) sets `recycle_bin = 0` on **new** entities of an
enabled type so freshly created content is never treated as binned.
