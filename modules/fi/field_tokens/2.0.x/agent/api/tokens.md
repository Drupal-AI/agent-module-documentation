# Field Tokens — token grammar & internals

All tokens are registered dynamically in `field_tokens.tokens.inc` and resolved in
`field_tokens_tokens()` (`hook_tokens`). No config; enable the module and the tokens appear on every
fieldable entity token type (node, taxonomy_term, user, media, paragraph, file, …).

## 1. Formatted field tokens

```
[<entity>:<field>-formatted:DELTA(S):FORMATTER:SETTING-VALUE:SETTING-VALUE:…]
```

- Renders the selected field items through a field **formatter** and returns Markup.
- `FORMATTER` = a formatter machine name valid for the field's type. **Omit it** (leave the segment
  empty) to use the field type's default formatter, e.g. `[node:field_image-formatted:image]` or
  `[node:field_image-formatted:0:image:image_style-thumbnail]`.
- `SETTING-VALUE` pairs become formatter settings; they are merged over the formatter's defaults
  (`array_replace_recursive`). A key with no `-value` is treated as a valueless flag (`NULL`).
- **Nested/array settings** use dot notation in the key: `image_loading.attribute-eager`,
  `trim_options.text-…` (parsed by `field_tokens_parse_formatter_settings()`; dots are safe because no
  core/contrib formatter uses dots in setting keys).
- Rendering: the module clones the entity, sets the selected item values, injects the formatter+settings
  into a cloned `default` view display, and renders each child with `renderer->renderInIsolation()`.

Examples:

| Token | Effect |
|---|---|
| `[node:field_image-formatted:0:image:image_style-thumbnail]` | First image via `image` formatter, thumbnail style |
| `[node:field_image-formatted:*:image]` | All images |
| `[paragraph:field_body-formatted:0:smart_trim:trim_length-200:trim_options.text-text]` | Smart Trim with flat + nested settings |

## 2. Field property tokens

```
[<entity>:<field>-property:DELTA(S):PROPERTY:KEY:KEY:…]
```

- Returns a raw field **property** value (`value`, `target_id`, `alt`, `uri`, …).
- For an **entity-reference** property, extra segments chain into the referenced entity's tokens:
  `[node:field_author-property:0:entity:name]`.
- For an **array-valued** property, extra colon segments are used as successive array keys (integer or
  string), e.g. `[node:field_table-property:0:value:2:1]` (row 2, col 1). Scalar leaves are cast to
  string; if the leaf is still an array, nothing is output.
- A single resolved value is returned as a plain string; multiple values are joined with `", "` as Markup.

## 3. Delta specification (the `DELTA(S)` segment)

| Form | Example | Meaning |
|---|---|---|
| single | `0` | one item |
| comma list | `0,2,4` | specific items (all must exist, else token skipped) |
| range | `0-3` | 0,1,2,3 |
| mixed | `0-2,4,6-8` | ranges + singles |
| wildcard | `*` | all items |
| omitted | _(none)_ | all items (first segment is then the formatter/property) |

Empty items are dropped individually (so `0,2` still resolves the non-empty ones).

## 4. Entity `delta` token

`[<entity>:delta]` (e.g. `[file:delta]`, `[node:delta]`) returns the zero-based position of the entity
within its parent multi-value field. It **only** resolves when the calling code passes the delta in
token data — `isset()` accepts delta `0` but rejects a missing delta (leaving the token unreplaced
rather than emitting empty string). Suppliers include:

- [filefield_paths] passing each file's position for filename patterns: `[node:title]-[file:delta].png`.
- This module's own property chaining, which forwards `_field_tokens_deltas` to chained entities.
- Custom Formatters (see below), which injects the current item's delta automatically.

## 5. Custom Formatters integration

`field_tokens_custom_formatters_token_data_alter()` (in `field_tokens.module`) enriches the token data
for the [Custom Formatters](https://www.drupal.org/project/custom_formatters) HTML + Token engine, so
inside such a formatter you can use tokens without entity-level chaining, e.g.
`[formatted_field-image:image:image_style-thumbnail]`, `[field_property:alt]`, and `[file:delta]`.

## Notes / edge cases (from the source)

- Token replacement is language-aware: the entity is loaded in the active/`langcode` translation before
  fields are read.
- Requested-but-nonexistent deltas in a comma/range list abort *that* token (returns nothing).
- Reference-property chaining only forwards a `delta` when one is actually known for the item (never the
  array index), so positions are never misreported.
