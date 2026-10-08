<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Sync (cms_content_sync) — agent index

Syndicates content entities between Drupal sites through an external content-sync.io
"Sync Core" backend. Two config entities drive it: **Pool** (`cms_content_sync_pool`, the
shared channel) and **Flow** (`cms_content_sync_flow`, what this site pushes/pulls).
Serialization is delegated to pluggable **entity handlers** and **field handlers**.
Requires an external backend — nothing actually syncs without one; ground work in the
config entities and services, not live sync.

- **Register the site, create/inspect Pools and Flows, config keys** →
  [configure/flows-and-pools.md](configure/flows-and-pools.md)
- **Entity & field handler plugin types (how an entity/field is serialized)** →
  [plugins/handlers.md](plugins/handlers.md)
- **Events to extend the sync payload; PushIntent/PullIntent; EntityStatus; tokens** →
  [api/events.md](api/events.md)
- **Drush commands (register, push, pull, configuration-export, reset, check-flags)** →
  [drush/commands.md](drush/commands.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config entity IDs: `cms_content_sync_flow` and `cms_content_sync_pool`
  (config prefixes `cms_content_sync.flow.*`, `cms_content_sync.pool.*`).
- Configure route: `cms_content_sync.site` → `/admin/config/services/cms_content_sync/site`.
- A Flow needs a `variant` (`simple` or `per-bundle`); only `simple` has a controller in 3.2.x.
- Credentials are encrypted with bundled `encrypt`/`real_aes` + a `key.key.cms_content_sync`
  key entity (whose shipped default value is a placeholder that must be replaced).
