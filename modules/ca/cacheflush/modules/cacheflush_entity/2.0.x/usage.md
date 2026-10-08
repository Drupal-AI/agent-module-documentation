Cacheflush Entity defines the `cacheflush` content entity that stores CacheFlush presets, and a set of procedural helper functions to create, load and delete them. It is the required dependency of the base `cacheflush` module.

---

The submodule declares a single `@ContentEntityType(id = "cacheflush", base_table = "cacheflush")` with entity keys `id`, `label` (the `title` field) and `uuid`. Its base fields are `id`, `uuid`, `title` (string, max 80), `uid` (author entity reference, defaults to the current user in `preCreate`), `status` (boolean; 1 = published/enabled), `data` (a `map` field holding the preset's selected cache-clear functions), plus `created` and `changed`. `getData()`/`setData()` (de)serialise the preset function map, and the entity implements `EntityOwnerInterface`/`EntityChangedInterface`. The bare entity has **no forms, views, access handler, or routes** — those are added by `cacheflush_ui`; the `menu` and `cron` base fields are added by `cacheflush_ui` and `cacheflush_cron` respectively via `hook_entity_base_field_info()`. For programmatic use it ships procedural helpers in `cacheflush_entity.module`: `cacheflush_create()`, `cacheflush_load()`, `cacheflush_load_multiple()`, `cacheflush_load_multiple_by_properties()`, `cacheflush_delete()`, and `cacheflush_delete_multiple()`. There is no config, no permissions, no Drush, and no plugin types of its own.

---

- Store a named cache-flush preset as a content entity row.
- Persist each preset's selected clear functions in the `data` map field.
- Track who created a preset via the `uid` (author) field.
- Enable/disable a preset with its `status` field (0 disables cache clearing).
- Load a preset by id with `cacheflush_load($id)`.
- Load all presets with `cacheflush_load_multiple()`.
- Load only enabled presets with `cacheflush_load_multiple_by_properties(['status' => 1])`.
- Create a preset programmatically with `cacheflush_create($values)`.
- Delete a preset by id with `cacheflush_delete($id)`.
- Bulk-delete presets with `cacheflush_delete_multiple($ids)`.
- Read a preset's stored functions with `$entity->getData()`.
- Set a preset's functions with `$entity->setData($array)`.
- Use the `title` as the human label of a preset.
- Give another module a stable entity type to attach base fields to (menu, cron).
- Reference the preset's UUID for deployment-safe linking.
- Query presets with the entity query API (`\Drupal::entityQuery('cacheflush')`).
- Back a custom cache-clear UI with the same storage the module uses.
- Migrate presets between environments as entity data.
- Expose presets to Views (via cacheflush_ui's views_data handler).
- Serve as the {cacheflush} route parameter for clear-by-id routes.
