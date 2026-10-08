Submodule of Commerce Currency Resolver that picks the shopper's currency from their geolocated country, using the GeoIP module and an admin-managed country → currency mapping.

---

The submodule registers a `commerce_price.currency_resolver` service (`CurrencyResolverGeoip`, priority 900) that geolocates the visitor's IP through the `geoip.geolocation` service, gets a country code, and looks it up in the `commerce_currency_resolver_geoip.currency_mapping` config object's `matrix` (a `country_code => currency_code` map). If a currency is mapped it returns that currency; otherwise NULL and the chain falls through. A mapping form at `/admin/commerce/config/commerce_currency_resolver/geoip` (route `commerce_currency_resolver_geoip.currency_mapping`, permission `administer commerce currency resolver settings`) supports two `logic` modes: build the matrix per **country** (assign a currency to each country) or per **currency** (assign multiple countries to each currency). It requires the contrib **GeoIP** module (`geoip:geoip`). Use it when currency should track where the shopper is, not what language they browse in. It outranks the language resolver (800) but is beaten by the cookie resolver (1000).

---

- Show prices in the currency of the visitor's country automatically.
- Map US → USD, DE/FR/… → EUR, GB → GBP based on geolocation.
- Assign one currency per country (country logic) via the admin matrix.
- Assign many countries to one currency (currency logic) via the admin matrix.
- Provide a country-driven default that a cookie choice can still override.
- Beat the language resolver so location wins over interface language.
- Read back the current country→currency mapping from `commerce_currency_resolver_geoip.currency_mapping:matrix`.
- Read/set the matrix `logic` mode (`country` or `currency`).
- Change a country's mapped currency via the admin form or drush config.
- Seed geo mappings in a config export / recipe.
- Run a geo-targeted storefront without per-country stores.
- Fall through to language/store default for unmapped countries.
- Localise pricing for international traffic driven by IP.
- Debug which currency a country resolves to.
- Combine with exchanger auto mode so geo-selected currencies get converted prices.
- Add a new country mapping when expanding to a new market.
- Keep currency stable for a country regardless of the browser language.
- Use GeoIP (MaxMind-style) lookups already configured for the site.
