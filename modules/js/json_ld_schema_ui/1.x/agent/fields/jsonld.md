<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `jsonld` field — type, widget, computed value, head formatter

This is the runtime core of the module: how the per-entity JSON-LD is built and printed.
Files: `src/Plugin/Field/FieldType/JsonLdItem.php`, `.../FieldWidget/JsonLdDefaultWidget.php`,
`.../FieldFormatter/JsonLdHeadFormatter.php`, `src/TypedData/JsonLdProcessed.php`,
`src/TypedData/SchemaBundle.php`, `src/Plugin/DataType/SchemaOverrides.php`.

## Field type `jsonld` (`JsonLdItem`)

- `@FieldType(id = "jsonld", default_widget = "jsonld_default", default_formatter = "jsonld_head",
  no_ui = TRUE)` — not selectable in Field UI; the module installs it programmatically.
- Storage: one `blob` column **`overrides`** (`serialize => TRUE`, `not null`). Holds only the
  properties an editor explicitly overrode, keyed `[schema_type][property|path]`.
- Property definitions:
  - `overrides` — data type `schema_overrides` (`SchemaOverrides`, a `Map`).
  - `schema_bundle` (computed, `SchemaBundle`) — returns `"<entity_type>.<bundle>"`.
  - `processed` (computed, **`JsonLdProcessed`**, `internal = FALSE`) — the finished JSON-LD string.
    Settings `schema_bundle_source = schema_bundle`, `schema_overrides = overrides`.
- `isEmpty()` returns **FALSE** always → the field is treated as always-present so defaults still
  emit even with no overrides. `onChange()` nulls the cached `processed` value to force recompute.
- The field is installed/uninstalled automatically — see [../config/bundle-schema.md](../config/bundle-schema.md).

## Widget `jsonld_default` (`JsonLdDefaultWidget`)

- Renders a *details → table* per configured schema type, one row per **overridable** property
  (`ContentSchemaSettings::getOverridableProperties()` — properties with `allow_override = TRUE`,
  plus nested reference properties). Each row: a `textfield` (or `select` when the property has an
  `enum_type`) value + an "Override" checkbox; the value input is `#states`-enabled only when the
  checkbox is ticked.
- The whole widget is gated by `#access => $items->access('edit')`. If Token is installed a
  `token_tree_link` is shown. Bundles with no mapping render nothing.
- `massageFormValues()` keeps only rows whose "Override" box is checked and writes them to
  `overrides[schema_type][property|path] = value`.

## Computed value `JsonLdProcessed::getValue()` — build path

1. Loads all `schema_content_settings` config entities for the item's `schema_bundle`
   (`loadByProperties(['bundle' => ...])`). None → encodes `[]`.
2. Sets token data to `[<entity_type_id> => $entity]`, langcode from the item.
3. `context_uri` = `json_ld_schema_ui.settings:schema.base_uri` (default `https://schema.org`),
   trailing-slash-normalized. Builds `['@context' => $context_uri, '@graph' => []]`.
4. For each config entity: `['@type' => schema_type] + processProperties(getSchemaProperties(),
   overrides[schema_type])`.
5. `processProperties()` walks the property tree. Leaf value = the override if set, else the
   configured `default_value`; it is passed through **`\Drupal::token()->replace($value, $tokenData,
   $tokenOptions, $bubbleableMetadata)`**. If the property has `allow_multiple` and the replaced
   string contains a comma, it is split on `,` and trimmed into an array. Reference properties recurse.
6. If `@graph` has exactly one node it is flattened to a single top-level type.
7. **`encode()` = `json_encode($value, JSON_UNESCAPED_UNICODE)`** → cached in `$value`.
8. `JsonLdProcessed` is `CacheableDependencyInterface`; token replacement bubbles cache metadata,
   plus the `schema_content_settings` list cache tags (added in `createInstance()`).

Note: token replacement means any entity/field token an editor controls (e.g. `[node:title]`,
`[node:body]`) can appear in the encoded value. The values are **not** HTML-escaped at the JSON
layer, and `json_encode` here does not use `JSON_HEX_TAG`/`JSON_HEX_AMP`; escaping of the final
markup happens in the render layer below.

## Formatter `jsonld_head` (`JsonLdHeadFormatter::viewElements()`) — render path

- Skips new (unsaved) entities. When the item list is empty it seeds `['overrides' => []]` so the
  defaults still render (matching `isEmpty() === FALSE`).
- For each item it attaches to the page head:

  ```php
  $elements['#attached']['html_head'][] = [
    ['#tag' => 'script',
     '#attributes' => ['type' => 'application/ld+json'],
     '#value' => $processed->getValue()],
    "json_ld_<entity_type>_<id>_<field>_<delta>",
  ];
  ```

- It does **not** print into the entity's own markup — it uses `#attached[html_head]`, so the JSON
  ends up in `<head>` regardless of view mode/theme. Cache metadata from `$processed` is applied to
  the element.
- Because the head item has no `#type`, core's `HtmlResponseAttachmentsProcessor::processHtmlHead()`
  defaults it to `html_tag`. In `HtmlTag::preRenderHtmlTag()` a plain-string `#value` (which is what
  `getValue()` returns) is wrapped as `Markup::create(Xss::filterAdmin($element['#value']))` — i.e.
  core XSS-admin-filters the script body before output. Practical effect: any stray HTML/`</script>`
  in a token-replaced value is stripped/encoded by core at render time rather than emitted raw.

## Operating it

- You never add this field by hand; configure a bundle mapping (see
  [../config/bundle-schema.md](../config/bundle-schema.md)) and the `jsonld_schema` field appears.
- To emit output, ensure the `jsonld_schema` field's display uses the `jsonld_head` formatter (its
  default) on the view mode you render (`hook_entity_bundle_field_info` sets a hidden-label view
  display option by default).
- Values support tokens; enable "Allow multiple values" on a property to turn a comma list into a
  JSON array.
