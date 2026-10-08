<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sector Legacy (sector_legacy) — agent index

Backward-compatibility **metapackage** for the **Sector** Drupal distribution (Sparks Interactive,
sector.org.nz). Package `Sector`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.6.

## What it actually is

- The **top-level module has no code** — no `.module`, routes, services, permissions, config, or
  hooks. Its `.info.yml` even says it "does not need to be enabled". You install the project for
  two things:
  1. **Composer constraints**: `composer.json` `require` pins the contrib modules older Sector
     builds depend on — `antibot ^2.0`, `autologout ^1||^2`, `components ^3.0@beta`,
     `current_page_crumb ^1.6`, `ds ^3.3`, `field_delimiter ^2.0`,
     `inline_entity_form ^1.0@rc||^3.0@rc`, `radix ^4.15`, `view_unpublished ^1.3`,
     `webform ^6.2`, `xmlsitemap ^1.4||^2.0`. (These are project-level Composer deps, **not**
     Drupal `dependencies:` in the info.yml — enabling the parent does not force-enable them.)
  2. **Three self-contained submodules**, each documented in its own tree:
- **admin_ui_toggle** — one block that toggles admin chrome via a body class →
  [modules/admin_ui_toggle/1.x/agent/start.md](../../modules/admin_ui_toggle/1.x/agent/start.md)
- **sector_blocks** — five custom distribution blocks (menu controls, Search API boxes, search
  fly-out, release-notes banner) →
  [modules/sector_blocks/1.x/agent/start.md](../../modules/sector_blocks/1.x/agent/start.md)
- **sector_utils** — editor-UX form/preprocess/attachments tweaks + one permission →
  [modules/sector_utils/1.x/agent/start.md](../../modules/sector_utils/1.x/agent/start.md)

- **Install & composition** (what to `composer require`, what to `drush en`, what the parent does
  NOT provide) → [overview.md](overview.md)

## Notes

- Incompatible with Drupal 9; intended for Sector 9 → Sector 10 legacy support.
- Enable only the submodule(s) you need — they are independent. There is nothing to configure on
  the parent.
