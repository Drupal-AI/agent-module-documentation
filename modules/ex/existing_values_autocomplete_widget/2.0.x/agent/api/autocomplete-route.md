# Autocomplete route & controller

The widget wires each field element to this route; you normally never call it directly, but
its parameters and filtering define what suggestions appear.

## Route

`existing_values_autocomplete_widget.autocomplete` (in `*.routing.yml`):

| Key | Value |
| --- | --- |
| path | `/existing-values/autocomplete/{entity_type_id}/{bundle}/{field_name}` |
| controller | `AutocompleteController::handleAutocomplete` |
| `_format` | `json` |
| `_permission` | `access content` |
| param patterns | `entity_type_id`, `bundle`, `field_name` each `[a-z_]+` |

The typed text is passed as the `?q=` query string. Response is a JSON array of
`{"value": "...", "label": "..."}` objects (both equal to the stored value).

## Controller

`Drupal\existing_values_autocomplete_widget\Controller\AutocompleteController::handleAutocomplete()`.
Injected services: `entity_type.manager`, `database`, `entity_field.manager`,
`entity_display.repository`.

Flow:

1. Load the form-display component for `{entity_type_id}/{bundle}` and read `field_name`. If its
   widget `type` is not `existing_autocomplete_field_widget`, return `[]` immediately. This is the
   gate that makes only fields deliberately configured with this widget queryable.
2. Read `?q=`; if empty, return `[]`. Otherwise `Tags::explode()` the input, take the last token,
   and `mb_strtolower()` it (matching is case-insensitive).
3. Resolve the storage table and value column from the entity type's table mapping
   (`getTableMapping()->getFieldTableName($field_name)` and
   `getFieldColumnName($field_storage_definition, 'value')`), using
   `entity_field.manager` for the storage definition.
4. Build a `database->select()` on that field table:
   - `MIN(f.entity_id)` as `entity_id` (one representative entity per distinct value),
   - the value column as `value`,
   - `condition(<column>, $query->escapeLike($typed_string) . '%', 'LIKE')` — prefix match,
   - `range(0, (int) suggestions_count)`, `distinct(TRUE)`, `groupBy(<column>)`.
5. For each row, load the representative entity and include the value only if
   `$entity->access('view')` **and** `$entity->get($field_name)->access('view')` both return
   TRUE for the current user. Results are keyed by value to stay unique, then returned via
   `array_values()`.

Notes for integrators:
- Matching is a case-insensitive prefix (`LIKE 'typed%'`); the returned casing is that of the
  first stored row for the value.
- The query is scoped to the **entity type**, not the bundle — `{bundle}` is used only to look
  up the form display. A field shared across bundles of the same entity type can therefore
  surface values entered on sibling bundles (each still filtered by the per-entity view checks
  above).
- Suggestion count comes from the widget's `suggestions_count` setting (default 15).
