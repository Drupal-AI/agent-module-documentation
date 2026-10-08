Field Tokens adds two families of tokens to Drupal's Token system — **formatted field** tokens that render a field through any field formatter, and **field property** tokens that read raw field properties — plus a `delta` token for an entity's position in a multi-value field.

---

The module implements `hook_token_info()`/`hook_token_info_alter()` to register, for every field type
and formatter, `[<entity>:<field>-formatted:…]` and `[<entity>:<field>-property:…]` tokens, and a
`delta` token on every entity token type. `hook_tokens()` does the work: for **formatted** tokens it
selects field items by a delta spec, injects the named formatter (or the field's default) and any
`SETTING-VALUE` pairs into a cloned view display, and renders the result in isolation to Markup; for
**property** tokens it reads a named property (e.g. `value`, `target_id`, `alt`), chaining into the
referenced entity's tokens for entity-reference properties and traversing array values via extra
colon-separated keys. The token grammar is
`[PREFIX:DELTA(S):FORMATTER:KEY-VALUE:…]` and `[PREFIX:DELTA(S):PROPERTY:KEY:…]`, where `DELTA(S)` is a
single delta, a comma list (`0,2,4`), a range (`0-3`), a mix (`0-2,4,6-8`), `*`, or omitted (all items).
Formatter settings support dot-notation for nested arrays (`image_loading.attribute-eager`). The `delta`
token only resolves when the calling code supplies the position (e.g. [filefield_paths] for `[file:delta]`
in filename patterns, or the module's own property chaining). It also implements
`hook_custom_formatters_token_data_alter()` so the [Custom Formatters](https://www.drupal.org/project/custom_formatters)
HTML + Token engine can use `[formatted_field-*]` and `[field_property:*]` tokens directly. Requires the
Token module and PHP 8.2+; there is no configuration UI — tokens work as soon as it is enabled.

---

- Render a field's formatted output inside any token-aware text (emails, messages, pathauto patterns, Views).
- Output an image field through an image style, e.g. `[node:field_image-formatted:0:image:image_style-thumbnail]`.
- Render a field with its default formatter without naming one: `[node:field_image-formatted:image]`.
- Read a raw field property such as a target id: `[node:field_ref-property:0:target_id]`.
- Get an image field's alt text: `[node:field_image-property:0:alt]`.
- Render only the first value of a multi-value field (`:0:`).
- Render specific items of a multi-value field with a comma list (`:0,2,4:`).
- Render a contiguous range of items with a range spec (`:0-3:`).
- Render a mix of ranges and single items (`:0-2,4,6-8:`).
- Render all items of a field with the wildcard (`:*:`) or by omitting the delta.
- Pass a formatter setting inline as `SETTING-VALUE` (e.g. `image_style-large`).
- Pass a valueless flag setting by giving the key alone.
- Set a nested/array formatter setting with dot notation (`image_loading.attribute-eager`, `trim_options.text-…`).
- Trim body text inline via Smart Trim's formatter and settings in a token.
- Chain into a referenced entity from a reference property (`[node:field_author-property:0:entity:name]`).
- Traverse an array-valued property (e.g. a Table field cell) with extra keys: `[node:field_table-property:0:value:2:1]`.
- Build per-item filenames with [filefield_paths] using `[file:delta]` (e.g. `[node:title]-[file:delta].png`).
- Get the zero-based position of an entity in its parent multi-value field via `[node:delta]` / `[file:delta]`.
- Use `[formatted_field-image:image:…]` and `[field_property:alt]` directly inside a Custom Formatters HTML + Token formatter.
- Render a formatted field into an outbound email body without writing PHP.
- Produce a comma-separated list of a property across all deltas (e.g. all target ids).
- Feed a formatted or property token into a Pathauto alias pattern.
- Expose derived field output in a Views rewrite/global-text field via tokens.
- Use link, file, entity-reference, or text field properties as tokens anywhere tokens are accepted.
