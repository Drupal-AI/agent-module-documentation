<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ACH Attach JS Attacher (ach_attach_js_attacher) — agent index

Sub-module of **ACH Attach JS**. Provides one admin form that attaches the
`ach_attach_js/ach-attach-js` library to the paths you choose, using core's **Request Path**
visibility condition, then attaches it in `hook_page_attachments()`. Package `Acquia`. Core
`^9.2 || ^10 || ^11`. GPL-2.0-or-later. Version `8.x-1.0-alpha6`. Depends on `ach_attach_js`.

- **The config form, route, permission, config object, and attach logic** →
  [config/settings.md](config/settings.md)

## What it provides

- **Route** `ach_attach_js_attacher.config` → `/admin/config/ach_attach_js`, form
  `\Drupal\ach_attach_js_attacher\Form\AchAttachJsAttacherConfig`, permission
  **`administer ach_attach_js_attacher`** (`restrict access: true`).
- **Menu link** `ach_attach_js_attacher.config` under `system.admin_config_services`
  (Configuration → Development → Services).
- **Config object** `ach_attach_js_attacher.settings` with a single key `request_path`
  (a serialized core Request Path condition config). Install default:
  `id: request_path`, `pages: "/admin\r\n/admin/*"`, `negate: 1`.
- **Hook** `ach_attach_js_attacher_page_attachments()` in `.module`.
- No plugins, no services, no Drush. **No config schema shipped** (see caveat in the solution doc).

## Mechanism (from source)

- `AchAttachJsAttacherConfig` (extends `ConfigFormBase`) builds its form by instantiating the core
  `request_path` condition plugin (`plugin.manager.condition`) from the saved config and rendering
  the plugin's own `buildConfigurationForm()`. `submitForm()` runs the plugin's
  `submitConfigurationForm()`, then saves `getConfiguration()` back to `request_path`.
- `ach_attach_js_attacher_page_attachments()` re-creates the `request_path` condition from config,
  `evaluate()`s it, and attaches `ach_attach_js/ach-attach-js` when `condition_met XOR negated` is
  true (correctly honoring the negate toggle).

## Dependencies

- `ach_attach_js` (the parent library module). Core `request_path` condition plugin (in core, no
  extra dep). Nothing else.
