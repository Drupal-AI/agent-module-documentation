<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Details Field (details_field) — agent index

A field type + widget + formatters for creating and displaying native HTML `<details>`/`<summary>`
disclosure (collapsible) elements. Version **1.0.0-beta1**. Core `^10 || ^11`.

## Dependencies
- Core `field`, core `text` (the field type extends `TextWithSummaryItem`; the widget extends
  `TextareaWithSummaryWidget`; the formatter extends `TextDefaultFormatter`).
- No composer requirements, no library dependencies, no submodules.
- No permissions, no Drush commands, no configuration route of its own (settings live on
  Manage fields / Manage form display / Manage display).

## What it provides
- **Field type** `details_field` (id "Details element", category `formatted_text`) —
  `src/Plugin/Field/FieldType/DetailsFieldItem.php`. Columns beyond core text-with-summary:
  `summary_format`, `open` (tinyint), `name` (varchar 255), `attributes` (serialized blob).
- **Widget** `details_field` — `src/Plugin/Field/FieldWidget/DetailsFieldWidget.php`.
- **Formatters** `details_field` (full details element) —
  `src/Plugin/Field/FieldFormatter/DetailsFieldFormatter.php`; and `details_field_summary`
  (summary only) — `src/Plugin/Field/FieldFormatter/DetailsFieldSummaryFormatter.php`.
- **Plugin type** `details_field` — YAML plugin manager `plugin.manager.details_field`
  (`src/DetailsFieldManager.php`, service in `details_field.services.yml`) discovering
  `MODULE.allowed_attributes.yml` files. Ships `details_field.allowed_attributes.yml`
  (open, name, class, id, aria-label).
- **Views data** via `hook_field_views_data()` in `details_field.views.inc`
  (value, summary, open, name, attributes columns).
- **Config schema** `field.widget.settings.details_field` in
  `config/schema/details_field.schema.yml`.

## Solution docs
- Field type, storage & rendering: [agent/fields/details_field.md](fields/details_field.md)
- Widget, attribute plugins & Views: [agent/fields/widget.md](fields/widget.md)
