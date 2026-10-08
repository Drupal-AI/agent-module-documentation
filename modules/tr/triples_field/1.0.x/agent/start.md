<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Triple field — agent index

One field type, `triples_field`, whose item stores **three independently-typed values**:
`first`, `second`, `third`. It is a three-column fork of the **Double Field** module and works
identically in design. **Not RDF / semantic-web triples** — "triple" just means three columns.

**No configure route** (`configure: null`), **no permissions, no services, no Drush, no plugin
types of its own, no module dependencies** (core only). It **does** ship its own config schema
and one site-wide config object. All field state lives in ordinary field / form-display /
view-display config.

- **Storage types, instance/field settings, allowed values, constraints, creating a field
  programmatically, the `triples_field.settings` config object** →
  [fields/field-type-and-storage.md](fields/field-type-and-storage.md)
- **The two widgets and four formatters, the sub-widget matrix, link building, Feeds target,
  hooks** → [fields/widgets-and-formatters.md](fields/widgets-and-formatters.md)
- **Templates, theme hooks and per-field theme suggestions** →
  [fields/theming.md](fields/theming.md)

Key facts:

- Properties are `first`, `second`, `third` (+ a `<subfield>_format` filter_format property each,
  used only by the `text_long` storage type). `mainPropertyName()` is **`NULL`** — there is no
  `->value`.
- Each column's storage type is one of `boolean`, `string` (Text), `text` (Text long),
  `text_long` (Text formatted long), `integer`, `float`, `numeric` (Decimal), `email`,
  `telephone`, `datetime_iso8601` (Date), `uri` (Url), set under `settings.storage.first.type` /
  `.second.type` / `.third.type` and **locked once the field has data** (`#disabled => $has_data`).
- Field type id: `triples_field`. Widget ids: `triples_field_table` (default, single-row table)
  and `triples_field` (stacked). Formatter ids: `triples_field_table` (default), `triples_field_details`,
  `triples_field_html_list`, `triples_field_unformatted_list`.
- The three column machine names and admin titles come from the config object
  `triples_field.settings` (`fields: {first, second, third}`). There is **no admin UI** to edit
  them; the code and schema assume exactly these three keys.
- Annotation-based plugins (`@FieldType`, `@FieldWidget`, `@FieldFormatter`) — not PHP attributes.
  Core requirement `^10 || ^11`; version 1.0.10.
- Optional soft integration: a Feeds target (`\Drupal\triples_field\Feeds\Target\TriplesField`)
  is present but Feeds is not a dependency.
