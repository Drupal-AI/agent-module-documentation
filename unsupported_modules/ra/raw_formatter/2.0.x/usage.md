<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Raw formatter adds a "Raw Value" field formatter (plugin id `raw`) for Metatag fields that decodes the field's JSON value, runs token replacement, and prints the result unescaped through a Twig template — intended for exposing raw values in Services / REST Export views.

---

Raw formatter provides a single field formatter, `RawValueFormatter` (plugin id `raw`, label "Raw Value"), that is registered only for the `metatag` field type. When a Metatag field is displayed with this formatter, `viewElements()` reads each item's `value`, `json_decode()`s it into key/value pairs, and for each value runs `token->replace()` (with the host entity as token context) so entity tokens resolve. It then strips HTML tags from each value with `preg_replace('/<[^>]*>/', '', …)`, re-encodes the whole map with `json_encode()`, and hands it to the `raw_formatter` theme hook. The template `raw-formatter.html.twig` outputs the value with the Twig `raw` filter (`{{ raw_value|raw }}`), i.e. without auto-escaping. The module has no settings form, no configuration UI, no permissions, and no Drush commands — you enable it and select the formatter on a Metatag field's display. Its purpose is to surface the underlying raw field value (notably in REST Export / Services responses) rather than a themed metatag render. Because output is emitted with `|raw`, treat the displayed field value as trusted: only apply this formatter to fields whose value is controlled by trusted editors, since the regex tag-strip is not a robust sanitizer and unescaped output can carry markup/scripts into the page.

---

- Add a "Raw Value" formatter option to a Metatag field's display.
- Expose a Metatag field's stored value in a REST Export view.
- Return raw field data through a Services / REST endpoint.
- Render a Metatag field as its decoded JSON key/value payload.
- Resolve entity tokens inside a Metatag field value before output.
- Include raw metatag values in a headless/decoupled API response.
- Display a field's underlying value instead of a themed meta-tag render.
- Feed raw metatag content to a front-end that does its own escaping.
- Build a view that outputs decoded metatag key/value pairs as JSON.
- Provide raw field output for a custom Services integration.
- Override `raw-formatter.html.twig` to change how the raw value is wrapped.
- Use the `raw_formatter` theme hook in a custom theme.
- Substitute `[node:...]` style tokens into a metatag value on display.
- Pipe raw metatag values into a data export pipeline.
- Inspect a Metatag field's raw JSON structure on an entity display.
- Serve pre-computed metatag values to a JavaScript app.
- Configure the formatter per view mode on a Metatag field.
- Show token-replaced metatag content without full HTML meta rendering.
- Only apply it to fields set by trusted editors (output is unescaped).
- Avoid selecting this formatter for values authored by untrusted users.
- Combine with Metatag module to store the field that this formatter displays.
- Enable raw value passthrough for a specific content type's metatag field.
