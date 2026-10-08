Geoblock blocks incoming requests based on the origin country (and registration country) of the client's IP address, using a pluggable geolocation data source and an allow/block country list.

---

Geoblock registers a `KernelEvents::REQUEST` subscriber (`geoblock.request_handler`) that, for configured HTTP methods, geolocates the client IP and enforces a set of restrictions, returning a `403 Forbidden` ("The requested resource is inaccessible due to geographical restrictions.") when any restriction is violated. Country lookup is delegated to a **data source plugin** (plugin type `geoblock_data_source`, annotation `@GeoblockDataSource`), and the module ships **no data source of its own** — until you install/select one, geoblock is effectively disabled. Two restriction strategies are collected via the `geoblock_restriction` service tag: `CountryCodeRestriction` (allow-list or block-list of ISO 3166-1 alpha-2 country codes) and `DomesticRestriction` (block an IP whose current country differs from its registered country). Configuration lives in `geoblock.settings` and is edited at `/admin/config/geoblock` (permission "administer geoblock"): `data_source`, `applicable_methods` (default `CONNECT, DELETE, PATCH, POST, PUT` — note **GET/HEAD are not restricted by default**), `restriction_type` (`''` = off, `allow`, or `block`), `restriction_country_codes`, `require_domestic_use`, and `enable_logging`. Country codes are validated against `league/iso3166`. The request handler is fail-safe: any exception during enforcement is logged (if logging is on) and never blocks the site by error. IP addresses in private/reserved ranges are treated as non-locatable.

---

- Block all visitors from a specific country (e.g. deny requests originating in a given nation).
- Allow-list a site so only visitors from one or a few countries can reach it.
- Restrict form submissions (POST) to domestic traffic while leaving GET page views open.
- Comply with export/embargo rules by blocking requests from sanctioned countries.
- Reduce spam or abusive POSTs by geo-restricting mutating HTTP methods.
- Require "domestic use" — block IPs being used in a country different from where they are registered (e.g. VPN/proxy detection heuristic).
- Limit access to an internal or regional application to its home country.
- Apply country restrictions only to write operations (PATCH/PUT/DELETE) via `applicable_methods`.
- Enforce geo rules on API/CONNECT traffic while keeping normal browsing unaffected.
- Log every enforced geo-block for audit or tuning by enabling `enable_logging`.
- Integrate a MaxMind/CloudFlare/other GeoIP source by implementing a `geoblock_data_source` plugin.
- Swap geolocation providers without touching enforcement logic (data source is pluggable).
- Return a clear 403 message to geo-blocked visitors instead of silently dropping them.
- Combine a country block-list with a domestic-use requirement for layered restriction.
- Configure the country list through the admin UI or via `geoblock.settings` config in code.
- Deploy geo restrictions as exported configuration across environments.
- Temporarily disable all geo enforcement by clearing `data_source` or `restriction_type`.
- Protect a checkout or registration flow from traffic outside supported regions.
- Add a new geolocation backend as a contrib/custom module providing the data source plugin.
- Whitelist only EU countries (or any custom set) for a region-locked service.
- Keep GET traffic (and caching/SEO crawlers) working while restricting only unsafe methods.
- Validate that a country code is a real ISO 3166-1 alpha-2 value before applying a rule.
- Audit which restriction class fired for a blocked request via the logged class name.
