<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Opting entity-reference fields into Core's `entity_reference` Views filter

Cheaper than reading `views_core_entity_reference.module` + `.install`. Everything below is the
module's entire behaviour.

## Install / enable

```
drupal:views is the only dependency.
drush en views_core_entity_reference -y
drush cr            # rebuild Views data so the alter hook re-runs
```

Requires a Core that ships the `entity_reference` Views filter plugin (Drupal `^10.2 || ^11`;
practically 10.2+/10.4.x/11.x). No settings, no permissions to grant. Enable → the change applies to
**every** entity-reference field site-wide.

## The opt-in mechanism — `hook_views_data_alter()`

`views_core_entity_reference_views_data_alter(&$data)` (`.module:34`) runs when Views rebuilds its
data (on cache clear / Views data rebuild), i.e. an admin/build-time context, never per page request:

1. `\Drupal::entityTypeManager()->getStorage('field_config')->loadByProperties(['field_type' =>
   'entity_reference'])` — loads all configured entity-reference fields (`FieldConfig` entities).
2. For each field it derives the Views table and column purely by string composition:
   - `$table_name = $field_config->getTargetEntityTypeId() . '__' . $field_config->getName();`
     (e.g. `node__field_author`). `getTargetEntityTypeId()` is the entity type the field is
     *attached to*, not the referenced type.
   - `$column_name = $field_config->getName() . '_target_id';` (e.g. `field_author_target_id`).
3. It flips the filter **only** when the current handler is generic:
   `if (isset($data[$table][$column]['filter']['id']) && in_array($data[...]['filter']['id'],
   ['numeric', 'string'])) { ... = 'entity_reference'; }`.
   Fields whose column already uses some other filter id (a custom handler, or already
   `entity_reference`) are left untouched — the module never clobbers an existing choice.

That single reassignment is the whole feature. It does **not** implement Select/Autocomplete: it
points the field's Views filter at Core's existing `entity_reference` filter plugin
(`Drupal\views\Plugin\views\filter\EntityReference`), which supplies the Select vs Autocomplete
widget (`WIDGET_SELECT` / `WIDGET_AUTOCOMPLETE`), the `sub_handler` (e.g. `default:node`),
`sub_handler_settings` (target bundles, sort), and the operator UI. Access to what a viewer can pick
and see is entirely Core's filter plus the View's own access settings — this module adds no request
path code.

## The one-time install migration — `.install`

`views_core_entity_reference_install($is_syncing)` calls
`_views_core_entity_reference_update_as_a_reference()` (`.install:11`, `:18`). It exists only to fix
views that were built against the long-lived pre-commit **Core patch** from issue 3347343, which
appended a `_reference` suffix to filter machine names. It is a **no-op on fresh sites** (no such
views exist).

For every `views.view.*` config it edits `display.default.display_options.filters` in place:

- Considers a filter only if `plugin_id === 'entity_reference'` AND its array key ends in
  `_reference` AND its `id` ends in `_target_id_reference`.
- Strips the trailing `_reference` from the filter `id` and (if present) `field`
  (`substr($x, 0, -strlen('_reference'))`).
- Rewrites exposed-filter identifiers: `expose.operator_id` / `expose.operator` ending in
  `_target_id_reference_op` become `_target_id_op` (strip `_reference_op`, re-append `_op`).
- Renames the filter array key itself (drop the trailing `_reference`), then resaves the view
  (`$view_config->set(...); $view_config->save();`) — but only when at least one filter changed
  (`$has_change`).

Pure `str_ends_with` / `substr` string manipulation on config values; no SQL, no request input, no
entity loading. The `tests/modules/test_as_a_reference/config/install/views.view.test_view_as_a_reference.yml`
fixture shows the "before" shape (keys like `field_related_articles_target_id_reference`) this
migration normalises; `tests/src/Kernel/ViewsCoreEntityReferenceUpdateTest.php` covers it.

## Operating notes

- After enabling, re-run `drush cr`; then edit any View filtering an entity-reference field — the
  filter now offers a Select or Autocomplete of the referenced entities instead of a numeric id box.
- The `tests/src/Kernel/ViewsCoreEntityReferenceFilterTest.php` demonstrates both widgets: exposed
  input `field_test_target_id` as a select-list array, and `[['target_id' => id], ...]` for
  autocomplete; it also asserts the View gains `content` config-dependencies on the referenced
  entities used as filter default values.
- **Code alternative** (no module): implement your own `hook_views_data_alter()` and set
  `$data['node__' . $field . '][' . $field . '_target_id']['filter']['id'] = 'entity_reference';`
  for the single field you want. This module just does it for all entity-reference fields at once.
- The module is intended as a temporary bridge until the Core follow-up issues land, after which a
  site can migrate to Core-only and uninstall it.
