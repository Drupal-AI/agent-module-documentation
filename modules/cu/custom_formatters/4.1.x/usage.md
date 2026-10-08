<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Formatters lets site builders create reusable Field Formatters through an admin UI — writing PHP, Twig, or HTML+Token snippets (or a preset) instead of a custom module — and exports each as a `formatter` config entity that appears in Field UI's *Manage display* like any core formatter.

---

Each formatter is a `formatter` **config entity** (config prefix `custom_formatters.formatter.*`) with an
`id`, `label`, applicable `field_types`, an engine `type`, and a `data` code blob. Engines are
`custom_formatters_formatter_type` plugins: **PHP** (`eval()`s the snippet), **Twig** (renders the
snippet through the Twig service), **HTML+Token** (token-replaced HTML), and **FormatterPreset** (wraps
an existing core/contrib formatter with locked settings). A single `CustomFormatters` field-formatter
plugin (with a derivative per config entity) bridges these into Field UI, so a custom formatter shows up
as a normal display option for its declared field types. Formatters can also carry **per-instance
settings**: a `formatter` acts as the bundle for a `FormatterSetting` content entity, so you add fields
to a formatter (Manage fields) and their values arrive in the engine as a `$settings` array (rendered)
plus `$raw_settings`/`_raw` (unformatted). Optional `custom_formatters_formatter_extras` plugins (e.g.
`Contextual`) add cross-cutting behavior. Integrations: `insert` (image/file/reference formatters as
Insert styles), `codemirror_editor` (syntax highlighting + autocomplete for the code fields), `token` /
`field_tokens` (token tree + field tokens), and `devel` (preview debug output + Devel Generate sample
content). Managed at *admin/structure/formatters* (`entity.formatter.collection`). **All formatter
management is gated by the single `administer custom formatters` permission — and because the PHP and
Twig engines execute arbitrary code, that permission is effectively site-administrator / trusted.**

---

- Build a bespoke field display without writing or deploying a custom module.
- Wrap a field value in custom HTML/markup using the HTML+Token engine and token replacement.
- Render a field with a Twig template snippet stored in config.
- Compute a derived display value in PHP (e.g. format, combine, or transform field data).
- Create a formatter that spans multiple fields/values (PHP and Twig engines support multi-field).
- Package an existing core formatter with pre-locked settings as a reusable preset (FormatterPreset).
- Add per-instance settings fields to a formatter and read them via `$settings` / `raw_settings`.
- Use raw vs rendered field values (`_raw` / `raw_settings`) for attributes, classes, or comparisons.
- Reuse one custom formatter across many bundles and field instances.
- Export/import formatters as configuration for deployment across environments.
- Insert an image/file/entity_reference custom formatter as an "Insert" style in text fields (insert module).
- Provide editors a token-driven HTML formatter with a token browser (token / field_tokens).
- Get syntax highlighting and autocomplete while writing formatter code (codemirror_editor).
- Preview a formatter against sample content while building it (devel / Devel Generate).
- Apply a CSS class or wrapper conditionally based on a field value.
- Render a link field as a custom button/markup structure.
- Format a numeric/price field with bespoke units or layout.
- Combine several fields into a single formatted output block.
- Standardize a project's custom display patterns as named, shareable formatters.
- Prototype a formatter in the UI before (optionally) hardening it into real code.
- Restrict which field types a formatter applies to via `field_types`.
- Debug formatter output with variable dumps during development (devel debug options).
- Migrate legacy Custom Formatters (2.x/3.x) display logic into the 4.x plugin/config model.
- Attach contextual behavior to formatters via a FormatterExtras plugin.
- Give content teams reusable display components without developer round-trips (for trusted admins only).
