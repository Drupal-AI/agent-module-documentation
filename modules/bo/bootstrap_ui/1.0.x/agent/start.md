<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap UI (bootstrap_ui) — agent index

Site-wide **loader/configurator for the Bootstrap CSS/JS framework**. One admin form controls how
Bootstrap is delivered (CDN, local `/libraries/bootstrap`, or Composer), which version, minified vs.
not, which asset files, RTL, and which themes/paths it loads on. Package `Bootstrap`. No entities,
no services, no plugins, no Drush. Core `^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
Version **1.0.4**.

## What it actually is

- A **procedural asset-loading module**, not a field/block/plugin provider. All logic is in
  `bootstrap_ui.module` (hooks + helpers), one settings form, and the `*.libraries.yml` definitions.
- Loading path: `hook_page_attachments()` decides *whether* and *which* library to attach based on
  config; `hook_library_info_alter()` rewrites the module's own library entries (CDN URL, version,
  file list, RTL, minified) from config before they are served.
- No hard module dependencies. The external **Bootstrap front-end library** must be reached via CDN
  or installed at `/libraries/bootstrap` (compiled `dist` layout) or `/libraries/bootstrap/dist`
  (source layout). Optional soft integration with `mdbootstrap` (Material Design kit).

## Provides

- **Route/form:** `bootstrap.settings` → `/admin/config/user-interface/bootstrap`, form
  `\Drupal\bootstrap_ui\Form\BootstrapSettings` (form id `bootstrap_admin_settings`). Menu link
  `bootstrap.settings` under *Configuration → User interface* (`bootstrap_ui.links.menu.yml`).
- **Permission:** `administer bootstrap ui` (gates the route). No other permissions.
- **Config:** single object `bootstrap_ui.settings` (schema `config/schema/bootstrap_ui.schema.yml`,
  install defaults `config/install/bootstrap_ui.settings.yml`).
- **Libraries** (`bootstrap_ui.libraries.yml`): `bootstrap[.rtl][.min][-dist]`,
  `bootstrap.cdn[.rtl][.min]`, `bootstrap.settings` (the admin form's CSS/JS), `bootstrap.patch`
  (RTL JS patch for BS4). Bundled RTL CSS patches live in `css/patch/{2,3,4}.x/`.
- **Constant:** `BootstrapConstants::LATEST_VERSION` = `5.3.7`.
- **Hooks it implements:** `help`, `page_attachments`, `library_info_alter`, `requirements`,
  `install`. **Hook it invokes for others:** `bootstrap_ui_library_name` (register extra UI kits).
- **Runtime helper functions** (callable by other code): `bootstrap_ui_find_library()`,
  `bootstrap_ui_check_installed()` (returns `'dist'`/`'code'`/`FALSE`),
  `bootstrap_ui_detect_version()`, `bootstrap_ui_library_names()`.

## Solution docs

- **Everything: install, the settings form, every config key + schema, loading logic, theme/path
  targeting, RTL, extending with other UI kits** →
  [config/settings.md](config/settings.md)
