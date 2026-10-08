<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CMS Content Sync - Health — agent index

Read-only "Sync Health" reporting for Content Sync (`cms_content_sync`). Adds an admin dashboard
at `/admin/content/sync-health` that summarizes push/pull failure counts, Flow version drift,
connected Sync Core status/logs, the running-vs-latest module version, and a bundled View of
per-entity sync status. It reads data the parent already tracks (`EntityStatus`, `Flow`, `Pool`) —
no syncing happens here. Submodule — see the parent index
[`../../../../3.2.x/agent/start.md`](../../../../3.2.x/agent/start.md).

Dependencies: `cms_content_sync`, `cms_content_sync_views`, `dynamic_entity_reference`, core
`views`. No settings page (`configure` = null), no Drush, no plugins.

- **The access permission** → [permissions/permissions.md](permissions/permissions.md)
- **The dashboard routes, controllers, theme hooks & templates** → [theme/dashboard.md](theme/dashboard.md)
- **The bundled entity-status View** → [views/entity-status.md](views/entity-status.md)

Key facts:
- Permission `access sync health` — the only permission; gates every route.
- Routes: `entity.cms_content_sync.sync_health` (`/admin/content/sync-health`, `Controller\SyncHealth::overview`);
  `entity.cms_content_sync.sync_health.version_mismatches`
  (`/admin/content/sync-health/pushing/version-mismatches`, `Controller\VersionMismatches::aggregate`, batch).
- Bundled View `content_sync_entity_status` (`config/install/views.view.content_sync_entity_status.yml`),
  surfaced as the "Entity Status" tab via `view.content_sync_entity_status.entity_status_overview`.
- Theme hooks `cms_content_sync_sync_health_overview` / `_push` / `_pull`
  (templates in `templates/cms_content_sync_sync_health_*.html.twig`).
- `hook_install()` sets module weight to 99; `hook_uninstall()` deletes the bundled view config.
