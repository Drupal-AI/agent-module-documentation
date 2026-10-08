# Commerce Currency Resolver GeoIP — agent index

Submodule of **commerce_currency_resolver**. Resolves the *current currency* from the visitor's
geolocated country (via the contrib **geoip** module) using an admin-managed matrix.

- **How resolution works, the mapping config & form (with the `logic` switch), read/set** →
  [configure/geoip-mapping.md](configure/geoip-mapping.md)

Key facts:
- Requires `geoip:geoip`. Service `commerce_currency_resolver_geoip.currency`
  (`Resolver\CurrencyResolverGeoip`), tagged `commerce_price.currency_resolver` **priority 900**
  (above language 800, below cookie 1000).
- Config object `commerce_currency_resolver_geoip.currency_mapping`: `matrix`
  (`{country_code: currency_code}`) plus `logic` (`country` | `currency`). Created on first save.
- `resolve()` = client IP → `geoip.geolocation->geolocate($ip)` (country) → `matrix[country]` →
  currency; NULL (falls through) if unmapped.
- Mapping form: `/admin/commerce/config/commerce_currency_resolver/geoip`
  (route `commerce_currency_resolver_geoip.currency_mapping`, permission
  `administer commerce currency resolver settings`).
- No own permission/plugins/Drush. Sibling `smart_ip` submodule does the same via Smart IP
  (but ships a broken route in 2.0.1 — see that submodule's docs).
