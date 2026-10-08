# Configure — settings

**Config object:** `commerce_currency_resolver.settings`
**Form:** `Drupal\commerce_currency_resolver\Form\CurrencyResolverSettingsForm`
**Route/path:** `commerce_currency_resolver.configuration` →
`/admin/commerce/config/commerce_currency_resolver/settings`
**Permission:** `administer commerce currency resolver settings`
**Menu:** under *Commerce → Configuration → Store → Currency resolver*.

## Keys (config/install defaults)

```yaml
currency_source: 'field'          # 'field' | 'auto' | 'combo'
currency_field_prefix: 'field_price_'
currency_exchange_rates: ''       # id of a Commerce Exchanger provider (auto/combo only)
```

| Key | Meaning |
|---|---|
| `currency_source` | Pricing strategy (see below). |
| `currency_field_prefix` | Prefix for per-currency price fields. Field name = `{prefix}{lowercase_code}`, e.g. prefix `field_price_` → Euro field `field_price_eur`. |
| `currency_exchange_rates` | Which Commerce Exchanger provider supplies rates. Only used/shown in `auto`/`combo`. |

## `currency_source` modes

- **`field`** — per-currency price fields only. `CurrencyResolverPrice::resolve()` returns
  `{prefix}{code}` on the purchasable entity when the resolved currency differs from the base
  price currency; if that field is missing/empty it returns `NULL` (Commerce falls back).
- **`auto`** — everything converted from the base price via Commerce Exchanger
  (`ExchangerResolverPrice`, priority 999). No per-currency fields needed.
- **`combo`** — use the per-currency field if present, otherwise auto-convert. This becomes the
  effective default once the **exchanger** submodule is enabled.

The base settings form only exposes the `field` radio option + the prefix. The **exchanger**
submodule's `hook_form_alter` (`commerce_currency_resolver_exchanger.module`) is what adds the
`auto`/`combo` radios and the `currency_exchange_rates` provider selector — so `auto`/`combo`
are only reachable through the UI when that submodule is on (you can still set them with drush).

## Set via drush

```bash
# read current config
drush cget commerce_currency_resolver.settings

# switch to combo mode with a custom field prefix
drush cset -y commerce_currency_resolver.settings currency_source combo
drush cset -y commerce_currency_resolver.settings currency_field_prefix field_price_
```

## Caching requirement

Works with **Internal Dynamic Page Cache** only; disable the core **Page Cache** module (it
caches per-URL and would serve one currency to everyone). The module ships a `currency_resolver`
cache context (see [../api/services.md](../api/services.md)) so per-currency content varies
correctly.

## Per-currency price fields

For `field`/`combo` you add a Price field named `{prefix}{code}` (lowercase code) to the
purchasable entity (e.g. `commerce_product_variation`), one per non-default currency. The
resolver reads `->first()->toPrice()` from it. No field is needed for the store's default
currency (that is the base `price`).
