<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookie Script Integration (cookie_script) — agent index

Injects the commercial **Cookie-Script.com** consent loader onto every page so it can show a
cookie-consent banner and block cookie-setting scripts until consent. Package **User interface**.
No dependencies beyond Drupal core. Core requirement `^8 || ^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 1.x (installed 1.0.1). No submodules, no config schema, no Drush.

- **The settings form, the config value, and how the script is attached** →
  [config/settings.md](config/settings.md)

## What it actually is

- One config object: **`cookie_script.settings`** with a single key **`id`** (your Cookie-Script
  account/domain ID). No `config/install` default and no `config/schema` ship with the module.
- One settings form: `CookieScriptSettingsForm` (form id `cookie_script_settings`) in
  `src/Form/CookieScriptSettingsForm.php`, extends core `ConfigFormBase`; one required `#textfield`
  named `id`.
- One route: **`cookie_script.settings`** at `/admin/config/cookie_script`, permission
  **`administer cookie_script settings`** (`cookie_script.routing.yml`). Admin menu link under
  *System* configuration (`cookie_script.links.menu.yml`).
- One permission: **`administer cookie_script settings`** (`restrict access: true`).
- Asset attachment (`cookie_script.module`): `hook_library_info_build()` builds a dynamic library
  **`cookie_script/base`** with one external JS asset `//cdn.cookie-script.com/s/<id>.js` — only when
  `id` is non-empty; `hook_preprocess_page()` attaches `cookie_script/base` to every page.
- `hook_help()` for the module's help page. No entities, plugins, services, or Drush commands.
