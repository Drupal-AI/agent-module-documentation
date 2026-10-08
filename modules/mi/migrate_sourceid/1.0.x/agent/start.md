<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate SourceId (migrate_sourceid) — agent index

**A block that links a migrated entity back to its source entity by reading core Migrate map tables — a reverse migrate_lookup.**

- **Version:** 1.0.x (from `1.0.5`) · **Package:** migrate
- **Core:** ^8 || ^9 || ^10 || ^11
- **Depends:** `drupal:migrate`.
- **Block:** `Plugin/Block/MigrateSourceidBlock` (only surface; no routes/perms/services).
- **Config:** `migrate_sourceid.settings` (`source_url`, `migrations` map per entity type); no admin form — edit config/settings.php then import + `cr`.
- **Security:** reads `migrate_map_*` tables via the DB API; no mutation, routes or public endpoints. It can expose source-system ids/URLs — restrict block visibility/roles accordingly.
