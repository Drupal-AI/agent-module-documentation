<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Views URL alias works (mechanism)

Everything lives in `views_url_alias.module` + `views_url_alias.install`. No services, no
classes except the rebuild `ConfirmFormBase`.

## The `views_url_alias` table (install schema)

| Column | Type | Notes |
|---|---|---|
| `rid` | serial (big) | primary key |
| `entity_type` | varchar_ascii | default `node` |
| `entity_id` | int | the content entity id |
| `langcode` | varchar_ascii(12) | per-language alias |
| `alias` | varchar(255) | the alias string, e.g. `title-of-the-story` |

Indexes on (`entity_type`,`entity_id`,`langcode`) and (`alias`). It is a *derived* index of
core's `path_alias` — a fast join target, not a source of truth.

## Automatic sync (path_alias entity hooks)

- `views_url_alias_path_alias_insert/update/delete()` react to `path_alias` entity changes.
  Update is skipped if the alias string didn't actually change.
- `views_url_alias_get_path_entity_type($path_alias)` resolves the alias's **system path**
  through `router.no_access_checks`, reads the route's entity parameter, loads the entity
  (and the correct translation), and returns it only if it's a `ContentEntityInterface`.
- `views_url_alias_save($entity, $alias = NULL)` deletes any existing row for
  (entity_id, entity_type, langcode) and inserts a fresh one when `$alias` is non-empty.
  **Guard:** it returns early unless `ctype_digit($entity->id())` — only numeric IDs are indexed.
- Form alters also keep the table correct on **Pathauto bulk delete**
  (`pathauto_admin_delete`) and the core **path_alias delete** form.

## Views integration — `hook_views_data()`

- Registers `views_url_alias` as a base table (group **Alias**), with `entity_id` and a
  sortable/filterable `alias` field.
- Loops all entity type definitions; for each whose class extends `ContentEntityBase`, adds a
  `standard` relationship on that entity's **data table** to `views_url_alias`
  (`base field` = `entity_id`, `real field` = the entity id key), with extra join conditions
  `entity_type = <id>` and a `langcode` match.

## Rebuild + drift flag

- `views_url_alias_rebuild_path()` truncates the table and batches all `path_alias` ids
  (chunks of 50) through `_views_url_alias_rebuild_path_process()`, handling each language
  translation. The finish callback clears the flag via `views_url_alias_needs_rebuild(FALSE)`.
- `views_url_alias_needs_rebuild($rebuild = NULL)` is a getter/setter over state key
  `views_url_alias.needs_rebuild`. `hook_install()` sets weight 2 (after Pathauto) and flags a
  rebuild if any aliases already exist; `hook_requirements()` and `hook_help()` surface the
  warning + rebuild link to users with `administer views`.

## No extension surface

No `*.api.php`, no config, no plugin types, no Drush. To integrate programmatically you would
call `views_url_alias_save()` / `views_url_alias_rebuild_path()` directly, but normal use is
purely: let the hooks sync, then join the table in Views.
