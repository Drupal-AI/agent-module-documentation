<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VideoJS Media Migration (videojs_media_migrate) — agent index

**Migrate-API module that converts legacy `videojs_mediablock` Block Content into `videojs_media` content entities.**

- **Version:** 1.0.x
- **Core:** ^10.3 | ^11
- **Dependencies:** migrate, migrate_plus, migrate_tools, videojs_media
- **Interface:** no routes, no permissions, no services — Migrate config only
- **Run:** `drush migrate:import <migration_id>` (or Migrate Tools UI)
- **Security:** No HTTP surface; migrations run under the operator's Drush/permissions. No security findings.
