<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the usage count is computed

## Field registration — `hook_views_data_alter()`

`entity_usage_views_field_views_data_alter()` (in the `.module`) iterates all entity type
definitions, filters to:

1. types listed in `entity_usage.settings:track_enabled_target_entity_types` (if that config is
   non-empty), then
2. types that have a `views_data` handler.

For each, it looks up the entity's Views base table (`getViewsTableForEntityType()`) and adds a
`field` named `entity_usage_views_field` with an `additional fields` entry for the entity's id
key. There is **no** `sort`/`filter`/`argument` — only a field handler.

## The handler — `EntityUsageViewsField` (extends `NumericField`)

Plugin id: `entity_usage_views_field` (`EntityUsageViewsField::PLUGIN_ID`). Key methods:

- `query()` — deliberately does **not** call the parent; it only calls `ensureMyTable()` and
  `addAdditionalFields()`. The value is virtual, not selected from the DB by the main query.
- `getValue()` — per result row:
  1. `SELECT source_type, source_id, source_id_string, source_vid FROM entity_usage`
     `WHERE target_id = <row id> AND target_type = <configuration['entity_type']>`.
  2. Groups source rows by `source_type` → `source_id` → list of `source_vid`.
  3. Loads the **default revision** of each source entity (`loadMultiple`).
  4. Increments the count when the loaded default revision's id is in that source's recorded
     `source_vid` list (non-revisionable entities are counted once). This is the revision-aware
     step that a SQL join could not do.
- `renderAsLink()` — overrides the parent to inject `class="use-ajax"`,
  `data-dialog-type="modal"`, `data-dialog-options` `{"width":700}` so a rewritten link opens
  the Entity Usage report in a modal.

## Consequence: not sortable / not filterable

Because the number is produced in PHP after the main query runs (to stay revision-aware), it is
absent from the SQL result set. The class docblock states this explicitly: "this field is not
sortable." There is no filter or sort handler registered, so you cannot order or filter a view
by usage count.

## Cache invalidation — `EuvfCacheTagInvalidator`

A `cache_tags_invalidator`-tagged service watches for the `config:entity_usage.settings` tag; on
change it invalidates `views_data`, forcing the field list to be rebuilt so the field
appears/disappears when tracked target types change.
