<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sector Legacy — install & composition

## Install

- `composer require drupal/sector_legacy` — this is the main reason to use the project. The
  `require` block pulls the pinned contrib set legacy Sector sites expect (see start.md list).
- You do **not** enable `sector_legacy` itself (no code). Enable the submodules you want:
  `drush en sector_blocks admin_ui_toggle sector_utils` (any subset).

## Files that make up the project

- `sector_legacy.info.yml` — metadata only; `package: Sector`, `core_version_requirement:
  ^10 || ^11`, **no `dependencies:`** and no `configure` route.
- `composer.json` — the pinned `require` map (11 contrib modules); homepage `sector.org.nz`;
  `minimum-stability: dev`, `prefer-stable: true`; adds the drupal.org Composer repo.
- `README.md` / `LICENSE.txt` — one-line readme; GPL-2.0-or-later.
- `modules/admin_ui_toggle/`, `modules/sector_blocks/`, `modules/sector_utils/` — the three
  submodules (documented separately).

## What it does NOT provide

- No parent-level routes, controllers, services, plugins, permissions, config objects, config
  schema, update hooks, or Drush commands. All functionality lives in the submodules.
- The Composer `require` entries are **project dependencies**, not Drupal module dependencies —
  installing the parent module does not auto-enable antibot/webform/radix/etc.; Composer merely
  makes them available at the pinned versions.
