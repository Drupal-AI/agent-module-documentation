<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FieldValueExtractor plugins & alter hooks

## Plugin type

- Attribute `#[FieldValueExtractor]` (`src/Attribute/FieldValueExtractor.php`), params: `id`,
  `field_types` (string[]), `formatter_types` (string[]), `weight` (int, lower tried first),
  `deriver`.
- Interface `FieldValueExtractorInterface` (`src/FieldValueExtractorInterface.php`):
  `applies(FieldExtractionContext): bool`, `extract(FieldExtractionContext): mixed`. Return the
  `NONE` constant (`'__entity_display_json_none__'`) from `extract()` to skip the field (lets a
  plugin legitimately return NULL as a value).
- Base `FieldValueExtractorBase` (`src/FieldValueExtractorBase.php`): default `applies()` matches the
  definition's `field_types` against `getFieldType()` and `formatter_types` against
  `getFormatterType()`; returns FALSE if neither is set (both empty = generic fallback via override).
- Context `FieldExtractionContext` (`src/FieldExtractionContext.php`, readonly): `entity`,
  `fieldName`, `component` (display component), `langcode`, `displayId`, `basePath`, `cacheability`;
  helpers `getFieldType()`, `getFormatterType()`, `isFieldEmpty()`, `getCardinality()`,
  `isMultiValueField()`.
- Manager `FieldValueExtractorManager` (`src/FieldValueExtractorManager.php`,
  `plugin.manager.entity_display_json.field_value_extractor`): discovers in
  `Plugin/EntityDisplayJson/FieldValueExtractor`, alter hook `entity_display_json_field_value_extractor_info`,
  cache `entity_display_json_field_value_extractors`. `getSortedDefinitions()` sorts by weight asc;
  `findExtractor()` returns the first (memoized, stateless) instance whose `applies()` is TRUE.

## Built-in extractors (`src/Plugin/EntityDisplayJson/FieldValueExtractor/`)

- **`block_field`** (weight -100, field type `block_field`) — `BlockFieldExtractor`. Emits
  `{plugin_id}`; for `views_block:*` parses `view_id`/`display` and serializes rows through
  `ViewResultsSerializer` (`results`, `total_rows`).
- **`media_thumbnail`** (weight -90, formatter `media_thumbnail`) — `MediaThumbnailExtractor`.
  Resolves each media's file through the component's `image_style` → `{image_url: style->buildUrl(uri)}`;
  adds the style, media and file as cacheable dependencies.
- **`entity_reference`** (weight -50, field types `entity_reference`,
  `entity_reference_revisions`, `image`, `file`) — `EntityReferenceExtractor`. Recurses into each
  referenced entity via `builder->serialize()` using the component `settings.view_mode` (fallback
  `field->display_id` else `default`); adds file `uri`, and image `alt/title/width/height` from the
  field item.
- **`link`** (weight -40, field types `link`, `link_separate`) — `LinkExtractor`. Emits
  `[{url, title?}]`; `rewriteUri()` turns `internal:` / `entity:` URIs into absolute URLs on
  `basePath`; drops `title` for paragraph parents.
- **`text_summary_or_trimmed`** (weight -30, formatters `text_summary_or_trimmed`, `text_trimmed`)
  — `TextExtractor`. Mirrors core: prefer manual summary else trim to `settings.trim_length`; in
  `render` mode runs `check_markup` on summary/value instead of trimming.
- **`scalar_value`** (weight 1000, generic fallback) — `ScalarValueExtractor`. Applies to any
  non-empty field whose first item `mainPropertyName() === 'value'`. Output shape follows storage
  cardinality unless the `multi_value` third-party setting overrides it; skips NULL/empty deltas;
  `render` runs `check_markup` per delta.

A test-only extractor (`UppercaseStringExtractor`) ships under `tests/modules/entity_display_json_test`.

## Alter hooks (`entity_display_json.api.php`)

- `hook_entity_display_json_field_alter(mixed &$value, array $context)` — adjust one field's value
  after extraction; set to `FieldValueExtractorInterface::NONE` to drop it. Context: `entity`,
  `field_name`, `component`, `langcode`, `display_id`.
- `hook_entity_display_json_entity_alter(array &$data, array $context)` — reshape the full entity
  payload; inject fields hidden from Manage Display; add computed props. Fires for stubs too — bail
  on `!empty($data['_stub'])`. Context: `entity`, `langcode`, `display_id`.
- `hook_entity_display_json_response_alter(array &$payload, array $context)` — extend the top-level
  HTTP envelope. **Only fires for the `/ejson/{…}` build route**, not direct builder calls.
- `hook_entity_display_json_field_value_extractor_info_alter(array &$definitions)` — reweight or swap
  discovered extractor definitions (e.g. bump `scalar_value` weight).

Implement a custom extractor by placing a `#[FieldValueExtractor]`-attributed class extending
`FieldValueExtractorBase` in your module's `Plugin/EntityDisplayJson/FieldValueExtractor/`; give it a
lower weight than the built-in you want to beat.
