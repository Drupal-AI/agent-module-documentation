<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Accessible Menu

## Install & enable

```bash
composer require drupal/accessible_menu
drush en accessible_menu -y
```

Only dependency is core **`menu_ui`**. No permissions of its own; the settings route uses core's
**`administer site configuration`**.

## Two layers of configuration

Accessible Menu splits settings into a **site-wide library layer** and a **per-menu layer**.

### 1. Site settings — where the JS library loads from

Route **`accessible_menu.settings`** → `/admin/config/development/accessible-menu`
(menu link *Configuration → Development → Accessible Menu Settings*). Form
`Drupal\accessible_menu\Form\SettingsForm` (extends `ConfigFormBase`).

For each registered `accessible_menu_library` plugin it shows:

| Field | Meaning |
|---|---|
| Installation method | `cdn` (external) or `local` (a `/libraries/…` copy). |
| CDN provider | `jsdelivr` or `unpkg` (only when installation = cdn), from the plugin's `cdns`. |
| Version | Semver (e.g. `4.0.0`) or `latest` (only when installation = cdn). |

`validateForm()` requires the version to match
`/^(?<prefix>v)?(?<version>\d+\.\d+\.\d+(?:-(?:alpha|beta|rc)\.\d+)?)$/` or be `latest`; a leading
`v` is stripped. `submitForm()` composes the concrete asset **path** for the main file and every
menu type — `<cdn url>@<version>/<dist_dir>/<file_name>` for CDN, or
`<base_path>/<dist_dir>/<file_name>` for local — and saves it into `accessible_menu.library.<id>`.

### 2. Per-menu settings — how a given menu behaves

`hook_form_menu_form_alter` injects an **"Accessible Menu"** fieldset into the core menu edit form
(*Structure → Menus → edit*). Its "Menu Type" select is built from every library's `menu_types`
(value format `<library_id>--<type>`, plus `none`). The extra `_accessible_menu_submit_handler`
saves the values into config object **`accessible_menu.menu.<menu_id>`**:

| Key | Field | Default |
|---|---|---|
| `menu` / `type` | library id and menu type (split from the select value) | — / `none` |
| `collapsible` | show a toggle button and enable collapse behaviour | FALSE |
| `open_class` | class added when open | `show` |
| `close_class` | class added when closed | `hide` |
| `transition_class` | class during transition | `transitioning` |
| `transition_duration` | ms | 250 |
| `open_duration` | ms; `-1` = use transition duration | -1 |
| `close_duration` | ms; `-1` = use transition duration | -1 |
| `optional_key_support` | disclosure / top-link disclosure only | FALSE |
| `hover_type` | `off` / `on` / `dynamic` | off |
| `hover_delay` | ms | 250 |
| `enter_delay` | ms; `-1` = hover delay | -1 |
| `leave_delay` | ms; `-1` = hover delay | -1 |

Config schema for both objects is in `config/schema/accessible_menu.schema.yml`
(`accessible_menu.library.*` and `accessible_menu.menu.*`). Deleting a menu entity triggers
`hook_entity_delete`, which deletes the matching `accessible_menu.menu.<id>` config.

## How it reaches the page (block wiring)

`accessible_menu_preprocess_block()` runs only for `system_menu_block` / `menu_block` blocks. When
the block's menu has an enabled `accessible_menu.menu.<id>` config it:

1. adds classes `<menu>` and `<type>` (underscores → hyphens) to the block;
2. attaches libraries `accessible_menu/<menu>__<type>` and `accessible_menu/generator`;
3. ensures the block has an `id` (generates `accessible-menu-<uuid>` if missing);
4. attaches `drupalSettings.accessibleMenu.menus[<block id>]` with the `constructor` name,
   `collapsible`, `elementSelectors` (`ul:not(.contextual-links)`, `button`, container) and the
   `options` (open/close/transition classes and durations, hover config, optional key support).

`hook_library_info_build()` turns each `accessible_menu.library.*` config into real Drupal
libraries (`<id>` and `<id>__<type>`), pointing `js` at the saved `path` with
`external => (installation === 'cdn')` and `remote => https://accessible-menu.dev`.

## Runtime JS

`js/accessible-menu-generator.js` (`Drupal.behaviors.accessibleMenu`, using `core/once`) reads
`drupalSettings.accessibleMenu.menus`, looks up `window[constructor]` (e.g. `DisclosureMenu`,
exported by the loaded IIFE library), finds the menu `ul`, optional controller `button` and
container, and does `new MenuClass({menuElement, controllerElement, containerElement, ...options})`.

## Templates & theming

Template overrides live in `templates/`; `hook_theme` registers `menu__accessible_menu` and
`menu__accessible_menu__top_link_disclosure_menu`, and `hook_theme_suggestions_menu_alter` adds
suggestions keyed on the library, type and menu name so you can override per menu. Links are
rendered with core `link()` and `create_attribute()`, and the toggle label uses
`t('Toggle @menu', …)` — all auto-escaped. **The module ships no CSS**; provide your own theme
styles for the open/close/transition classes.
