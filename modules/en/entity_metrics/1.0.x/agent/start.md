<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Metrics (entity_metrics) — agent index

Records **node page views** and **media file downloads** into its own `entity_metrics_data` table, and optionally enriches each event with an approximate visitor location from a **local MaxMind GeoLite2-City `.mmdb`** (no remote geo API). Package `Statistics`. Core `^10 || ^11`. License GPL-2.0-or-later. Version dir 1.0.x (installed 1.0.0-beta4).

- **Dependencies:** `node` (core) and contrib `geoip_autoupdate`; Composer also pulls `maxmind-db/reader`. Front-end map uses Leaflet from a CDN. No `key` dependency, no external analytics credentials.
- **Config:** `entity_metrics.settings` (keys `cookie`, `geolocation_enabled`, `geolocation_database`, `geolocation_batch_size`). Settings form at `/admin/config/system/entity-metrics` (perm `administer site configuration`). No custom permissions, no custom plugin types.

## Solution docs
- **Recording & count endpoints, JS, tables** → [api/tracking.md](api/tracking.md)
- **Geolocation backfill service, cron, Drush** → [api/geolocation.md](api/geolocation.md)
- **Blocks (view-count + map)** → [blocks/blocks.md](blocks/blocks.md)
- **Settings form, config object & schema** → [config/settings.md](config/settings.md)

## What it provides (from source)
- Routes (`entity_metrics.routing.yml`): `entity_metrics.write_data` POST `/entity-metrics/visit`; `entity_metrics.view` GET `/entity-metrics/{type}/{id}` (`type: node|media`); `entity_metrics.settings` form. First two require `access content`.
- Controller `VisitController` (`recordVisit`, `getVisits`, `checkFlood`).
- Service `entity_metrics.geolocation` → `GeolocationBackfill` (`process`, `retryUnknown`).
- Drush service `entity_metrics.commands` → `GeolocationCommands` (`entity-metrics:geolocate`, `entity-metrics:geoip-update`).
- Blocks: `entity_metrics_map` (`MapBlock`), `entity_metrics_node_history` (`NodeHistoryBlock`).
- Hooks (`entity_metrics.module`): `preprocess_node` (attaches record JS on canonical node), `file_download` (records media downloads on `fedora://`), `cron` (batch enrich), `page_bottom` (MaxMind attribution).
- Install (`entity_metrics.install`): creates tables `entity_metrics_data` and `entity_metrics_regions`; updates `10001`, `10002`.
