<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Field provides a single `custom` field type whose storage is a set of user-defined columns (subfields) kept in **one database table**, giving a compact, high-performance alternative to Paragraphs or entity-reference for simple compound data.

---

One Custom Field is configured with any number of **columns**, each backed by a subfield **type** plugin (`string`, `integer`, `datetime`, `entity_reference`, `image`, `link`, `map`, `color`, `uuid`, …). Every column has its own **widget** plugin on the form and its own **formatter** plugin on display, so a single field can render a whole mini-record. The parent field itself uses one of two base widgets — `custom_flex` (a CSS-flexbox layout you arrange visually) or `custom_stacked` — and base formatters such as `custom_formatter` (themed), `custom_inline`, `custom_list`, `custom_table`, `flipped_table`, and `custom_template` (Twig rewrite like Views). Because all columns live in the field's own table (`node__field_x` with `field_x_<column>` columns), there are no joins and no extra config entities per subfield, which is where the performance/scalability claim comes from. The module ships six plugin types (`custom_field_type`, `custom_field_widget`, `custom_field_formatter`, `custom_field_feeds`, `custom_field_component_prop_widget`, and the YAML-driven `custom_field_link_attributes`), Views field/sort/filter/argument integration, tokens, Feeds targets, Entity Usage tracking, and Drush commands (`custom_field:add-column` / `custom_field:remove-column`) that add or drop a column on a field that already holds data. There is no global settings page — everything is configured per field through the standard Field UI storage and display forms. Optional submodules add GraphQL, JSON:API, Linkit, Media Library, Search API, SDC, Entity Browser, AI and Viewfield integrations.

---

- Replace a Paragraph type used only for a small fixed record (e.g. a "call to action" with title, URL, and style) with one Custom Field.
- Store a repeatable "team member" row (name, role, photo, email) as a multi-value Custom Field instead of an entity reference.
- Build an address-like compound field (street, city, postal code, country) in a single table for fast querying.
- Add a "price + currency + valid-from date" field to a product node without three separate fields.
- Model a set of external links with per-link label, URI, and target using the `link` and `uri` subfield types.
- Attach an image column plus a caption string column together as one field.
- Create a color-swatch field using the `color` / `color_boxes` widget for theme accents.
- Reference other entities from a column with `entity_reference` while keeping labels and IDs in the same field table.
- Add a `datetime` or `daterange` column with the date widgets and advanced date formatters.
- Store arbitrary key/value metadata in a `map` column rendered as an inline or table map formatter.
- Lay out a field's columns responsively with the flexbox (`custom_flex`) widget's visual settings.
- Render a Custom Field as an HTML table or flipped table for spec-sheet style output.
- Rewrite a Custom Field's output with a Twig template using the `custom_template` formatter.
- Add a new column to a Custom Field that already has content via `drush custom_field:add-column`.
- Remove an obsolete column from a populated Custom Field via `drush custom_field:remove-column`.
- Clone the column configuration of a Custom Field from any other entity type/bundle.
- Expose Custom Field columns as Views fields, filters, sorts, and date arguments.
- Provide tokens for Custom Field column values in emails or pathauto patterns.
- Import Custom Field column data with Feeds using the module's Feeds target plugins.
- Track entities referenced by a Custom Field column with Entity Usage.
- Write a custom subfield **type** plugin to add a new data type via the `CustomFieldType` attribute.
- Write a custom subfield **widget** or **formatter** plugin for a bespoke input/display.
- Consolidate several single-value fields into one Custom Field to cut table bloat and joins.
- Present a `time` / `time_range` value with the time and duration subfield types.
- Use the `uuid` subfield to store an auto-generated identifier column alongside editable data.
- Serve Custom Field data over JSON:API or GraphQL via the integration submodules.
