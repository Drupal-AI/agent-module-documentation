# Smart IP MaxMind GeoIP2 Precision web service (smart_ip_maxmind_geoip2_web_service) — agent index

A **Smart IP data source**: geolocation via MaxMind's hosted **GeoIP2 Precision** web service
(a per-lookup HTTPS API call — no local database, no cron download). It ships no admin page of its
own (`configure: smart_ip.settings`); it injects a sub-form into Smart IP's settings form via the
`smart_ip.display_admin_settings` event and becomes active when you set
`smart_ip.settings:data_source` = **`maxmind_geoip2_web_service`**. Depends on `smart_ip`.

- **Enable it, set the service type + MaxMind credentials, pick it as the active source, and how a
  lookup is performed** → [configure/settings.md](configure/settings.md)
- **The Smart IP query API, location keys, session/profile persistence** →
  `modules/sm/smart_ip/5.0.x/agent/api/location.md`
- **The data-source (event-subscriber) model shared by all sources** →
  `modules/sm/smart_ip/5.0.x/agent/extend/data-source.md`

Key facts:
- `sourceId()` = `maxmind_geoip2_web_service`; `configName()` =
  `smart_ip_maxmind_geoip2_web_service.settings`.
- Class `Drupal\smart_ip_maxmind_geoip2_web_service\EventSubscriber\SmartIpEventSubscriber` (extends
  `SmartIpEventSubscriberBase`); service
  `smart_ip_maxmind_geoip2_web_service.smart_ip_event_subscriber` tagged `event_subscriber`.
  No route, no permission, no Drush; `manualUpdate()`/`cronRun()` are intentionally empty.
- Config `smart_ip_maxmind_geoip2_web_service.settings`: `service_type`
  (`country`|`city`|`insights`, default `city`), `user_id`, `license_key`.
- Endpoint: `https://<user_id>:<license_key>@geoip.maxmind.com/geoip/v2.1/<service_type>/<ip>`
  (base `geoip.maxmind.com/geoip/v2.1`), fetched through Drupal's `http_client` and JSON-decoded.
- `processQuery()` fills the location keys country, countryCode, region, regionCode, city, zip,
  latitude, longitude, timeZone, isEuCountry (and originalData).
