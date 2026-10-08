# Geo Entity: Time zone — agent index

Experimental submodule: fills a Time Zone (`tzfield`) field from a geofield location on a geo entity via the
GeoNames web service. Depends on `geofield`, `tzfield`, `geo_entity`. Parent:
[../../../../1.1.x/agent/start.md](../../../../1.1.x/agent/start.md).

- **Settings form (GeoNames username/token) & wiring a tzfield to a geofield** → [configure/settings.md](configure/settings.md)
- **The `geo_entity_tz.geonames_timezone` service (lookup API) & the presave hook** → [api/service.md](api/service.md)

Key facts:
- Config route `geo_entity_tz.settings_form` at `/admin/config/system/geo_entity_tz`, permission
  `administer geo_entity_tz configuration` (`restrict access: true`).
- Config object `geo_entity_tz.settings` keys: `username` (required), `token` (optional premium).
- Service `geo_entity_tz.geonames_timezone` (`GeonamesTimezone`) calls `https://secure.geonames.org/timezoneJSON`.
- The tzfield→geofield link is a field third-party setting `geo_entity_tz.geofield`, set via the field-config
  edit form ("From location field" select).
- Lookup runs in `hook_geo_entity_presave`; skipped if tzfield already set and geofield unchanged.
