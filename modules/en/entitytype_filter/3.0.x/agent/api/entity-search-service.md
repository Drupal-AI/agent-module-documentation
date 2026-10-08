<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EntitySearchService helper API

Service id `entitytype_filter.search_service` → `Drupal\entitytype_filter\EntitySearchService`
(`src/EntitySearchService.php`, `entitytype_filter.services.yml`). Constructor deps: `entity_type.manager`
and `plugin.manager.field.field_type` (both core). Both forms inject it. It holds no state and reads only
live definitions.

## `getBundleConfigEntityTypes($include_definition_data = FALSE): array`

Iterates `entityTypeManager->getDefinitions()` and keeps every entity type whose definition has
`group == 'configuration'` **and** a non-empty `bundle_of` — i.e. the config entity types that define
bundles (e.g. `node_type`, `block_content_type`, `paragraphs_type`, `media_type`, ECK types).

- `FALSE` (default): returns a flat array of those entity type ids.
- `TRUE`: returns a map keyed by entity type id, each value = `['label', 'label_key', 'path',
  'bundle_of']`. `path` is normally the definition's `edit-form` link; a small `$map` special-cases two
  providers — `taxonomy` uses the `overview-form` link, and `eck` uses `collection` + `/{entity_type_id}`.
  These paths are what the forms turn into Field-UI links.

## `getGroupedFieldTypeOptions(): array`

Returns field-type labels grouped by category:
`fieldTypePluginManager->getGroupedDefinitions(fieldTypePluginManager->getUiDefinitions())`, reduced to
`[$category][$name] => label`. Used to render/resolve the field-type dropdown and column.

## `recursiveSearchKeyMap($needle, $haystack)`

Recursively walks the grouped field-type array to find `$needle` (a field type machine name) and return
its human label; returns `FALSE` when not found. Callers fall back to the raw `$field->getType()` when it
returns falsey (`recursiveSearchKeyMap(...) ?: $field->getType()`).

## Notes

- The service has no external calls, no SQL, and no user input — it only reflects core definitions.
- Reference-field labels: the forms additionally derive a friendlier type label from the field's
  `handler` setting (`explode(':', $handler)[1]`, title-cased) when present, before falling back to
  `recursiveSearchKeyMap()`. That logic lives in the forms, not this service.
