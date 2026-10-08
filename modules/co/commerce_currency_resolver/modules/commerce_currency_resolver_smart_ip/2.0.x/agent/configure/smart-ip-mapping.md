# Configure — country → currency mapping (Smart IP)

**Config object:** `commerce_currency_resolver_smart_ip.currency_mapping`
**Form:** `Drupal\commerce_currency_resolver_smart_ip\Form\CurrencyResolveSmartIpMapping`
(form id `commerce_currency_resolver_smart_ip_currency_mapping`)
**Path:** `/admin/commerce/config/commerce_currency_resolver/smart_ip`
(route `commerce_currency_resolver_smart_ip.currency_mapping`; local task tab "Smart IP mapping"
under the parent settings page, base route `commerce_currency_resolver.configuration`)
**Permission:** `administer commerce currency resolver settings` (defined by the parent module)
**Requires:** the contrib **Smart IP** module enabled and configured (the `smart_ip.smart_ip_location`
service supplies the visitor's `countryCode`).

## Structure

```yaml
logic: currency       # 'country' | 'currency' — UI build mode only (default 'currency')
matrix:
  US: USD
  DE: EUR
  GB: GBP
```

- `matrix` — `ISO country code => currency_code`. This is the only field `resolve()` reads at
  runtime, regardless of `logic`.
- `logic` — UI-only build mode for the form: `country` = pick one currency per country (select per
  country); `currency` = assign a comma-separated list of countries to each active currency (a
  textfield per currency, autocompleted via the parent route
  `commerce_currency_resolver.countries.autocomplete`). On submit, `currency` mode is expanded back
  into the same `country => currency` matrix shape, so both modes persist identically.

The form lists only **active** `commerce_currency` entities
(`CurrencyResolverManager::getCurrencies()`) as the currency options.

## How it resolves

`CurrencyResolverSmartIp::resolve()` (service `commerce_currency_resolver_smart_ip.currency`,
tag `commerce_price.currency_resolver`, **priority 900**):

1. `ip = request->getClientIp()` — if falsy, return **NULL**.
2. `country = smart_ip.smart_ip_location->get('countryCode')` (Smart IP's stored session location).
3. `code = matrix[country]` if set → `manager->getCurrencyByCode($code)` (returns the active
   `CurrencyInterface` or NULL if that code is not an active currency); otherwise **NULL**.

Returning NULL lets Commerce's currency-resolver chain fall through to the next tagged resolver
(language 800, then the store default). Note this differs from the geoip sibling, which calls
`geoip.geolocation->geolocate($ip)` per request; Smart IP instead reads the country it already
resolved into the session.

## Read / set via drush

```bash
drush cget commerce_currency_resolver_smart_ip.currency_mapping matrix
drush cget commerce_currency_resolver_smart_ip.currency_mapping logic

drush php:eval '\Drupal::configFactory()->getEditable("commerce_currency_resolver_smart_ip.currency_mapping")->set("logic","country")->set("matrix", ["US" => "USD", "DE" => "EUR"])->save();'
```

Config object is schema-only until first save (no `config/install` default ships). Enabling this
submodule requires `smart_ip`; without it the submodule cannot be enabled.
