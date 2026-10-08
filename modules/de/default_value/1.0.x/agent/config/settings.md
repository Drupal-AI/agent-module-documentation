<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Default Value — settings & how it works

## Install / enable
`drush en default_value -y`. No dependencies, no config schema, no install hooks. The
empty `config/install/default_value.settings.yml` seeds an empty `default_value.settings`
object.

## Coverage form
- Route `default_value.config` → `/admin/config/system/default-value`, form
  `Drupal\default_value\Form\DefaultValueSettingsForm` (extends `ConfigFormBase`).
- Menu link `default_value.config` under `system.admin_config_system`
  ("Default Value Settings").
- `setSupporrtedEntities()` (note the sic spelling) enumerates all entity type
  definitions, keeps only those whose class implements `ContentEntityBase`, and **excludes**
  this hard-coded list: `path_alias`, `webform_submission`, `contact_message`, `shortcut`,
  `search_api_task`, `redirect`, `file`.
- `buildForm()` renders one `fieldset` per supported entity type with a `checkboxes`
  element (`#options` = that type's bundles) named by the entity type ID.
- `submitForm()` writes, per entity type ID, the array of checked bundle IDs into
  `default_value.settings`, then **truncates** the cache tables `cache_entity`,
  `cache_render`, `cache_menu`, `cache_page`, `cache_dynamic_page_cache` (each guarded by
  `schema()->tableExists()`) so the new coverage is visible immediately.

## Config shape
Config object `default_value.settings`. One key per opted-in entity type; value is the
array of enabled bundle machine names, e.g.:

```yaml
node:
  - article
  - page
taxonomy_term:
  - tags
```

## The load hook — `default_value_entity_load()` (`default_value.module`)
On every `hook_entity_load()`:
1. Read `default_value.settings`; for the current `$entity_type_id`, get the array of
   allowed bundles (`$config->get($entity_type_id)`, defaulted to `[]`).
2. For each loaded entity whose `bundle()` is in that list, and whose entity type
   `entityClassImplements(FieldableEntityInterface::class)`:
3. Iterate `entity_field.manager` field definitions for the bundle; act only on those that
   are `FieldConfig` instances (configurable fields, not base fields).
4. For a field whose value is an `ItemList` with `count() === 0` (empty), take
   `$definition->getDefaultValueLiteral()` and `set()` it on the entity.
5. **entity_reference** fields: for each default item carrying a `target_uuid`, resolve it
   via `entity.repository` `loadEntityByUuid($target_type, $uuid)` and rewrite it to
   `target_id` (unsetting `target_uuid`).
6. **image** fields: read the field storage's `default_image` setting and, if it has a
   `uuid`, resolve it to a `target_id` the same way.

Nothing is persisted — values are set on the in-memory loaded entity only. Because it runs
on every load of covered bundles, keep coverage scoped to bundles that actually need it.

## Permission (note the mismatch)
- `default_value.permissions.yml` defines **`administer default value settings`**
  (`restrict access: true`).
- `default_value.routing.yml` gates the settings route with
  `_permission: 'default value configurations'`.

These two strings do not match, so no role can be granted the permission the route
actually requires; in practice only the superuser (uid 1, which bypasses permission
checks) can reach `/admin/config/system/default-value`. To let another role administer
coverage you must align the two — grant a defined permission on the route (patch/override
`default_value.routing.yml` to require `administer default value settings`).

## Operating notes
- Effect is display-time only; to make defaults permanent you must load and re-save the
  entities yourself.
- Saving the form clears the listed caches automatically; if you change field defaults
  elsewhere, rebuild caches to see them applied.
