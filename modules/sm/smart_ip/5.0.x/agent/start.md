# Smart IP (smart_ip) — agent index

IP-based geolocation **framework**. It ships no lookup database itself; you enable one **data
source** submodule and select it as `smart_ip.settings:data_source`. Provides a query API, a
session/profile cache, a "User country" block condition, and an event-based extension model.
Config UI at **`/admin/config/people/smart_ip`** (permission **`administer smart_ip`**).

- **All config keys, the admin form, roles/debug/excluded-IPs/allowed-pages/timezone, and
  selecting a data source** → [configure/settings.md](configure/settings.md)
- **Querying location in code: `SmartIp::query()`, the `smart_ip.smart_ip_location` service,
  location keys, session, user-profile persistence, the `UserCountry` condition** →
  [api/location.md](api/location.md)
- **Adding a geolocation provider (data source) & the Smart IP events** →
  [extend/data-source.md](extend/data-source.md)

Key facts:
- `configure` route `smart_ip.settings` → `/admin/config/people/smart_ip`; single permission
  `administer smart_ip`. No Drush commands.
- Config object `smart_ip.settings`: `data_source`, `roles_to_geolocate`,
  `save_user_location_creation`, `roles_in_debug_mode`, `roles_in_debug_mode_ip`,
  `allowed_pages`, `excluded_ips`, `eu_visitor_dont_save`, `timezone_format`.
- Query entry point: `\Drupal\smart_ip\SmartIp::query($ip = NULL)` returns a location array
  (`country`, `countryCode`, `region`, `regionCode`, `city`, `zip`, `latitude`, `longitude`,
  `timeZone`, `isEuCountry`, `ipAddress`, `source`).
- Location service: `smart_ip.smart_ip_location` (`SmartIpLocation`) — `get()/set()/getData()/
  setData()/save()/delete()`.
- Services: `smart_ip.geolocate_user_subscriber`, `smart_ip.smart_ip_location`,
  `smart_ip.get_location_event`, `smart_ip.admin_settings_event`, `smart_ip.database_file_event`.
- Data sources are **not** a plugin manager: a source module extends `SmartIpEventSubscriberBase`
  (implements `SmartIpDataSourceInterface`) and subscribes to `SmartIpEvents`. This project's six
  submodules are the sources (see modules/ subtree).
- Block/visibility by country: condition plugin `UserCountry`
  (`Drupal\smart_ip\Plugin\Condition\UserCountry`).
