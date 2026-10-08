<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Toolbar Background Color (admintoolbar_bgcolor) — agent index

Sets the background color of the classic **Admin Toolbar** bar (`#toolbar-bar`) from a single
color-picker setting — commonly used as a **per-environment indicator**. Version **1.0.1**
(dir `1.0.x`). Core `^10 || ^11`. Depends on `color_field`. License GPL-2.0-or-later.

## What it provides

- **Settings form** `Drupal\admintoolbar_bgcolor\Form\AtbgColorSettingsForm` (`ConfigFormBase`).
  Route `admintoolbar_bgcolor.settings` → `/admin/config/administration/at-bgcolor`, requirement
  `_permission: 'administer site configuration'`. `configure:` points here; menu link in
  `admintoolbar_bgcolor.links.menu.yml` under `system.admin_config_system`.
- **Config object** `admintoolbar_bgcolor.settings` with key `admintoolbar_bgcolor` (string).
  Schema `config/schema/admintoolbar_bgcolor.schema.yml`.
- **Hooks** (`admintoolbar_bgcolor.module`): `hook_preprocess_page` (attaches the library +
  `drupalSettings` when a color is set), `hook_help`, plus `hook_install`/`hook_uninstall`
  (`.install`) that add the settings-page message and delete config on uninstall.
- **Library** `admintoolbar_bgcolor/admin_toolbar_color` — `css/admin-toolbar-color.css` (black
  default) + `js/admin-toolbar-color.js` (`Drupal.behaviors.adminToolbarColor`).

## Dependencies / relationships

- Hard dependency on `drupal:color_field` in `.info.yml`. No `composer.json` ships with the module.
- Targets the classic core **Toolbar** markup (`#toolbar-bar`); has no effect where that element is
  absent.

## Solution docs

- `agent/config/settings.md` — the settings form, config object + schema, route/permission, and the
  preprocess → drupalSettings → JS application path.

## Notes for agents

- The value is applied by JS assigning `#toolbar-bar`'s `style.backgroundColor` from
  `drupalSettings`, not by writing a CSS rule; the form uses an HTML5 `#type => 'color'` input.
- Only users with `administer site configuration` can change the color.
