<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Trademark (drowl_trademark) — agent index

Appends a registered-trademark sign (superscript **®**) after admin-defined words on rendered
front-end pages, applied **client-side by JavaScript** at runtime. Package `DROWL.de Utility`.
No module dependencies, no external libraries. Core `^8.9 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later.

> **Dev branch:** this checkout has **no `version:` line** in `drowl_trademark.info.yml` — it is a
> development/pre-release build (documented as version dir `2.x`; library declares `version: 2.x`).

## What it actually is

- One `hook_page_attachments()` (`drowl_trademark_page_attachments()` in `drowl_trademark.module`)
  that, on non-admin pages, reads config and attaches the JS library + `drupalSettings`.
- One settings form `DrowlTrademarkSettingsForm` (`ConfigFormBase`) at
  `/admin/config/user-interface/drowl_trademark`, permission `administer drowl trademark`.
- One config object `drowl_trademark.settings` with two string keys (schema in
  `config/schema/drowl_trademark.schema.yml`, defaults in `config/install/`).
- One JS behavior `Drupal.behaviors.drowl_trademark` in `js/drowl_trademark.js` (library
  `drowl_trademark/drowl_trademark`; deps `core/jquery`, `core/drupal`, `core/once`,
  `core/drupalSettings`). No entities, no services, no plugins, no Drush.

## Solution docs

- **Settings form, config object, schema, route, permission, menu** →
  [config/settings.md](config/settings.md)
- **How the marking works: page_attachments → drupalSettings → JS DOM manipulation** →
  [api/rendering.md](api/rendering.md)
