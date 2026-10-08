<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, permissions & access model

## Config object `enhanced_taxonomy_manager.settings`

Route `enhanced_taxonomy_manager.settings` → `Form\SettingsForm`, path
`/admin/config/content/enhanced-taxonomy-manager` (`_permission: administer taxonomy`). Defaults in
`config/install/enhanced_taxonomy_manager.settings.yml`, schema in
`config/schema/enhanced_taxonomy_manager.schema.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `page_size` | integer | 100 | Terms loaded per page/lazy batch in the tree. |
| `default_expand_depth` | integer | 0 | How many levels are expanded on initial load. |
| `enable_drag_nesting` | boolean | false | Allow reparenting (nesting) via drag by default. |
| `confirm_reparent` | boolean | true | Confirm before a drag changes a term's parent. |
| `max_undo_history` | integer | 200 | Max `enhanced_taxonomy_revisions` rows kept per vocabulary. |
| `snapshot_date_format` | string | `'system'` | `'system'` → date.formatter `short`; otherwise a PHP `date()` format string used to name snapshots. |

These are read in `TreeController::vocabularyOverview` (and pushed to
`drupalSettings.taxonomy_manager`) and in `EtmControllerBase` (`formatSnapshotDate`,
`recordRevision`).

## Permissions

Two sources:

1. Static: `enhanced_taxonomy_manager.permissions.yml` declares only a `permission_callbacks`
   entry → `EtmPermissions::vocabularyPermissions`.
2. Dynamic, one set **per vocabulary** (`Vocabulary::loadMultiple()`):
   - `etm manage terms in {vid}` — add/edit/delete/move/merge terms in that vocabulary via ETM.
   - `etm export terms in {vid}` — export as CSV / text list.
   - `etm import terms in {vid}` — bulk import.

There is no site-wide "use ETM" permission; `administer taxonomy` is the global override.

## Access model

- `_etm_access: 'TRUE'` → service `enhanced_taxonomy_manager.access_checker`
  (`Access\EtmAccessCheck::access`), tagged `access_check, applies_to: _etm_access`. Logic:
  `administer taxonomy` allowed globally; else the vocabulary id (from the `{taxonomy_vocabulary}`
  param, or derived from `{taxonomy_term}->bundle()` on term-scoped routes) must have
  `etm manage terms in {vid}`. Every branch calls `cachePerPermissions()` and adds the
  vocabulary/term as a cacheable dependency.
- `EtmAccessCheck::exportAccess` / `::importAccess` — used via `_custom_access` on the export/import
  routes; accept `administer taxonomy`, the manage permission, or the dedicated export/import
  permission for that vid.
- The delete route (`enhanced_taxonomy_manager.term_delete`) defers to core
  `_entity_access: 'taxonomy_term.delete'`.

## Install / uninstall

`enhanced_taxonomy_manager.install` defines `hook_schema` for `enhanced_taxonomy_snapshots` and
`enhanced_taxonomy_revisions`; `hook_uninstall` drops both. Update hooks `_8001`–`_8003` create the
tables and add `is_auto` / `snapshot_id`. `hook_taxonomy_vocabulary_delete` (in
`src/Hook/EnhancedTaxonomyManagerHooks.php`) deletes both tables' rows for the removed vocabulary so
a recreated same-named vocabulary does not inherit stale snapshots.
