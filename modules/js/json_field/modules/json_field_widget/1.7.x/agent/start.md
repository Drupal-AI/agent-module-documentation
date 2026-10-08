<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON Field Widget — agent index

Submodule of [`json_field`](../../../../1.7.x/agent/start.md). Adds **one** field widget
plugin, `json_editor`, that swaps the plain textarea for the josdejong JSON Editor and can
validate the value against a JSON Schema on save. No settings form, no `configure` route, no
permissions, no Drush, no services, no plugin types.

- **Widget settings (`mode`, `modes`, `schema`, `schema_validate`), how to set them, the
  jsoneditor library requirement and schema validation** →
  [configure/json-editor-widget.md](configure/json-editor-widget.md)

Quick facts:

| Thing | Value |
|---|---|
| Widget id / label | `json_editor` — "JSON-specific WYSIWYG editor" |
| Field types | `json`, `json_native`, `json_native_binary` |
| Settings keys | `mode`, `modes`, `schema`, `schema_validate` (schema: `field.widget.settings.json_editor`) |
| Default settings | `mode: code`, `modes: {text: text}`, `schema: ''`, `schema_validate: false` |
| Modes | `text`, `code` (ACE), `tree`, `form`, `view` |
| JS library | `json_field_widget/jsoneditor` → `/libraries/jsoneditor/dist/jsoneditor.min.js` (max v6.0.0) |
| PHP library for validation | `swaggest/json-schema` (Composer `suggest`, **not** installed by default) |
| Requirement hook | `json_field_widget_requirements()` — REQUIREMENT_ERROR when the JS library is absent |
