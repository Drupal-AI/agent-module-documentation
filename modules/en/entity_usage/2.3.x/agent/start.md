<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Usage (entity_usage) — agent index

Tracks which entities reference which (source → target) and shows "where used" info.
Legacy **2.x** maintenance branch; `core_version_requirement: ^10.3 || ^11`. No hard
module deps (many optional integrations are dev/test only). Config UI: **Admin → Config →
Content Authoring → Entity Usage Settings** (`/admin/config/entity-usage/settings`, route
`entity_usage.settings.form`).

Provides: an `EntityUsageTrack` plugin type (`Plugin/EntityUsage/Track`), the
`entity_usage.usage` service, three permissions, a Drush command, config schema, a per-entity
"Usage" local task, a batch/bulk rebuild tool, and Views integration.

- Settings: tracked source/target types, plugins, Usage tab, edit/delete warnings, site domains, page size → [configure/settings.md](configure/settings.md)
- Rebuild the usage table (batch UI form) → [configure/batch-update.md](configure/batch-update.md)
- Tracking methods & writing an EntityUsageTrack plugin → [plugins/track.md](plugins/track.md)
- Read/write usage data in code (`entity_usage.usage`) → [api/entity-usage.md](api/entity-usage.md)
- Block a tracking record via hook → [hooks/entity_usage.md](hooks/entity_usage.md)
- Drush: recreate all/some statistics → [drush/entity_usage.md](drush/entity_usage.md)
- Permissions → [permissions/entity_usage.md](permissions/entity_usage.md)

New in 2.3 vs 2.2: the Drush recreate command takes `--entity-types` to rebuild only chosen
types; the usage report is aware of the contrib **Trash** module (shows trashed sources with
an "(in trash)" marker); the service has an internal bulk-insert path (`entity_usage_bulk`
table) used by the batch rebuild.
