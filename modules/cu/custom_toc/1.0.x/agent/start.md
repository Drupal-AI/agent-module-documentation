<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom TOC (custom_toc) — agent index

A field type + widget + formatter that generate and render an editable **Table of Contents**
from a formatted-text (CKEditor) source field. Package `Custom`. Depends on **`toc_api`** (`^2.0`).
Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.1 (version-dir 1.0.x).

- **The field type, widget, formatter, their settings, and how to enable them** →
  [fields/toc_field.md](fields/toc_field.md)
- **The `.module` glue: form alter, node_view injection, regenerate flow, helper functions** →
  [api/module-hooks.md](api/module-hooks.md)

## What it actually is

- One field type: **`toc_link_overrides`** (label *"TOC (CKEditor)"*), class
  `TocLinkOverridesItem` in `src/Plugin/Field/FieldType/`. Three stored properties:
  `value` (TOC HTML, `text`/big), `format` (varchar 255), `overrides` (JSON string, `text`/big).
- One widget: **`toc_link_overrides_widget`** (label *"TOC CKEditor"*), class
  `TocLinkOverridesWidget` — a `text_format` element plus a **"Regenerate TOC"** AJAX submit.
- One formatter: **`toc_link_overrides_formatter`** (label *"TOC HTML"*), class
  `TocLinkOverridesFormatter` — renders `value` through `#type => processed_text` with the
  stored `format`.
- `custom_toc.module` wires it into node forms and node view via hooks (see api doc).

## Dependencies & integration

- **Requires `toc_api`** — all TOC building uses services `toc_api.manager` and `toc_api.builder`
  and the `toc_api` **"default" `TocType`** config entity for options. Custom TOC ships no TOC
  algorithm of its own.
- No routes, no services, no permissions, no `*.permissions.yml`, no `config/schema`, no Drush.
  (Field settings use `defaultFieldSettings()`, not a config-schema file.)
- Referenced attach library `custom_toc/field_ui_icons` (in `hook_page_attachments`) has **no
  shipped `*.libraries.yml`** in this release — the attach is a no-op/optional UI icon.

## Field settings (per bundle, `defaultFieldSettings()`)

- `source_field` (default `body`) — which formatted-text field the headings come from.
- `allowed_formats` (default `['full_html']`) — text formats the widget offers.
- `default_format` (default `full_html`).

Details, the field-settings form (`fieldSettingsForm`), the widget's regenerate mechanics, and the
node-level hooks are in the two solution docs linked above.
