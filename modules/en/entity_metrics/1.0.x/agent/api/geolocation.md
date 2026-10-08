<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Local geolocation enrichment

Source: `src/GeolocationBackfill.php`, `entity_metrics.services.yml`, `src/Commands/GeolocationCommands.php`, `drush.services.yml`, `entity_metrics.module` (`hook_cron`), `entity_metrics.install`.

All lookups read a **local** MaxMind GeoLite2-City `.mmdb`; no visitor IP is sent to any remote API. The `.mmdb` file itself is downloaded/refreshed by the `geoip_autoupdate` dependency (which holds the MaxMind account/license credentials, not this module).

## Service `entity_metrics.geolocation` → `GeolocationBackfill`
Constructed from `database`, `config.factory`, `file_system`, `lock`, `datetime.time`. Uses `MaxMind\Db\Reader`.

- `openReader()` — resolves `geolocation_database` (config), requires a `private://` or absolute path, requires the resolved path to be an existing readable **local** file (`stream_is_local`), and requires the DB `databaseType` to contain `City`; otherwise throws. No remote URLs.
- `location(?array $record)` (static) — normalizes a City record to `country` (validated `^[A-Z]{2}$`), `region`, `city` (both trimmed to 255), and `latitude`/`longitude` (validated ranges, else NULL). Returns NULL if no valid country.
- `region(array $location)` — computes a SHA-256 fingerprint (`location_key`) over the location, reuses an existing `entity_metrics_regions` row by key or by field match, else inserts a new region row. De-duplicates so many events share one region.
- `process(int $limit = 500)` — validates `1..10000`, acquires lock `entity_metrics.geolocation` (300s), opens a transaction, selects up to `$limit` pending rows (`geolocation_status = 0`) **older than 60s** (so recent IPs remain for the flood check), resolves each public IP (`FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE`) via the reader, updates `region_id` + `geolocation_status` (1 located / 2 unknown), and **clears `ip_address`** for resolved rows and private/invalid rows (unresolved public IPs are kept for retry). Invalidates the `entity_metrics_regions` cache tag; returns `{processed, located, unknown, last_id}`. Rolls back and hides the IP on reader errors.
- `retryUnknown()` — under the same lock, resets `geolocation_status` from 2 back to 0 for rows that still have an `ip_address`.

## Cron
`entity_metrics_cron()` — no-op unless `geolocation_enabled`; calls `entity_metrics.geolocation::process(geolocation_batch_size ?: 500)`; logs failures without IPs/identifiers.

## Drush (`drush.services.yml` → `GeolocationCommands`)
- `entity-metrics:geolocate` — options `--batch-size` (1–10000, default 500) and `--retry-unknown`. Loops `process()` until a short batch, logging progress; run from CLI to backfill outside the web timeout.
- `entity-metrics:geoip-update` — calls `geoip_autoupdate.updater::forceUpdate()` to download/refresh the local database.
