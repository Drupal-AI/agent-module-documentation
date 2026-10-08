<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CMS Content Sync - Migrate Acquia Content Hub — agent index

One-time helper that bootstraps a Content Sync setup from an existing **Acquia Content Hub**
configuration: it reads which entity types/bundles Acquia was syndicating and generates the
equivalent Content Sync **Pool** + **Flow** config plus the `EntityStatus` bookkeeping. Hard-depends
on `acquia_contenthub`. It produces standard `cms_content_sync_pool` / `cms_content_sync_flow`
config — operate those via the parent docs
([`../../../../3.2.x/agent/configure/flows-and-pools.md`](../../../../3.2.x/agent/configure/flows-and-pools.md)).
Parent index: [`../../../../3.2.x/agent/start.md`](../../../../3.2.x/agent/start.md).

Dependencies: `cms_content_sync`, `acquia_contenthub`. No config entity, permission or plugins of
its own; `configure` = null. Its routes reuse the parent permission `administer cms content sync`.

- **The migration forms (UI) and what they create** → [configure/migrate.md](configure/migrate.md)
- **The `mach` Drush command** → [drush/commands.md](drush/commands.md)

Key facts:
- Routes: `cms_content_sync_migrate_acquia_content_hub.migrate_pushing`
  (`/admin/config/services/cms_content_sync/migrate-acquia-content-hub`, form `Form\MigratePush`) and
  `...migrate_pulling` (`.../acquia-contenthub/contenthub_filter/migrate-content-hub-filter/{content_hub_filter_id}`,
  form `Form\MigratePull`). Both require `administer cms content sync`.
- Default pool created: machine name `content`, label `Content` (`MigrationBase::DEFAULT_POOL_MACHINE_NAME`).
- `hook_entity_operation_alter()` adds a **"Migrate to Content Sync"** operation on each
  `ContentHubFilter` entity, linking to the pulling form.
- Legacy Drush command `content_sync_migrate_acquia_content_hub` (alias `mach`), defined in
  `cms_content_sync_migrate_acquia_content_hub.drush.inc`.
- Attaches the `cms_content_sync_migrate_acquia_content_hub/migrate-form` JS library on the push form.
