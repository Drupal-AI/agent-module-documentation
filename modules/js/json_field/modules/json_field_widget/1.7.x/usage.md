<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON Field Widget is the optional submodule of JSON Field that replaces the plain textarea with the josdejong **JSON Editor** (`json_editor` widget), giving editors code/tree/form/view modes and optional JSON Schema validation on save.

---

The submodule adds exactly one thing: the field widget plugin `json_editor` ("JSON-specific WYSIWYG editor") for the `json`, `json_native` and `json_native_binary` field types. Its widget settings are `mode` (the editor mode the field opens in), `modes` (the modes the editor's mode-switcher offers), `schema` (a JSON Schema document as text) and `schema_validate` (a boolean). At form build time the widget renders a plain `<textarea>` carrying a `data-json-editor` attribute whose value is a SHA-256 hash of the editor config, and pushes that config into `drupalSettings.json_field[<hash>]`; `assets/js/json_widget.js` then upgrades every matching textarea into a JSON Editor instance. The library itself is not bundled — `json_field_widget/jsoneditor` points at `/libraries/jsoneditor/dist/jsoneditor.min.{js,css}`, and `json_field_widget_requirements()` raises a status-report **error** if that file is missing (max supported jsoneditor version 6.0.0). Server-side schema validation is opt-in: when `schema` is non-empty and `schema_validate` is TRUE, an `#element_validate` callback imports the schema through `Swaggest\JsonSchema\Schema` and blocks the save with "JSON Schema validation failed." on mismatch. The schema textarea on the widget settings form is itself validated (and is itself edited with a JSON Editor, using the bundled `assets/schema.json` meta-schema). The `swaggest/json-schema` PHP library is only a Composer `suggest` of the parent project, so schema validation requires installing it explicitly.

---

- Give editors a syntax-highlighting ACE code editor instead of a raw textarea for a JSON field.
- Let editors browse a large payload as a collapsible tree rather than one long line.
- Open a JSON field read-only ("view" mode) for roles that should see but not edit the data.
- Offer a form-style structured editor ("form" mode) for non-technical editors.
- Restrict the mode switcher to just "code" and "text" so editors cannot reshape the document.
- Enforce a JSON Schema on a configuration blob so a typo cannot be saved.
- Require a `sku` / `price` shape on a product metadata JSON field before publication.
- Validate an imported webhook payload against the contract it is supposed to satisfy.
- Catch missing required keys at form-submit time instead of at render time.
- Use different widget settings per form mode (strict schema on the default form, free-form on an admin form).
- Pretty-print stored minified JSON automatically when the editor loads.
- Reduce editor JSON syntax errors (unbalanced braces, trailing commas) with live linting.
- Configure per-field editor modes on the entity's *Manage form display* page.
- Ship the widget configuration as exported config so environments stay identical.
- Provide a friendlier editing surface for GeoJSON, chart data or feature-flag documents.
- Keep the plain `json_textarea` widget for API-only fields and the editor only where humans type.
- Detect a missing `/libraries/jsoneditor` install early via the status report requirement.
- Pair the editor with the parent module's `pretty` formatter for a read-friendly front-end display.
- Let a decoupled front-end team edit its own settings document safely inside Drupal.
- Enforce enum values (allowed statuses, allowed locales) through the schema instead of custom code.
- Prevent an editor from removing a key another module depends on.
- Give a JSON field an inline documentation surface by embedding `description` fields in the schema.
- Standardise editing UX across many JSON fields by copying the same widget settings.
- Turn schema validation off temporarily (keep the schema, unset `schema_validate`) while migrating data.
