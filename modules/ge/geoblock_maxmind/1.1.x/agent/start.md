# MaxMind Data Source (geoblock_maxmind) — agent index

Adds a **MaxMind `.mmdb` GeoIP data source** to the **Geoblock** module. Resolves an IP to its
ISO country code from a local database file; optionally auto-downloads/refreshes that file.

Key facts:
- **Depends on `geoblock`.** This module supplies country *data*; the actual allow/deny rules
  live in Geoblock.
- Configure route: `geoblock_maxmind.settings` → `/admin/config/geoblock/maxmind`, permission
  **`administer geoblock`** (from the parent module — this module defines none).
- Only config: `geoblock_maxmind.settings` → **`download_url`** (a `uri`, default `''`).
- Database file path: **`private://geoblock_maxmind.mmdb`** (service parameter
  `geoblock_maxmind.database_path`). Lookups use the `librarymarket/maxmind-db-reader` library.
- Auto-update state: State key **`geoblock_maxmind.update_date`** (unix timestamp of next update).
- Provides the `GeoblockDataSource` plugin **`maxmind`**, the `geoblock_maxmind.downloader`
  service, and a `hook_cron` that re-downloads weekly when a `download_url` is set.

Docs:
- **Settings (`download_url`), db path, update State, drush** → [configure/settings.md](configure/settings.md)
- **Plugin + Downloader + cron mechanism** → [api/mechanism.md](api/mechanism.md)
