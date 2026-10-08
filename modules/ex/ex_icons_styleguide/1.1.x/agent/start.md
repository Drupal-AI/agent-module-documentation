<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EX Icons Styleguide (ex_icons_styleguide) — agent index

Bridge module: adds a preview of every ex_icons icon to the Styleguide module's per-theme styleguide page. Version **1.1.0**, core `^8 || ^9 || ^10 || ^11`, package `Custom`, license GPL-2.0-or-later.

## What it provides
- **One plugin instance**: a Styleguide generator plugin `ExIconsStyleguide` (plugin id `ex_icons_styleguide`, label "External-use Icons") in `src/Plugin/Styleguide/ExIconsStyleguide.php`, extending `Drupal\styleguide\Plugin\StyleguidePluginBase`.
- Nothing else: **no** routes, controllers, permissions, config objects/schema, entities, services, hooks, Drush commands, libraries, submodules, or new plugin types.

## How it works
- The plugin's `items()` returns a `group` "External-use icons" whose content is a CSS-grid `container`.
- It calls `ex_icons.manager` → `ExIconsManagerInterface::getIconOptions()` for the icon list, and renders each icon via the `ex_icon` theme hook (`#theme => 'ex_icon'`, 40x40) with its ID shown in a `<small>` `html_tag`.
- Access, page and URL come entirely from the Styleguide module: `/admin/appearance/styleguide/THEME_NAME` (permission `view style guides`, owned by styleguide).

## Dependencies
- Drupal modules: `ex_icons` (composer `^1.6`), `styleguide` (composer `^2.0`).
- Services consumed: `styleguide.generator`, `ex_icons.manager`.

## Operate it
- No configuration. Enable the module (`drush en ex_icons_styleguide -y`) and view any theme's styleguide.

## Solution docs
- [Styleguide plugin](plugins/styleguide.md) — the plugin, its render output, and how to operate/verify it.
