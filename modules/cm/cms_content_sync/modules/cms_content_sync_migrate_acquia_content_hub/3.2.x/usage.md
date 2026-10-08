<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A migration helper that bootstraps a Content Sync setup (Pools and Flows) from an existing Acquia Content Hub configuration, so sites already using Acquia Content Hub can move to Content Sync without configuring syndication from scratch.

---

This submodule reads a site's Acquia Content Hub configuration and generates the equivalent Content Sync configuration. It exposes two migration forms — a "Pushing" form at `/admin/config/services/cms_content_sync/migrate-acquia-content-hub` (`Form\MigratePush`) and a per-filter "Pulling" form under the Acquia Content Hub filter UI (`Form\MigratePull`) — that ask for the Sync Core `backend_url` and `authentication_type` and then create the matching Content Sync entities. Its `MigrationBase` logic creates a default Pool (machine name `content`, label `Content` — `DEFAULT_POOL_MACHINE_NAME`) via `Pool::createPool()`, builds a Flow keyed to that pool, and creates the `EntityStatus` records for already-known entities (`CreateStatusEntities`). It also ships a legacy Drush command, `content_sync_migrate_acquia_content_hub` (alias `mach`), with required options `--type`, `--backend_url`, `--authentication_type` and optional `--site_id`, `--node_push_behavior`, `--sync`. It hard-depends on `acquia_contenthub` and has no config entity, permission or plugins of its own; its job is a one-time setup that produces standard `cms_content_sync_pool` / `cms_content_sync_flow` config.

---

- Migrate an Acquia Content Hub site to Content Sync without hand-building Flows and Pools.
- Generate a default Content Sync Pool (machine name `content`) from existing Acquia config.
- Create a Content Sync Flow that mirrors the site's current Acquia Content Hub setup.
- Reuse an Acquia Content Hub filter to configure a Content Sync pull flow.
- Point the generated pool at a Sync Core `backend_url` during migration.
- Choose the authentication type (`cookie` or `basic_auth`) for the migrated pool.
- Run the migration from the UI via the Pushing form under Content Sync's site page.
- Run the migration per Acquia Content Hub filter via the Pulling form.
- Script the migration with `drush mach --type=... --backend_url=... --authentication_type=...`.
- Preserve the site identifier by passing `--site_id` (or infer it from Acquia's client name).
- Set default node push behavior (`automatically`/`manually`) during migration.
- Create EntityStatus bookkeeping for entities already known to Acquia Content Hub.
- Reduce the effort of switching syndication platforms on an established multi-site.
- Keep the same default pool naming (`content`) so downstream config is predictable.
- Migrate pushing and pulling configuration separately as needed.
- Onboard an Acquia customer to Content Sync as part of a platform change.
- Produce standard cms_content_sync_pool/flow config entities that behave like hand-made ones.
- Bootstrap syndication config in CI using the Drush migration command.
