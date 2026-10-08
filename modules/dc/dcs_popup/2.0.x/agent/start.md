<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Digital Climate Strike Popup (dcs_popup) — agent index

Thin wrapper that embeds the third-party **Digital Climate Strike** participation widget
(bottom banner or full-page popup) into a Drupal 10/11 site. Version dir `2.0.x`
(shipped `2.0.4`). Core `^10 || ^11`. Package `Other`. License GPL-2.0-or-later.

## What it provides
- **Config object** `dcs_popup.settings` with one key: `widget` (`none` | `bottom` | `page`). Default `none`.
- **Settings form** `\Drupal\dcs_popup\Form\SettingsForm` (a `ConfigFormBase`) at route
  `dcs_popup.settings_form` → `/admin/config/dcs_popup/settings`, gated by core permission
  `access administration pages`. Menu link under System (`dcs_popup.links.menu.yml`).
- **Library** `dcs_popup/dcspopup-js` (`dcs_popup.libraries.yml`) — loads the REMOTE script
  `https://assets.digitalclimatestrike.net/widget.js` (external, async). A local copy at
  `config/js/widget.js` exists but is not referenced by the library and is unused.
- **hook_preprocess_page()** (`dcs_popup.module`) — intended to attach the library +
  `drupalSettings['dcs_popup']` on the default theme. See caveat in the config doc.
- **hook_help()**, plus `hook_install`/`hook_uninstall`/`hook_schema` in `dcs_popup.install`
  (declares an unused `dcs_popup` DB table; the module never reads/writes it).

## Does NOT provide
- No custom permissions (no `*.permissions.yml`), no config schema (no `config/schema/`),
  no services, no plugins, no routes beyond the settings form, no Drush commands, no submodules.
- No module dependencies beyond Drupal core.

## Solution docs
- [Configuration & attach behavior](config/settings.md) — settings form, config object, the
  preprocess-page attach logic and its caveats, remote library.
