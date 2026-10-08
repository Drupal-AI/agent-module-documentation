# Configure — country → currency mapping (GeoIP)

**Config object:** `commerce_currency_resolver_geoip.currency_mapping`
**Form:** `Drupal\commerce_currency_resolver_geoip\Form\CurrencyResolveGeoipMapping`
**Path:** `/admin/commerce/config/commerce_currency_resolver/geoip`
(route `commerce_currency_resolver_geoip.currency_mapping`)
**Permission:** `administer commerce currency resolver settings`
**Requires:** the contrib **geoip** module enabled and configured.

## Structure

```yaml
logic: country        # 'country' | 'currency' — how the admin matrix is built
matrix:
  US: USD
  DE: EUR
  GB: GBP
```

- `matrix` — `ISO country code => currency_code`. This is what `resolve()` reads at runtime,
  regardless of `logic`.
- `logic` — UI-only build mode: `country` = pick a currency for each country; `currency` =
  assign a set of countries to each currency. Both produce the same `matrix` shape.

## How it resolves

`CurrencyResolverGeoip::resolve()` (priority 900):

1. `ip = request->getClientIp()`
2. `country = geoip.geolocation->geolocate($ip)`
3. `code = matrix[country] ?? null` → `manager->getCurrencyByCode($code)` or **NULL**.

## Read / set via drush

```bash
drush cget commerce_currency_resolver_geoip.currency_mapping matrix
drush cget commerce_currency_resolver_geoip.currency_mapping logic

drush php:eval '\Drupal::configFactory()->getEditable("commerce_currency_resolver_geoip.currency_mapping")->set("logic","country")->set("matrix", ["US" => "USD"])->save();'
```

Config object is schema-only until first save. Enabling this submodule requires `geoip`; if
`geoip` is absent the submodule cannot be enabled.
