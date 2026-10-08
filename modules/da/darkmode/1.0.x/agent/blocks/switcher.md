<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Darkmode Switcher block (`darkmode_switcher`)

Source: `src/Plugin/Block/DarkmodeSwitcherBlock.php` — `DarkmodeSwitcherBlock extends BlockBase implements ContainerFactoryPluginInterface`. Declared with the PHP attribute `#[Block(id: "darkmode_switcher", admin_label: "Darkmode Switcher")]`. `create()` takes no injected services (plain `new static(...)`).

## Install & enable
1. Install the JS library so it resolves at `web/libraries/darkmode-js/lib/darkmode-js.min.js` (README recommends `composer require oomphinc/composer-installers-extender` + asset-packagist, then `composer require drupal/darkmode npm-asset/darkmode-js:1.5.7`).
2. Enable the module: `drush en darkmode -y`.
3. Place the **Darkmode Switcher** block in a region at `/admin/structure/block`. Nothing renders until the block is placed. `hook_help()` (`help.page.darkmode`) states the same.

There is no module settings page (`configure` is null); the old `/admin/config/darkmode` route referenced in the README no longer exists — all configuration is per-block.

## Configuration form (`buildConfigurationForm` / `blockSubmit`)
Fields, stored in the block's `settings`, with `defaultConfiguration()` defaults:

| Setting key | Form field | Default | Notes |
|---|---|---|---|
| `bottom` | textfield | `64px` | CSS offset or `unset` |
| `right` | textfield | `32px` | CSS offset or `unset` |
| `left` | textfield | `unset` | CSS offset or `unset` |
| `time` | textfield | `0.5s` | overlay transition duration |
| `mix_color` | textfield | `#fff` | Darkmode.js `mixColor` |
| `background_color` | textfield | `#fff` | Darkmode.js `backgroundColor` |
| `button_color_dark` | textfield | `#100f2c` | button color in dark state |
| `button_color_light` | textfield | `#fff` | button color in light state |
| `save_in_cookies` | checkbox | `FALSE` | persist visitor choice (cast to bool on submit) |
| `theme_mode` | select | `auto` | options: `auto` (match OS), `light`, `dark` |

Access/placement is entirely core block system (visibility conditions, region, theme). The block does no access checks of its own and exposes no route.

## Runtime (`build()` + `js/init.js`)
`build()` returns a render array whose `#attached` carries:
- `drupalSettings.darkmode` = camelCased map of the settings above (`mixColor`, `backgroundColor`, `buttonColorDark`, `buttonColorLight`, `saveInCookies`, `themeMode`, plus the offsets/time).
- `library`: `darkmode/initiator` and `darkmode/darkmodecss`.

`js/init.js` defines two `Drupal.behaviors`, each guarded by `once()` on `body`:
- `darkModeWidget` — builds `options` from `drupalSettings.darkmode` (label `🌓`, `autoMatchOsTheme: themeMode === 'auto'`), then `new Darkmode(options); darkmode.showWidget();` and stores the instance on `window.darkmodeInstance`.
- `darkModeApplyTheme` — for `themeMode === 'dark'` forces the overlay on (`toggle()` if not activated, adds `.darkmode-layer--expanded` / `.darkmode-toggle--white`); for `light` forces it off; `auto` leaves Darkmode.js to follow the OS `prefers-color-scheme`.

`css/styles.css` only sets `button.darkmode-toggle { z-index: 9999; }` so the toggle stays clickable above page content.

## Config schema
`config/schema/darkmode.schema.yml` types `block.settings.darkmode_switcher` (type `block_settings`) with string keys for the offsets/time/colors and boolean `save_in_cookies` and `auto_match_os_theme`. Note: the current block stores `theme_mode` (a select) rather than the schema's boolean `auto_match_os_theme`; the schema entry is a leftover from the earlier auto-match-only version and is harmless (extra/absent keys are ignored at runtime).

## Upgrade path
`darkmode.install` `hook_update_10001`: reads the legacy editable config `darkmode.config` (minus `_core`), iterates `block.repository:getVisibleBlocksPerRegion()`, and for every block whose plugin id is `darkmode_switcher` merges the old raw config into the block's `settings`, saves the block, and deletes `darkmode.config`. Run `drush updb` after updating from the pre-block-settings release.
