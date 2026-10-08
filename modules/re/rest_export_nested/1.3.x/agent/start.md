# REST Export Nested — agent index

Adds one Views display, **"REST export nested"** (plugin id `rest_export_nested`, extends core
`RestExport`), that renders like a REST Export feed but **decodes any field whose value is a
JSON string into real nested JSON** in the output. No settings page — configured in the Views
UI. Requires `rest` + `views`.

- **Add and configure the display, the Views Field View recipe, raw output, JSON decoding
  behaviour** → [configure/nested-display.md](configure/nested-display.md)

Key facts:
- Display id `rest_export_nested`; adds an `auth` option (authentication providers) like core
  REST Export.
- `render()` renders via the serializer style, then for every row field runs `json_decode()`
  (and an HTML-entity-decoded fallback); parseable strings become nested structures; the
  literal `"null"` becomes real `null`.
- Typical use: parent "REST export nested" display + **Views Field View** field pointing at a
  child "REST export"/"REST export nested" display to embed children as nested JSON.
