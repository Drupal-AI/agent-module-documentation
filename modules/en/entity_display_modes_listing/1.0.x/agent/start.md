<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Display Modes Listing (entity_display_modes_listing) — agent index

Adds each **non-default view/form display mode** of a node type or taxonomy vocabulary as its own
**operation link** on the admin bundle-listing pages. Package `YMCA`. Core `^8 || ^9 || ^10 || ^11`.
PHP `>=8.1`. License GPL-2.0-or-later. Version 1.0.9.

## What it actually is

- **One file, one hook.** `entity_display_modes_listing.module` implements
  `hook_entity_operation()` (`entity_display_modes_listing_entity_operation()`). No routes, no
  controllers, no forms, no permissions, no services, no config/schema, no `src/`, no Drush.
- **No declared dependencies.** The hook uses `NodeTypeInterface` / `VocabularyInterface` via
  `instanceof`, so it only acts when node / taxonomy are present; it does not require them.
- It only augments the **operations column** on pages the admin already sees; it stores nothing and
  needs no configuration.

- **The hook, which pages it fires on, and the links it builds** →
  [api/entity-operation-hook.md](api/entity-operation-hook.md)
