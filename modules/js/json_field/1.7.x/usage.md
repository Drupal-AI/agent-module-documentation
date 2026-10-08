<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON Field adds three field types (`json`, `json_native`, `json_native_binary`) that store arbitrary JSON documents on any fieldable entity, plus a textarea widget, two formatters, a "valid JSON" validation constraint and Views/REST integration.

---

The module registers a `json_data` field-type category containing **JSON (text)** (`json`, a varchar/text column whose width is chosen with the `size` storage setting), **JSON (raw)** (`json_native`, a native `json` column on MySQL/PostgreSQL, `LONGTEXT` on MariaDB, `text` on SQLite) and **JSONB/JSON (raw)** (`json_native_binary`, `jsonb` on PostgreSQL, `json` on MySQL). All three share the default widget `json_textarea` (a subclass of core's `string_textarea`) and the default formatter `json`, and all three carry the `valid_json` constraint, which decodes the submitted string through the `serializer` service and reports the `json_decode` error as a validation violation. Two formatters ship: `json` ("Plain text") renders the raw string inside `<pre class="json-field"><code>` via the `json_text` render element and optionally attaches the jQuery JSONView library (`attach_library` setting, default TRUE); `pretty` decodes the value and renders nested `<ul>`/`<dl>` markup via the `json_pretty` render element. Views integration is provided through `hook_field_views_data()` and the `json_field.views` service, which adds an extra `<field>_json_value` column handled by the `json_data` Views field plugin so a REST Export display emits decoded JSON instead of an escaped string. A `serializer.normalizer.json_item.native` normalizer does the same for `NativeJsonItem` in serialization/HAL output. `hook_requirements()` (via the `json_field.requirements` service) warns when `/libraries/jquery-jsonview/dist/*` is missing or the database version is below the JSON-capable minimum (MySQL 5.7.8, MariaDB 10.2.7, PostgreSQL 9.2, SQLite 3.26). The improved editing UI is **not** in this module — it lives in the bundled `json_field_widget` submodule.

---

- Store a third-party API payload verbatim on a node without modelling it as Drupal fields.
- Keep a product's raw ERP record alongside the Drupal entity for later reconciliation.
- Add a `settings`-style JSON blob to a config-ish content entity (block content, media, term).
- Persist webhook bodies received from an external system on a queue/log entity.
- Attach GeoJSON geometry to a place node and read it back in a map component.
- Store per-node chart data that a JS front end fetches through a REST Export view.
- Save a form-builder schema (fields, labels, validation) as one JSON document.
- Keep AI/LLM structured output (tool calls, extracted entities) attached to the source content.
- Record an import's original row so a re-import can diff against it.
- Give editors a raw JSON field for feature flags or A/B test variants per page.
- Use `json_native` on PostgreSQL/MySQL so the database can run native JSON path queries against the column.
- Use `json_native_binary` on PostgreSQL to get an indexable `jsonb` column.
- Use `json` (text) when the site must stay portable across SQLite/MariaDB and a plain text column is safer.
- Cap the storage column with the `size` setting (255 varchar / 16 KB / 4 MB / 1 GB) to control table growth.
- Validate editor-entered JSON on save and reject malformed documents with the `valid_json` constraint.
- Render the stored document as a readable, collapsible tree on the front end with the JSONView library.
- Render the document as nested HTML lists with the `pretty` formatter when no JS library is available.
- Turn the JSONView library off per display (`attach_library: false`) on pages where the JS is unwanted.
- Expose the decoded JSON in a Views REST Export feed using the "(data)" field added by the module.
- Return raw JSON (not an escaped string) from JSON:API by pairing the field with JSON:API Extras' "JSON Field" enhancer.
- Map an incoming Feeds source column onto a JSON field with the bundled `json_field` Feeds target.
- Show JSON differences between node revisions when the Diff module is installed.
- Migrate legacy serialized blobs into a typed, validated JSON field.
- Prototype a data structure quickly before promoting it into real Drupal fields.
- Give a decoupled front end one field to read instead of a dozen entity references.
- Store multi-language or multi-variant copy fragments as a single JSON document per node.
