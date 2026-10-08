Geo Entity: Time zone automatically populates a Time Zone (tzfield) field from a geofield location on a Geo entity, using the GeoNames web service. (Experimental.)

---

When a geo entity is saved, `hook_geo_entity_presave` walks its fields; for any `tzfield` that has a third-party setting linking it to a `geofield` (`geo_entity_tz.geofield`), it takes the geofield's lat/lon and calls the GeoNames `timezoneJSON` web service (`https://secure.geonames.org`) to resolve the IANA time zone id, then writes it into the tzfield. Lookups are skipped when the tzfield already has a value and the geofield is unchanged. The field↔geofield link is added by an alter on the field-config edit form (a "From location field" select listing the bundle's geofields). A settings form (`/admin/config/system/geo_entity_tz`, permission `administer geo_entity_tz configuration`, `restrict access: true`) stores the required GeoNames **username** and an optional premium **token** in `geo_entity_tz.settings`. Depends on `geofield`, `tzfield`, `geo_entity`. This submodule is marked `lifecycle: experimental`.

---

- Auto-fill a location's time zone from its coordinates so editors never pick it by hand.
- Keep time zone in sync when a geo entity's coordinates change (re-looked-up on save).
- Link any tzfield on a geo bundle to a specific geofield via the field settings "From location field" select.
- Resolve IANA time zone ids (e.g. `Europe/London`) from lat/lon through GeoNames.
- Use a free GeoNames account by entering its enabled username in the settings form.
- Use a GeoNames premium account by supplying the optional token.
- Schedule content (events, broadcasts) correctly per venue using the derived time zone.
- Display local times for stored locations by combining the tzfield with date fields.
- Avoid storing wrong time zones by deriving them from authoritative coordinate data.
- Warn admins on save when a lookup fails because the GeoNames username is missing.
- Integrate GeoNames only where needed by enabling the lookup per field, not globally.
- Migrate legacy location data and backfill time zones on resave.
- Call the `geo_entity_tz.geonames_timezone` service directly from custom code to resolve an IANA zone from lat/lon.
- Support GeoNames premium/commercial web-service accounts via the optional token.
- Recompute the time zone only when coordinates actually change, avoiding needless API calls.
- Provide accurate per-venue time zones for multi-region event calendars.
