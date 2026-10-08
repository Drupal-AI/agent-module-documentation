<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Menu Condition (advanced_menu_condition) — agent index

Two core **Condition** plugins that show/hide a block (or any Condition consumer) based on whether
selected menu items are **active or in the active menu trail**, with multi-select and child
**inheritance**. Package `contrib`. **No module dependencies** (core Block/Layout provide the
Condition system). Core requirement `^10 || ^11`, PHP `^8.1`. License GPL-2.0-or-later. Version 3.1.0.

- **Both condition plugins, evaluation logic, the config form, and the Drush cleanup** →
  [plugins/conditions.md](plugins/conditions.md)

## What it provides (from source)

- **Condition plugin** `src/Plugin/Condition/MenuPosition.php` — id **`advanced_menu_position`**,
  label *"Advanced menu position"*. Shows when a selected menu link is active or an ancestor of the
  active link. Config key `menu_position`.
- **Condition plugin** `src/Plugin/Condition/NotMenuPosition.php` — id
  **`advanced_menu_position_not`**, label *"Advanced Menu position - Hide"*. Extends `MenuPosition`,
  negates `evaluate()`. Config key `not_menu_position`.
- **Drush command** `src/Commands/AdvancedMenuConditionCommands.php` (services in
  `drush.services.yml`, service `advanced_menu_condition.commands`): `advanced-menu-condition:cleanup`
  (alias **`amc-cleanup`**) removes the module's dependency/visibility/condition entries from all
  config. `advanced_menu_condition.install` `hook_uninstall()` runs it automatically.

## No routes / permissions / config objects

- No `*.routing.yml`, no `*.permissions.yml`, no `config/install`, no `config/schema`. The plugins are
  configured **inside** the host's condition UI (Block visibility, Layout Builder), not on their own
  page. Condition config is stored by the host block/section config.

## Mechanism (from source)

- Both plugins inject `menu.active_trail`, `menu.parent_form_selector`, `plugin.manager.menu.link`.
- `MenuPosition::evaluate()`: returns TRUE when nothing is selected; otherwise, for each selected
  `menu:parts` id it calls `menuActiveTrail->getActiveTrailIds($menu)` and returns TRUE if a selected
  trail id (`parts[1]:parts[2]`) is in the active trail — i.e. the block shows on that link and its
  descendants. `NotMenuPosition::evaluate()` returns the negation (and TRUE when nothing selected).
- `buildConfigurationForm()` renders a `#multiple` select whose options come from
  `menuParentFormSelector->getParentSelectOptions()`. No request/user-supplied input is read at
  evaluation time.

## Notes / caveats

- Selecting a parent menu item covers all of its children (inheritance) because evaluation matches
  against the whole active trail, not just the leaf link.
- `hook_uninstall()` shells out to the `amc-cleanup` Drush command via
  `Drush::processManager()`, so uninstall requires Drush to be available.
