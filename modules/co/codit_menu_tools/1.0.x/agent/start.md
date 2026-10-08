<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Codit: Menu Tools (codit_menu_tools) — agent index

A **developer-only PHP library** for manipulating `menu_link_content` menu links in code. It ships
**no routes, controllers, forms, permissions, config, services, templates, hooks, or UI** — just
plain classes you instantiate (`new MenuManipulator('menu_machine_name')`) from `hook_update_N()`,
`hook_post_update_N()`, Drush deploy hooks, or one-off scripts. Package `Development`. Core
`^10 || ^11`. License GPL-2.0-or-later. Installed **1.0.4** (version dir `1.0.x`).

## Dependencies

- Drupal module: **`menu_link_content`** (core) — the only dependency (`.info.yml`). No Composer
  library requirements.

## What it provides (from source)

The entire surface is under `src/` (PSR-4 `Drupal\codit_menu_tools\`):

- **`MenuManipulator`** (`src/MenuManipulator.php`) — the main class; extends `MenuManipulatorBase`,
  implements `MenuManipulatorInterface`. Public write methods: `addMenuItem()`,
  `changeMenuItemTitle()`, `changeMenuItemParent()`, `changeMenuItemSibling()`, `changeMenuItem()`,
  `moveMenuItem()`, `matchPattern()`, `menuSeparate()`.
- **`MenuManipulatorBase`** (abstract, `src/MenuManipulatorBase.php`) — construction + read helpers:
  `getMenuTree()`, `loadMenuItemByNameAndParentName()`, `loadMenuItemByNameAndParentId()`,
  `findMenuItemDetailsByName()`, static `getAllMenuNames()`, and protected weight-spacing internals
  (`separateTreeBranch()`, `mimicDrupalMenuSort()`, `preCheckRequiredItemValues()`,
  `clearMenuTreeCache()`).
- **`MenuInsert`** (`src/MenuInsert.php`) — empty legacy passthrough subclass of `MenuManipulator`,
  kept only for backward compatibility with old code that used the `MenuInsert` name.
- **Interfaces**: `MenuManipulatorInterface` (write methods) extends `MenuManipulatorBaseInterface`
  (read methods).

## Key design facts (from source)

- The constructor uses the `\Drupal::` static service locator (entity type manager,
  `plugin.manager.menu.link`, `\Drupal::menuTree()`, `\Drupal::logger('codit_menu_tools')`)
  **on purpose** — the class is meant to run in update-hook/script contexts where dependency
  injection is unavailable. It is **not** a service; there is no `.services.yml`.
- Items are identified **by human-readable title** (optionally scoped by parent title), not by id.
  When multiple items share a title, methods operate on the **last** match and log a notice.
- Most methods call `menuSeparate()` to re-space all item weights (multiples of 2) before/after a
  change, preserving order/hierarchy while leaving gaps to insert into.
- Failures are non-fatal: missing item/parent/sibling → a logged `notice` and a `FALSE`/`NULL`
  return, not an exception. The only exceptions thrown are for a missing/empty menu name
  (`getMenuTree`) or missing required title/destination on `addMenuItem` (`preCheckRequiredItemValues`).

## Solution docs

- **Full method reference (signatures, behaviour, return values, examples)** →
  [api/menu-manipulator.md](api/menu-manipulator.md)
