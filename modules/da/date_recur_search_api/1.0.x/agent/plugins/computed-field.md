<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Computed field, tracker & caching

## Computed field `date_recur_date_occurrence`

`src/Plugin/ComputedField/DateOccurrence.php` — a Computed Field plugin (attribute `#[ComputedField(id:
"date_recur_date_occurrence", field_type: "daterange", no_ui: TRUE, attach: ['scope' => 'bundle', 'dynamic' =>
TRUE])]`), extending `computed_field`'s `ComputedFieldBase`.

- **Purpose:** it does not compute anything. It exists so the datasource has a real field to write the single
  occurrence date onto when loading a search item. `computeValue()` returns `[]`.
- **Attachment:** `attachAsBundleField()` loops the bundle's fields and, for every `date_recur` field, creates a
  computed `daterange` field named `<date_recur_field_name>` + `COMPUTED_FIELD_SUFFIX` (`_occurrence`). So a
  field `field_when` gets a companion computed field `field_when_occurrence`.
- **Suffix constant:** `DateOccurrence::COMPUTED_FIELD_SUFFIX = '_occurrence'` — used by the datasource
  (`getComputedFieldName()`) and by the render-cache hook.
- `no_ui: TRUE` hides it from the field UI. A `@todo` notes it cannot yet be limited to Search-API view modes
  only.

Add this `<field>_occurrence` field to the Search API index and use it for sorting, filtering, and display —
never the raw recurring-date field.

## Tracker event subscriber `SearchApiTrackerSubscriber`

`src/EventSubscriber/SearchApiTrackerSubscriber.php`, service
`date_recur_search_api.search_api_tracker_subscriber` (args `@entity_type.manager`, `@database`). Subscribes to
date_recur events (`getSubscribedEvents()`):

- **`DateRecurEvents::FIELD_VALUE_SAVE` → `onFieldValueSave()`** — diffs the entity's existing tracked ids against
  the freshly generated ids and calls `trackItemsDeleted()` / `trackItemsInserted()` / `trackItemsUpdated()` on
  each affected index.
- **`DateRecurEvents::FIELD_ENTITY_DELETE` → `onFieldEntityDelete()`** — `trackItemsDeleted()` for all of the
  entity's existing tracked ids.

Helpers:

- `iterateIndexesForEvent()` resolves the field's datasource id and iterates every index whose
  `isValidDatasource()` matches, computing existing vs current ids.
- `getIndexesForFieldStorageDefinition()` loads all `search_api_index` entities and filters by valid datasource.
- `getFullyQualifiedDatasourcePluginId()` → `date_recur:<entity_type>__<field_name>` (via the deriver's id).
- `getAllTrackedIds()` reads existing tracked ids **directly** from the `search_api_item` table (there is no
  public tracker API to enumerate an entity's tracked ids), scoped by `index_id` and an
  `item_id LIKE '<datasource>/<entity_id>:%'` condition. The query uses the DB API `select()` with bound
  `condition()`s and `escapeLike()` on the entity-scoped prefix. This assumes the default DB-backed tracker.

## Deriver `DateRecurDatasourceDeriver`

`src/Plugin/Deriver/DateRecurDatasourceDeriver.php`. Iterates every fieldable entity type, reads its **active**
field storage definitions (`getActiveFieldStorageDefinitions()` — avoids a circular dependency with Solr's data
type deriver), and for each `date_recur` field produces a derivative keyed
`getDatasourceDerivativeId($entity_type_id, $field_name)` = `<entity_type>__<field_name>`, labelled
"Date occurrences: <entity type> (<field name>)".

## Render caching — `hook_entity_build_defaults_alter()`

`date_recur_search_api.module`: for content entities, for each computed field whose name ends in `_occurrence`
that is **non-empty** (only true inside Search API results, where the datasource set it), the occurrence's
`value` and `end_value` are appended to `$build['#cache']['keys']`. This gives each occurrence render a distinct
render-cache entry, so the same entity displayed for different occurrences does not collide in the cache.
