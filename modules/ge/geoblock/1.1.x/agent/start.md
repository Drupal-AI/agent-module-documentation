# Geoblock — agent index

Blocks incoming requests by the origin country of the client IP. A `KernelEvents::REQUEST`
subscriber geolocates the IP (via a pluggable data source) and enforces allow/block country
lists and an optional "domestic use" rule, returning 403 when violated. Config entity
`geoblock.settings`, UI at `/admin/config/geoblock` (permission **administer geoblock**).

- **Settings keys, restriction modes, applicable methods, the admin form** →
  [configure/settings.md](configure/settings.md)
- **The `geoblock_data_source` plugin type and how to implement one (REQUIRED — none ships)** →
  [plugins/data-source.md](plugins/data-source.md)

Critical facts:
- **Geoblock ships NO data source plugin.** With `data_source` empty or set to a missing
  plugin, the module is inert (`RequestHandler::isDataSourcePluginAvailable()` → FALSE). You
  must install/provide a `geoblock_data_source` plugin and select it.
- **GET/HEAD are NOT restricted by default.** `applicable_methods` defaults to
  `CONNECT, DELETE, PATCH, POST, PUT` — only those methods are checked.
- Restrictions: `CountryCodeRestriction` (`restriction_type` `allow`|`block` +
  `restriction_country_codes`) and `DomesticRestriction` (`require_domestic_use`). A single
  violated restriction is enough to return 403.
- Only one permission: **administer geoblock** (gates the settings form). No Drush.
- Country codes are ISO 3166-1 alpha-2, validated via `league/iso3166`.
