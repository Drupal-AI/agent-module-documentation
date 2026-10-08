# Configure — language → currency mapping

**Config object:** `commerce_currency_resolver_language.currency_mapping`
**Form:** `Drupal\commerce_currency_resolver_language\Form\CurrencyResolverLanguageMapping`
**Path:** `/admin/commerce/config/commerce_currency_resolver/language`
(route `commerce_currency_resolver_language.currency_mapping`)
**Permission:** `administer commerce currency resolver settings`

## Structure

```yaml
matrix:
  en: USD
  de: EUR
  fr: EUR
```

`matrix` is a `langcode => currency_code` map. The admin form renders one radio group per
configured site language, options = active currencies. Only active currencies appear.

## How it resolves

`CurrencyResolverLanguage::resolve()` (priority 800 in the `commerce_price.currency_resolver`
chain):

1. `langcode = languageManager->getCurrentLanguage()->getId()`
2. `code = config('...currency_mapping').get('matrix')[langcode] ?? null`
3. returns `manager->getCurrencyByCode($code)` or **NULL** (chain continues) when unmapped.

Higher-priority resolvers (cookie 1000, geoip/smart_ip 900) win first; language is the fallback.

## Read / set via drush

```bash
# read the whole mapping
drush cget commerce_currency_resolver_language.currency_mapping matrix

# set a mapping (whole matrix at once)
drush php:eval '\Drupal::configFactory()->getEditable("commerce_currency_resolver_language.currency_mapping")->set("matrix", ["en" => "USD"])->save();'
```

The config object does not exist until first saved (schema-only). Writing `matrix` creates it.
