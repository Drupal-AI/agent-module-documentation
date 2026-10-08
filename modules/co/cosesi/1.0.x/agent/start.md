<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Color Scheme Switcher (cosesi) — agent index

Frontend Light / System(Auto) / Dark color-scheme switcher for Drupal 11. Injects an inline
`<style>`+`<script>` early in `<head>` that set the CSS `color-scheme` custom property on `:root`
and toggle a configurable class on `<html>`; persists the choice in `localStorage`. Ships a
placeable block with Buttons and Dropdown widgets. Version 1.0.0-alpha1.

- Requires PHP `>= 8.4`, Drupal core `^11.3`. Depends on core `config`. Suggests `drush/drush ^13.7`.
- No custom permissions file; the settings form uses the core `administer themes` permission.
- Provides config schema; provides one hidden dev Drush command (`cosesi:build`). No new plugin types.

## Provides

- Block plugin `cosesi_switcher` (`src/Plugin/Block/SwitcherBlock.php`) — admin label "Color Scheme Switcher".
- Render elements `cosesi_switcher_buttons` / `cosesi_switcher_dropdown`
  (`src/Element/SwitcherButtons.php`, `SwitcherDropdown.php`, base `SwitcherBase.php`).
- Theme hooks `cosesi_switcher_buttons` / `cosesi_switcher_dropdown` (`src/Hook/ThemeHooks.php`,
  templates in `templates/`).
- Service `Drupal\cosesi\ThemeSettings\ProviderInterface` → `Provider` (builds the head CSS/JS).
- Icon pack `cosesi_solid` (`cosesi.icons.yml`) — sun / sun-and-moon / moon SVGs.
- JS libraries `cosesi/switcher_api`, `cosesi/switcher_widget_buttons`, `cosesi/switcher_widget_dropdown`.
- Config object `cosesi.theme_settings` (schema `config/schema/cosesi.schema.yml`).

## Routes

- `cosesi.theme_settings.edit` — `/admin/appearance/cosesi-theme-settings`, form `ThemeSettings\EditForm`,
  permission `administer themes`. Local task under `system.themes_page`.

## States

`light` → `color-scheme: light`; `system` → `light dark` (resolves to OS `prefers-color-scheme`);
`dark` → `dark`.

## Solution docs

- [Configuration & theme settings](config/settings.md)
- [Block & switcher render elements](plugins/switcher-block.md)
- [Frontend head injection & JS API](api/switcher-api.md)
