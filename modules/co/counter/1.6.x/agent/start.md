<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Counter (counter) — agent index

Self-hosted page-hit / visitor counter. Records one DB row per web request (IP, URL,
timestamp, uid, node id + type, detected browser/platform) into the `counter` table, then
exposes aggregate counts through blocks, two admin report pages, and Views. No external
service — all data stays in the site's database.

- **Dependencies:** none required (core only). `node` is optional (used for node counts /
  top-node report). `views` optional (base-table integration). `composer.json` declares
  `matomo/device-detector ^5.0.3`, but the code does NOT use it — browser/platform detection
  is hand-rolled `preg_match` in `CounterUtility`.
- **Configure route:** `counter.counter_settings` → `/admin/config/counter` (a menu-block
  landing page listing Basic / Advanced / Initial / Dashboard / Statistics children).
- Defines **1 permission**, **no drush commands**, **config schema** (`counter.settings`),
  **no new plugin types** (it ships 3 core Block plugins). Implements `hook_cron`,
  `hook_theme`, `hook_views_data`, `hook_help`, and invokes 2 alter hooks for integrators.

Solution docs:
- **How visits get recorded + the DB table** → [events/recording.md](events/recording.md)
- **Settings, config object, and the admin pages** → [configure/settings.md](configure/settings.md)
- **The three counter blocks** → [blocks/blocks.md](blocks/blocks.md)
- **Read/query services (CounterUtility, StatisticsService) + report routes** → [api/services.md](api/services.md)
- **Alter hooks + cron cache-tag** → [hooks/hooks.md](hooks/hooks.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)
- **Views integration** → [views/views.md](views/views.md)

Key facts (real machine names):
- Config object: `counter.settings` (20 integer keys, all default-on except the three
  `counter_initial_*`, `counter_skip_admin`).
- DB table: `counter` (PK `counter_id`; cols `ip`, `created`, `url`, `uid`, `nid`, `type`,
  `browser_name`, `browser_version`, `platform`).
- Services: `counter.counter_utility`, `counter.statistics_service`,
  `counter.counter_event_subscriber` (kernel.request), `counter.middleware`
  (http_middleware, priority 210).
- Blocks: `counter_block`, `configurable_counter_block`, `counter_day_block`.
- Routes: `counter.counter_settings`, `counter.basic`, `counter.advanced`, `counter.initial`,
  `counter.dashboard`, `counter.statistics`, `counter.statistics.data`.
- Permission: `administer counter`.
- Cache tag: `counter_data_refresh` (invalidated by `hook_cron`).
- `.info.yml` reports the legacy `version: '8.x-1.6'`; branch dir is `1.6.x`.
