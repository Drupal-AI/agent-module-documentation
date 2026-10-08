<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reference Overflow formatter

Plugin `EntityReferenceOverflowFormatter`
(`src/Plugin/Field/FieldFormatter/EntityReferenceOverflowFormatter.php`), id
**`entity_reference_overflow`**, label *"Reference Overflow"*, `field_types = { "entity_reference" }`.
Extends core `Drupal\Core\Field\Plugin\Field\FieldFormatter\EntityReferenceEntityFormatter` (the
"Rendered entity" formatter), so it inherits all of that formatter's rendered-entity behaviour and settings.

## Install / enable

Core-only module. `composer require drupal/entity_reference_overflow`, then
`drush en entity_reference_overflow -y`. No dependencies, no config to import.

## Where you set it

*Manage display* of any bundle with an `entity_reference` field → set that field's **Format** to
**"Reference Overflow"** → click the gear to open the settings form → **Update** → **Save**. No site-wide
settings page exists.

## Settings

`defaultSettings()` returns, on top of the parent formatter's settings:

- `min_items` (default `3`) — the number of items that should always be displayed. Rendered as a
  `#type => 'textfield'` labelled *"Minimum Items"* in `settingsForm()`.
- `ref_fields` (default `[]`) — machine names of other reference fields on the host bundle used to constrain
  the fallback query. Rendered as a multi-select *"Fields"*; options come from `getReferenceFields()`, which
  returns every `FieldConfigInterface` of type `entity_reference` on the host bundle except this field
  itself (base fields excluded).
- `sort_field` (default `created`) — the field the overflow query sorts by (DESC). No form element; set via
  config only.

Plus inherited parent settings — notably `view_mode` (the referenced-entity view mode, reused for both the
manual and the overflow renders) and `link`. `settingsSummary()` appends *"Minimum items: N"* and, when
set, *"Related by: …"*.

Config schema: `field.formatter.settings.entity_reference_overflow` in
`config/schema/entity_reference_overflow.schema.yml` — `min_items` (integer), `sort_field` (string),
`ref_fields` (sequence of strings).

## Render flow (`viewElements()`)

1. `$element = parent::viewElements($items, $langcode)` — renders the manually-referenced entities using
   core's rendered-entity formatter.
2. `$items_needed = calcItemsNeeded($items->count())` = `min_items - count`. If `<= 0`, return `$element`
   unchanged (no overflow needed).
3. Read field settings: `target_type` (`getFieldSetting('target_type')`) and `target_bundles`
   (`getFieldSetting('handler_settings')['target_bundles'] ?? []`).
4. `$exclude_ids = getExclusionIds($items->referencedEntities())` — the ids already referenced.
5. `relatedItemQuery(...)->execute()` returns the fallback ids.
6. `loadMultiple($related_ids)` → `getRelatedRenders()` builds a render array per entity with
   `entityTypeManager->getViewBuilder($type)->view($entity, $view_mode)`.
7. `array_merge($element, $related_renders)` — overflow renders appended after the manual ones.

## The overflow query (`relatedItemQuery()`)

Entity query on `target_entity_type`'s storage:

- `condition('type', $bundles, 'IN')` — restrict to the field's target bundles.
- `condition('status', 1)` — published only.
- `sort($sort_field, 'DESC')`, `range(0, $items_needed)` — newest first, only the shortfall.
- `condition($id_key, $exclude_ids, 'NOT IN')` when there are ids to exclude.
- If `target_entity_type === host->getEntityTypeId()`, `condition($id_key, host->id(), '<>')` — never
  return the host itself.
- For each configured `ref_fields` name: if the host's field is non-empty, collect its `target_id`s and
  `condition($field_name, $ids, 'IN')` — the fallback must share at least one of the host's values in that
  reference field. (`id_key` comes from `getEntityIdKey()`, which reads the target type's `id` key.)

## Notes / caveats

- The `type` condition assumes the target entity type has a `type` (bundle) column; it targets bundleable
  content entities such as nodes and paragraphs (the documented use cases).
- `min_items` is a free textfield with no numeric validation; a non-integer value is compared arithmetically
  in `calcItemsNeeded()`. This is an admin-only display setting.
- Overflow items are ordered strictly by `sort_field` DESC and appended after the curated items; there is no
  interleaving or relevance ranking beyond the shared-field `IN` constraints.
