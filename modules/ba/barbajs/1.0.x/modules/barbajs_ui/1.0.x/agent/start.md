<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Barba JS UI (barbajs_ui) — agent index

Configuration submodule of **Barba JS**. Adds an admin settings form that governs how the parent module's
Barba.js libraries are attached. Package *User interface*. Core `^9.5 || ^10 || ^11`. GPL-2.0-or-later.
Version 1.0.0-alpha1 (dir `1.0.x`). **Depends on** `barbajs:barbajs`.

- **Settings form, config object, schema, path/theme enforcement** → [config/settings.md](config/settings.md)

## What it provides (from source)

- **Permission** (`barbajs_ui.permissions.yml`): `administer barba`.
- **Route** (`barbajs_ui.routing.yml`): `barba.settings` → `/admin/config/user-interface/barba/settings`,
  `_form: \Drupal\barbajs_ui\Form\BarbaSettings`, `_permission: administer barba`, `_admin_route: TRUE`.
  Menu link + local task under *Configuration → User interface* (`barbajs_ui.links.menu.yml`,
  `.links.task.yml`). `configure: barba.settings` in the info file.
- **Config**: object `barbajs_ui.settings` (schema in `config/schema/barbajs_ui.schema.yml`, install
  defaults in `config/install/barbajs_ui.settings.yml`). Keys: `load`, `version`, `method`,
  `build.variant`, `file_types.{core,css,prefetch,router}`, `theme_groups.{negate,themes}`,
  `request_path.{negate,pages}`.
- **Form**: `Drupal\barbajs_ui\Form\BarbaSettings` (`ConfigFormBase`, form id `barba_settings_form`),
  injects `theme_handler`. Attaches its own `barbajs_ui/barba.settings` admin library (vertical tabs).
- **Class**: `Drupal\barbajs_ui\BarbaConstants` — the four pinned Barba version strings shown in the form.
- **Attachment**: `barbajs_ui.module` `hook_page_attachments` (`barbajs_ui_page_attachments`) reads the
  config and attaches the selected `barbajs/*` libraries, replacing the base module's auto-attach.
- No entities, no services, no plugins, no Drush.

See [config/settings.md](config/settings.md) for every setting, the enforcement helpers and the
empty-selection reset behaviour.
