<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Normalizers — view-mode entity serialization

All classes are `Drupal\entity_view_mode_normalize\Normalizer\*`, registered as `normalizer`-tagged services
(`entity_view_mode_normalize.services.yml`). They fire on core serialization formats (`json`, `xml`, `hal_json`,
etc. — anything the parent `checkFormat()` accepts). You do not call them; enabling the module and selecting a
view mode activates them. Higher `priority` wins over core.

## View-mode selection (SimpleEntityNormalizer, priority 10, any EntityInterface)
Order of precedence for the view mode:
1. `$context['field']['settings']['view_mode']` — set by a Views row plugin or a referencing field's display.
2. `?_view_mode=<machine_name>` request query parameter.
Then it loads the view display `{entity_type}.{bundle}.{view_mode}`. If that display is missing it retries
`default`; if that is also missing it delegates to core `EntityNormalizer` (raw output).

Output = the fields in the view display's **`content` region only** (i.e. fields visible in that view mode),
in display order, empty fields skipped. Each field is serialized with the per-field-type normalizers below, and
`$context['cardinality']` is set from the field's storage cardinality so single-value fields collapse to a
scalar (see cardinality note). Non-content/hidden fields, and entity keys not in the display, are omitted.

## Per-field-type normalizers
Each sets output shape by field type / configured formatter (the formatter id arrives as
`$context['field']['type']`).

- **SimpleTypedDataNormalizer** (priority 10, `TypedDataInterface`) — default field handler when a `view_mode`
  is in context. Renders each item with `$item->view($view_mode)` and returns the first of:
  `#text` / `#markup` / `#context['value']` / `{url, title}` (from `#url`+`#title`) / `vote['#values']`.
  Falls back to raw core `TypedDataNormalizer` output when no view mode / nothing rendered.

- **EntityReferenceFieldItemListNormalizer** (priority 11, `EntityReferenceFieldItemList`) — branch on the
  configured formatter type:
  - `entity_reference_entity_id` → array of `$entity->id()`.
  - `entity_reference_label` → array of `$entity->label()`.
  - `entity_reference_entity_view` → recurse: normalize each referenced entity (full view-mode serialization).
  - `author` → recurse with view mode forced to `teaser_normalize`.
  - anything else → `$item->view($view_mode)` per item, emitting `#plain_text` or `{title, url}`; if that yields
    nothing, recurse into the referenced entities.
  Referenced entities are switched to the current-language translation before serializing.

- **EntityReferenceRevisionsFieldItemListNormalizer** (priority 11) — for
  `entity_reference_revisions` fields (Paragraphs). Recursively normalizes the referenced (translated) entities.
  Needs the `entity_reference_revisions` module present.

- **FileFieldItemListNormalizer** (priority 12, `FileFieldItemList`) — renders via the view mode; if empty,
  normalizes the referenced `File` entities.

- **FileEntityNormalizer** (priority 12, `FileInterface`) — serializes all File fields except `uid`, then adds
  `url` (relative, via `file_url_generator->transformRelative()`) and `absolute_url` (absolute).

- **SelectListFieldItemListNormalizer** (priority 13) — for `list_float`, `list_integer`, `list_string`,
  `address_country`. Returns `{selected: <value|array>, options: <allowed_values>}`. For `address_country`,
  `options` is the full country list from `@country_manager`. Useful to rebuild a select widget client-side.

## Cardinality (CardinalityItemTrait)
When `$context['cardinality'] == 1`, a one-item result is unwrapped: `[['value' => x]]` → `x`, or `[x]` → `x`.
Empty → `null`. Multi/unlimited cardinality stays an array.

## Behavioral notes
- `?_view_mode=` lets the caller pick the serialized view mode on single-entity REST GETs; via Views the row
  option supplies it instead and takes precedence.
- Output is limited to the fields in the selected view mode's display content region. Whichever route/resource
  serves the entity supplies both the entity and the serialization context; on core's `/entity/...` REST GET
  routes that layer (`EntityResource`, `_entity_access`) determines which fields reach the normalizer, so the
  serialized shape depends on both the view mode and the calling route.
- `$context['bundle']` is set to the entity type id (not the bundle) inside `SimpleEntityNormalizer` — a known
  quirk; downstream code should not rely on it.
