<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Content Permissions (block_content_permissions) — agent index

**Adds granular per-block-type create/update/delete permissions plus block-content-type administration, replacing core's single `administer blocks`.**

- **Version:** 8.x-1.x (info.yml `8.x-1.11`)
- **Core:** ^8 || ^9 || ^10 (Drupal 10 contrib; no D11 release)
- **Dependencies:** `block_content` (core)
- **Permissions:** static `administer block content types` (restrict access), `view restricted block content`; dynamic per-bundle `create|update any|delete any <type> block content` via `Permissions::get` (`block_content_permissions.permissions.yml`).
- **Hooks:** `block_content_access`, `block_content_type_access`, `block_content_create_access`, `views_query_alter`/`views_pre_build` on the `block_content` view (`.module`).
- **Routes/services:** none (`AccessControlHandler.php` is a helper; no routing.yml).

**Security:** pure access-policy layer — no routes, no request input, no anonymous or mutating endpoints. Tightens (never loosens) core block permissions.
