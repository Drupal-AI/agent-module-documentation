<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Overview Field (overview_field) — agent index

Field type whose **allowed values come from code**, not config. Attach an `overview_field` to any
fieldable entity: its widget is a `select` whose options are gathered by
`hook_overview_field_options_alter(&$options)`, the editor picks one named "overview", the field
stores that key as a 255-char string, and the formatter dispatches on the key through
`hook_overview_field_output_alter($key, &$output)` — a module returns a render array (commonly a
Views display via the `overview_field_load_view($view, $display)` helper, or a block). Nothing shows
until at least one module implements the two alter hooks; the bundled `overview_field_example`
submodule is a working reference (registers `recent_content` → renders view `content_recent:block_1`).

Deliberately thin: no settings page, no routes, no services, no permissions, no config schema, no
new plugin type. It is the field-type/widget/formatter plumbing plus two extension hooks — the code
you would otherwise hand-write for a "pick a dynamic listing" slot, and no more.

- **Depends on:** `drupal:field` (core). No external libraries, no composer requirements.
- **Core:** `^9 || ^10 || ^11`. **Package:** `Field types`. Version **2.0.2**.
- **Settings page / `configure` route:** none. Configuration is per field instance (Manage
  fields / Manage form display / Manage display), same as any core field.
- **Permissions:** none of its own. **Drush:** none. **Config schema:** none (no `config/` dir).
- **Plugin types defined:** none. It ships field plugins (type/widget/formatter), not a manager.
- **Submodule:** `overview_field_example` (example implementer of the two hooks; not separately
  documented — see hooks topic below).
- Soft integration with `single_content_sync` via
  `hook_content_export/import_field_value_alter()` (round-trips the stored value).

## What you'd do → where

- **Attach the field, choose the widget/formatter, understand the stored value / schema** →
  [fields/field-type.md](fields/field-type.md)
- **Make the select non-empty and make a choice actually render something (register options +
  output, load a view/block, the example submodule)** → [hooks/extension.md](hooks/extension.md)

## Key facts (real machine names)

- Field type: `overview_field` (`src/Plugin/Field/FieldType/OverviewField.php`),
  `default_widget = overview_field_widget`, `default_formatter = overview_field_formatter`.
- Widget: `overview_field_widget` (`…/FieldWidget/OverviewFieldWidget.php`) — a `select`
  (`#empty_option` "No overview", `#empty_value` `''`, `#required` FALSE).
- Formatter: `overview_field_formatter` (`…/FieldFormatter/OverviewFieldFormatter.php`).
- Alter hooks invoked: `overview_field_options` (widget) and `overview_field_output` (formatter);
  both documented in `overview_field.api.php` as `hook_overview_field_options_alter(&$options)` and
  `hook_overview_field_output_alter($key, &$output)`.
- Helper function: `overview_field_load_view($view, $display)` (`overview_field.module`) — returns
  a renderable Views display.
- Other hooks implemented: `hook_help()` (help.page.overview_field),
  `hook_content_export_field_value_alter()`, `hook_content_import_field_value_alter()`.
- Storage: single column `value`, `varchar` (or `varchar_ascii` when field setting `is_ascii` is
  TRUE) length 255, `binary` when field setting `case_sensitive` is TRUE.
