# Smart IP IP2Location binary database (smart_ip_ip2location_bin_db) — agent index

A **Smart IP data source**: offline IP geolocation against a local IP2Location **BIN** database
(separate IPv4 and IPv6 files) read with `ip2location/ip2location-php`. It ships no admin page of its
own (`configure: smart_ip.settings`); it injects a sub-form into Smart IP's settings form via the
`smart_ip.display_admin_settings` event and becomes active when you set
`smart_ip.settings:data_source` = **`ip2location_bin_db`**. Depends on `smart_ip`.

- **Enable it, set version/edition/token/caching/auto-update/custom path, pick it as the active
  source, and how the BIN files are downloaded/refreshed** →
  [configure/settings.md](configure/settings.md)
- **The Smart IP query API, location keys, session/profile persistence** →
  `modules/sm/smart_ip/5.0.x/agent/api/location.md`
- **The data-source (event-subscriber) model shared by all sources** →
  `modules/sm/smart_ip/5.0.x/agent/extend/data-source.md`

Key facts:
- `sourceId()` = `ip2location_bin_db`; `configName()` = `smart_ip_ip2location_bin_db.settings`.
- Class `Drupal\smart_ip_ip2location_bin_db\EventSubscriber\SmartIpEventSubscriber` (extends
  `SmartIpEventSubscriberBase`); service `smart_ip_ip2location_bin_db.smart_ip_event_subscriber`
  tagged `event_subscriber`. No route, no permission, no Drush of its own.
- Config `smart_ip_ip2location_bin_db.settings`: `version` (`licensed`|`lite`, default `lite`),
  `edition` (product code `DB1`..`DB24`; lite: `DB1/DB3/DB5/DB9/DB11`; default `DB11`), `token`
  (licensed download token), `db_auto_update` (bool, default **false**), `caching_method`
  (`no_cache`|`memory_cache`|`shared_memory`, default `no_cache`), `bin_file_custom_path`.
- BIN filenames: `IP2LOCATION-LITE-<edition>.BIN` / `…-<edition>.IPV6.BIN` (lite);
  `IP-<PRODUCT>.BIN` / `IPV6-<PRODUCT>.BIN` (licensed). Default store: `private://smart_ip`.
- Auto-download (licensed only) from `https://www.ip2location.com/download`; **lite auto-download is
  not supported** (needs an interactive login). Monthly cron refresh (first Wednesday). State keys
  `…last_update_time`, `…current_ip_version_queue`.
- `processQuery()` fills the location keys country, countryCode, region, regionCode, city, zip,
  latitude, longitude, timeZone, isEuCountry (and originalData).
