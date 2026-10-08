# Commerce Currency Resolver Smart IP — agent index

Submodule of **commerce_currency_resolver**. Resolves the *current currency* from the visitor's
Smart IP geolocated country using an admin-managed country → currency matrix. Smart IP equivalent
of the sibling **geoip** submodule. Requires the contrib **Smart IP** module.

Dependencies: `commerce_currency_resolver:commerce_currency_resolver`, `smart_ip:smart_ip`.
Configure at `/admin/commerce/config/commerce_currency_resolver/smart_ip`
(route `commerce_currency_resolver_smart_ip.currency_mapping`, permission
`administer commerce currency resolver settings`). No own permission, drush, or plugin types.

- **How resolution works, the mapping config object & form (with the `logic` switch), read/set** →
  [configure/smart-ip-mapping.md](configure/smart-ip-mapping.md)

Key facts (from source):
- Service `commerce_currency_resolver_smart_ip.currency`
  (`Resolver\CurrencyResolverSmartIp`), tagged `commerce_price.currency_resolver` **priority 900**
  (above language 800, below cookie 1000) — same priority as the geoip resolver.
- Config object `commerce_currency_resolver_smart_ip.currency_mapping`: `matrix`
  (`{country_code: currency_code}`) plus `logic` (`country` | `currency`). Created on first save
  (schema-only until then).
- `resolve()` = client IP present → `smart_ip.smart_ip_location->get('countryCode')` →
  `matrix[country]` → `CurrencyResolverManager::getCurrencyByCode()`; returns NULL (chain falls
  through) if IP missing or country unmapped.
- Mapping form reuses the parent's country autocomplete route
  `commerce_currency_resolver.countries.autocomplete` in `currency` logic mode.
- Same shape/behaviour as the sibling **geoip** submodule (see
  `commerce_currency_resolver_geoip/2.0.x/agent/configure/geoip-mapping.md`); it differs only in the
  geolocation source (Smart IP's session `countryCode` vs geoip's per-request `geolocate($ip)`).
