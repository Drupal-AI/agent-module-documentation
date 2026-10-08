<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Serialization mechanism — EntityJsonBuilder

Service `entity_display_json.builder` = `src/EntityJsonBuilder.php`
(`EntityJsonBuilderInterface`). Dependencies: `entity_display.repository`, `path_alias.manager`,
`module_handler`, `request_stack`, the extractor manager, and `entity_display_json.view_serializer`.
Public API:

```php
public function serialize(EntityInterface $entity, string $langcode = 'default',
  string $display_id = 'default', ?RefinableCacheableDependencyInterface $cacheability = NULL): array;
```

`serialize()` owns per-build state on the outermost (depth 0) call — the cacheability collector, the
recursion stack, and depth — then delegates to `doSerialize()` and resets state in a `finally`.
Nested (recursive) calls reuse the same collector so child cache metadata bubbles up.

## doSerialize() flow (`EntityJsonBuilder::doSerialize`)

1. Resolve `basePath` from the current request scheme+host. If not a `view` and the entity has the
   requested translation, switch to it.
2. **Entity access:** `$access = $entity->access('view', NULL, TRUE)`; adds `$access` and the entity
   as cacheable dependencies. If `!$access->isAllowed()` and the type is not `view`, returns `[]`
   (access-denied entities produce no field data).
3. Base payload: `entityType`, `bundle`, `uuid`, `id`, `title` (`$entity->label()`), `display_id`.
   For `file` entities also `file_url`/`file_name`/`file_size`/`file_mime`. For entities with a
   `canonical` link template, adds `path_alias` (basePath + alias of the internal path).
4. **Cycle/depth guard:** stack key `entityType:id`; if already on the stack or `depth >= MAX_DEPTH`
   (20), returns a metadata-only stub with `_stub = TRUE` and `_stub_reason` = `cycle` | `depth`
   (still passed through `hook_entity_display_json_entity_alter`).
5. `view` entities → `serializeViewEntity()` (below). Otherwise get the view display
   (`displayRepository->getViewDisplay($entity_type, $bundle, $display_id)`) and iterate its
   `getComponents()`:
   - skip components with no `label` key (i.e. hidden fields) and fields the entity lacks;
   - **per-field access:** `$items->access('view', NULL, TRUE)` (added to cacheability); skip if not
     allowed;
   - build a `FieldExtractionContext` and ask `FieldValueExtractorManager::findExtractor()` for the
     first matching plugin; its `extract()` value (unless the `NONE` sentinel) is run through
     `hook_entity_display_json_field_alter` then stored under the field name;
   - for `above`/`inline` label displays, records `labels[$field][display|text]`.
6. `applyFieldGroups()` reshapes output into nested groups from the display's
   `third_party_settings.field_group` (parent/child nesting, `specs` = label/weight/format_type).
7. `alterEntity()` fires `hook_entity_display_json_entity_alter`.

## Views (`serializeViewEntity` + ViewResultsSerializer)

For a `view` entity the builder passes a row processor (each row → `serialize($row, $langcode,
$view_mode)`, `full`→`default`) to `ViewResultsSerializer::serializeView()`
(`src/ViewResultsSerializer.php`, service `entity_display_json.view_serializer`). That service:

- returns `[]` if the `views` module is absent or the view can't load;
- adds the view config entity as a cacheable dependency; applies `?page=` to the pager;
- **enforces the view display's own access plugin** via `$view->access($display_id)` (returns `[]`
  on deny) before executing;
- for `entity:node` / `fields` row plugins, runs each `$row->_entity` through the row processor;
  merges the executed view's `#cache` metadata; returns `results`, `total_rows`, and (when
  `include_meta`) `exposed_filters` and `pager`.

## Translations

`getAvailableTranslations()` returns `langcode → canonical URL` for each translation, or `[]` for
entities without a `canonical` link template (e.g. paragraphs).

## Per-field third-party settings & config schema

Set on a display component under `third_party_settings.entity_display_json`; schema in
`schema/entity_display_json.schema.yml` (`field.formatter.third_party.entity_display_json`):

- `multi_value` (bool) — force array (every delta) or scalar (delta 0) output regardless of storage
  cardinality; default follows cardinality (`ScalarValueExtractor`).
- `render` (bool) — run formatted-text values through `check_markup` (their text format) instead of
  emitting raw stored markup (`ScalarValueExtractor` / `TextExtractor`).

## Payload contract

The invariant JSON shape ships as JSON Schema at `schema/entity-payload.schema.json` — feed it to
json-schema-to-typescript for front-end types.
