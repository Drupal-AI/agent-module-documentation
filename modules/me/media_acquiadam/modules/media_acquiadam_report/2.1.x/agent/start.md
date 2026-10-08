# Media: Acquia DAM - Reporting — agent index

Submodule of [media_acquiadam](../../../../2.1.x/agent/start.md) that reports Acquia DAM asset usage via
Entity Usage + a Views report. No settings page (`configure` null), no own permissions, no Drush.
Requires `entity_usage` and `views`.

Key facts:
- Ships Views view `acquia_dam_reporting` (display `asset_report`); a local task **Acquia DAM Usage** at
  route `view.acquia_dam_reporting.asset_report` under the media collection (`/admin/content/media`).
- `hook_views_query_alter()` (`media_acquiadam_report.module`) restricts the report to DAM media bundles
  (`media_acquiadam_get_bundle_asset_id_fields()`), adding a `media_field_data.bundle IN (…)` condition.
- `hook_views_data_alter()` adds a `media.acquiadam_source_id` Views field (the asset's DAM source id).
- Services (`media_acquiadam_report.services.yml`):
  - `AcquiadamUsageSubscriber` — subscribes to Entity Usage `Events::USAGE_REGISTER` → `mediaUsageChange()`
    to keep DAM asset usage current.
  - `RouteSubscriber` — registers the report route.
