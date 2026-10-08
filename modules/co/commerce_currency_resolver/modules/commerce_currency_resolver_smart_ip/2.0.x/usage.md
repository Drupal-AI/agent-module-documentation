Submodule of Commerce Currency Resolver that picks the shopper's currency from their Smart IP geolocated country via an admin-managed country → currency mapping. It is the Smart IP counterpart of the geoip submodule and requires the contrib Smart IP module.

---

The submodule registers a `commerce_price.currency_resolver` service (`CurrencyResolverSmartIp`, priority 900) that reads the visitor's country from the `smart_ip.smart_ip_location` service (`get('countryCode')`) and looks it up in the `commerce_currency_resolver_smart_ip.currency_mapping` config object's `matrix` (`country_code => currency_code`); an unmapped country (or a missing client IP) returns NULL so Commerce's resolver chain falls through to the language resolver (priority 800) and then the store default. The mapping is edited at `/admin/commerce/config/commerce_currency_resolver/smart_ip` (route `commerce_currency_resolver_smart_ip.currency_mapping`, form `CurrencyResolveSmartIpMapping`, permission `administer commerce currency resolver settings`), which offers two build modes via a `logic` switch — one currency per country, or a list of countries per currency (autocompleted through the parent module's `commerce_currency_resolver.countries.autocomplete` route) — both persisting the same country→currency matrix. It behaves identically to the geoip submodule, differing only in geolocation source: Smart IP's session-resolved `countryCode` instead of a per-request IP geolocate.

---

- Resolve currency from the visitor's country using Smart IP instead of GeoIP.
- Map countries to currencies via `commerce_currency_resolver_smart_ip.currency_mapping:matrix`.
- Serve as the location-based currency resolver on sites already running Smart IP.
- Provide a country-driven currency that a cookie choice can still override.
- Outrank the language resolver (priority 900 vs 800) while sitting below cookie (1000).
- Fall through to language/store default for unmapped countries or when no client IP is available.
- Build the mapping by picking one currency per country (`logic: country`).
- Build the mapping by assigning a list of countries to each currency (`logic: currency`).
- Read the country→currency matrix when debugging which currency a visitor gets.
- Use Smart IP's stored `countryCode` session data as the geolocation source.
- Serve international traffic with location-aware pricing.
- Swap in for geoip where Smart IP is the site's chosen geolocation stack.
- Assign one currency to a single country in the mapping.
- Group multiple countries under one currency in the mapping.
- Seed Smart IP currency mappings in a config export / recipe.
- Set the matrix and logic non-interactively via `drush cset` / `drush php:eval`.
- Target new markets by adding country → currency rows.
- Keep currency stable per country regardless of interface language.
- Avoid per-country stores by resolving currency from the visitor's location.
- Restrict who can edit the mapping via the `administer commerce currency resolver settings` permission.
