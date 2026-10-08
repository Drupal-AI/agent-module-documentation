# Analytics API — agent index

A plugin framework + admin UI for third-party analytics services. Defines the `analytics_service`
plugin type and an `analytics_service` config entity, plus shared privacy settings. Managed at
`/admin/config/services/analytics` (`configure` = `entity.analytics_service.collection`). No
external deps in the base module.

- **Admin UI, the `analytics_service` config entity, the shared `analytics.settings` (DNT,
  anonymize_ip, disable_page_build), enable/disable routes** →
  [configure/services.md](configure/services.md)
- **The `analytics_service` plugin type: implementing one, `getOutput()`/`canTrack()`, alter
  hooks, bundled plugins** → [plugins/analytics-service.md](plugins/analytics-service.md)
- **Permissions (`administer analytics`, `bypass all analytics services`)** →
  [permissions/permissions.md](permissions/permissions.md)

Submodules (own docs, all hidden):
- `analytics_google` → [../../modules/analytics_google/1.0.x/agent/start.md](../../modules/analytics_google/1.0.x/agent/start.md)
- `analytics_amp` → [../../modules/analytics_amp/1.0.x/agent/start.md](../../modules/analytics_amp/1.0.x/agent/start.md)
- `analytics_piwik` → [../../modules/analytics_piwik/1.0.x/agent/start.md](../../modules/analytics_piwik/1.0.x/agent/start.md)

Key facts:
- `analytics_page_bottom()` renders each enabled service whose `canTrack()` passes; `canTrack()`
  denies on admin routes + for `bypass all analytics services` holders.
- Base plugins: `google_tag_manager`, `google_optimize` (in the main module).
- Everything is behind `administer analytics`; emitted snippets are admin-authored JS by design.
