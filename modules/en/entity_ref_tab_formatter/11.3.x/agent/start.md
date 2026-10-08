<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Tab Formatter (entity_ref_tab_formatter) — agent index

A single **field formatter** that renders a multi-value entity reference field as **tabs** or an
**accordion**. Package `Entity`. Core `^10.3 || ^11`. License GPL-2.0-or-later. Version 11.3.0.
No hard module dependencies; **Views** is used only when the "Views block" body option is chosen.

- **The formatter, all settings, config schema, templates, JS, and how to enable it** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `EntityReferenceTabFormatter` (id **`entity_reference_tab_formatter`**, label
  *"Entity reference tab formatter"*), in
  `src/Plugin/Field/FieldFormatter/EntityReferenceTabFormatter.php`, extending core's
  **`FormatterBase`** (not `EntityReferenceFormatterBase`). Injects `entity_type.manager`,
  `entity_field.manager`, `entity_type.bundle.info`, `entity_display.repository`.
- `field_types = { "entity_reference", "entity_reference_revisions" }` — targets reference fields;
  pairs well with Paragraphs but works with any referenced entity type.
- **No** routes, **no** permissions, **no** services, **no** Drush, **no** install/update hooks.
  One hook: `hook_theme()` in `entity_ref_tab_formatter.module`.

## Provided theme hooks / templates

- `entity_ref_tab_formatter` → `templates/entity-ref-tab-formatter.html.twig` (ARIA tablist +
  `role="tabpanel"` panels).
- `entity_ref_accordion_formatter` → `templates/entity-ref-accordion-formatter.html.twig` (native
  `<details>`/`<summary>`).

## Libraries (in `entity_ref_tab_formatter.libraries.yml`)

- `entity_ref_tab_formatter/tab_formatter` — `js/tab_formatter.js`, deps `core/drupal`, `core/once`.
- `entity_ref_tab_formatter/accordion_formatter` — `js/accordion_formatter.js` + `css/accordion_formatter.css`,
  deps `core/drupal`, `core/once`. No jQuery UI. Attached at render time by the formatter.

## Config

- No config object of its own. Formatter settings live in the view-display config
  (`core.entity_view_display.*`). Schema: `config/schema/entity_ref_tab_formatter.schema.yml`
  (`field.formatter.settings.entity_reference_tab_formatter`). Settings keys and defaults in
  [fields/formatter.md](fields/formatter.md).
