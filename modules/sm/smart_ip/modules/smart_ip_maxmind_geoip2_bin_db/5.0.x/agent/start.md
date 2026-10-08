# Smart IP MaxMind GeoIP2 binary database (smart_ip_maxmind_geoip2_bin_db) — agent index

A **Smart IP data source**: offline IP geolocation against a local MaxMind GeoIP2/GeoLite2 `.mmdb`
binary file. It ships no admin page of its own (`configure: smart_ip.settings`); it injects a
sub-form into Smart IP's settings form via the `smart_ip.display_admin_settings` event and becomes
active when you set `smart_ip.settings:data_source` = **`maxmind_geoip2_bin_db`**. Depends on
`smart_ip`; needs the `geoip2/geoip2` PHP library (reads the DB with `\MaxMind\Db\Reader` when the
`maxminddb` C extension is present, else `\GeoIp2\Database\Reader`).

- **Enable it, set its options (version/edition/credentials/auto-update/custom path), pick it as
  the active source, and how the DB is downloaded/refreshed** →
  [configure/settings.md](configure/settings.md)
- **The Smart IP query API, location keys, session/profile persistence** →
  `modules/sm/smart_ip/5.0.x/agent/api/location.md`
- **The data-source (event-subscriber) model shared by all sources** →
  `modules/sm/smart_ip/5.0.x/agent/extend/data-source.md`

Key facts:
- `sourceId()` = `maxmind_geoip2_bin_db`; `configName()` = `smart_ip_maxmind_geoip2_bin_db.settings`.
- Class `Drupal\smart_ip_maxmind_geoip2_bin_db\EventSubscriber\SmartIpEventSubscriber` (extends
  `SmartIpEventSubscriberBase`); service `smart_ip_maxmind_geoip2_bin_db.smart_ip_event_subscriber`
  tagged `event_subscriber`. No route, no permission, no Drush of its own.
- Config `smart_ip_maxmind_geoip2_bin_db.settings`: `version` (`licensed`|`lite`, default `lite`),
  `edition` (`city`|`country`, default `city`), `user_account`, `license_key`, `db_auto_update`
  (bool, default **true**), `bin_file_custom_path`.
- DB filenames: `GeoLite2-City.mmdb` / `GeoLite2-Country.mmdb` (lite),
  `GeoIP2-City.mmdb` / `GeoIP2-Country.mmdb` (licensed). Default store: `private://smart_ip`.
- Auto-download URL base: `https://download.maxmind.com/app/geoip_download`; weekly cron refresh
  (Wednesday). State key `smart_ip_maxmind_geoip2_bin_db.last_update_time`.
- `processQuery()` fills the location keys country, countryCode, region, regionCode, city, zip,
  latitude, longitude, timeZone, isEuCountry (and originalData).
