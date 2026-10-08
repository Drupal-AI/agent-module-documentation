<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration Read-only Menu UI (config_readonly_menu_ui) — agent index

Add-on for **`config_readonly`** that carves a narrow exception so **content menu links**
(`menu_link_content` entities) can still be reordered while a site runs with
`$settings['config_readonly'] = TRUE`. The menu's **configuration** parts stay frozen.
Requires `config_readonly`, `menu_ui`, `menu_link_content`. Version **8.x-1.3**.
Core requirement `^8 || ^9 || ^10 || ^11`. Ships no permissions, routes, services or config schema.

## The problem it solves
A menu mixes two storage kinds: the **menu** and any module/config-defined links are configuration
(`system.menu.*`); **content menu links** are content entities. Core's menu overview form
(`Drupal\menu_ui\MenuForm`) saves the menu **config entity** on every submit, so `config_readonly`
blocks the entire form — editors cannot even move a purely content-defined link. Editors experience
this as *"I can't reorder the menu on the live site."*

## Mechanism (read the source — one `.module`, one form class)
- **`config_readonly_menu_ui.module`**
  - `hook_entity_type_alter()` — swaps the `menu` entity `add`/`edit` form class to
    `Drupal\config_readonly_menu_ui\ContentMenuForm`, **unconditionally** (so the cached form
    definition is right whenever read-only mode is later toggled on).
  - `hook_config_readonly_whitelist_patterns()` — returns `['system.menu.*']`, adding that pattern
    to `config_readonly`'s whitelist so menu-config writes are not blocked by the lock.
- **`src/ContentMenuForm.php`** (extends core `MenuForm`) — active only when `Settings::get('config_readonly')` is true:
  - `form()` — `#disabled = TRUE` on every top-level element **except `links` and `actions`**;
    adds a warning that parts of the form are read-only.
  - `submitForm()` — **skips `parent::submitForm()`** (which would save the menu config entity);
    calls only `submitOverviewForm()`, persisting content-link weight/enabled changes. The config
    entity is never written by this form.
  - `buildOverviewForm()` — for each link that is **not** a `MenuLinkContent` (a config-defined
    link): disables its `weight` and `enabled` widgets and hides its operations. If any such
    read-only link exists, removes the table's `#tabledrag` (drag-and-drop could change a config
    link's weight), so editors reorder via the weight `<select>` fields instead.

## Two things to understand
1. **Content-link weights are content, not config** — a reorder made on production does not travel
   with a config export; it stays on the environment where it was made.
2. **Mixed menus can trap positions** — the README warns you cannot place a content link between two
   config links of equal weight (Drupal's integer-weight model). Space config-link weights out, or
   keep menus single-kind.

## Solution docs
- [`agent/config/readonly-menu.md`](config/readonly-menu.md) — install/enable, the
  `settings.php` `config_readonly` flag that turns the behavior on, what the menu edit form
  does in read-only mode, the `system.menu.*` whitelist hook, and operating notes.

## Files
- `data.json` — metadata.
- `usage.md` — orientation + use cases.
- No permissions, Drush commands, routes, services or config schema.
