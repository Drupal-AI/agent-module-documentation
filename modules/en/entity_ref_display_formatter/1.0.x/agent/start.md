<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Display Formatter (entity_ref_display_formatter) — agent index

A single **field formatter** that renders the referenced entities of an `entity_reference` /
`entity_reference_revisions` field as **horizontal tabs, vertical tabs, an accordion, or anchors**.
Package `Entity`. Core `^10 || ^11`. License GPL-2.0-or-later. Version dir 1.0.x (release 1.0.2).

- **The formatter, every setting, view-mode/field selection, templates, libraries** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `EntityReferenceTabFormatter` (id **`entity_reference_display_formatter`**, label
  *"Entity reference Display formatter"*) in
  `src/Plugin/Field/FieldFormatter/EntityReferenceTabFormatter.php`, extending core `FormatterBase`
  (NOT `EntityReferenceFormatterBase`). `field_types = { entity_reference, entity_reference_revisions }`.
- No config form/route, **no permissions**, no services, no Drush, no `.install`, no config
  schema, no declared module dependencies. Only file with PHP logic beyond the plugin is
  `entity_ref_display_formatter.module` (a single `hook_theme()`).

## Provides

- **hook_theme** (`entity_ref_display_formatter.module`): four themes, one per style —
  `entity_ref_tab_formatter`, `entity_ref_tab2_formatter`, `entity_ref_accordion_formatter`,
  `entity_ref_anchor_formatter` (variable: `tabs`); templates in `templates/`.
- **Libraries** (`entity_ref_display_formatter.libraries.yml`): `tab_formatter` (js, dep
  `core/once`), `tab_formatter_vertical` (js+css, dep `jquery_ui_tabs/tabs`), `accordion_formatter`
  (js, dep `jquery_ui_accordion/accordion`), `anchor_formatter` (css only).

## Runtime dependencies (undeclared)

- The **Vertical Tab** style needs the `jquery_ui_tabs` module and **Accordion** needs
  `jquery_ui_accordion` (their libraries are referenced but not declared in `.info.yml`). Horizontal
  Tab and Anchors need no contrib modules.

## How to operate

- Enable the module; on *Manage display* of an entity_reference / entity_reference_revisions field
  choose the **"Entity reference Display formatter"** formatter, then pick title field(s), body
  field(s), their weights, and one style. See [fields/formatter.md](fields/formatter.md).
