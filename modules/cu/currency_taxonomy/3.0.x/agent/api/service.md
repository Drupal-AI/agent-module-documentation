<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lookup service API

Service id `currency_taxonomy.service` → `Drupal\currency_taxonomy\CurrencyTaxonomyService`
(`src/CurrencyTaxonomyService.php`), implementing `CurrencyTaxonomyServiceInterface`. Constructor arg:
`@entity_type.manager` (`currency_taxonomy.services.yml`).

```php
$svc = \Drupal::service('currency_taxonomy.service');
$eur = $svc->getCurrencyByCode('EUR');       // TermInterface|null
$usd = $svc->getCurrencyByNumber('840');     // TermInterface|null
$gbp = $svc->getCurrencyByCountry('United Kingdom'); // CONTAINS match
```

## Methods
- `createCurrency(array $data): TermInterface`
  - Creates a `vid: currency` term. `name` = `$data['currency']`, else `$data['field_currency_iso']`,
    else `''`. Then sets **every** key of `$data` as a field on the term (`$term->set($field, $value)`)
    and saves. Caller controls which fields are written.
- `getCurrencyByCode($code)` → filters `field_currency_iso = $code`.
- `getCurrencyByNumber($number)` → filters `field_currency_number = $number`.
- `getCurrencyByCountry($country)` → filters `field_currency_country CONTAINS $country`.
- `getCurrency(array $conditions)` — shared helper. Builds an entity query on `taxonomy_term`, calls
  `->accessCheck()` (access enforced), conditions `vid = currency` plus each supplied
  `[field => ['value' => ..., 'op' => ...]]`, executes, and returns the **first** matching loaded term
  (`reset($results)`) or `NULL`. `op` defaults to `NULL` (`=`).

## Behaviour notes
- All getters return a single `TermInterface` (first hit) or `NULL` — not a list.
- The query respects entity access (`accessCheck()` with no argument), so results depend on the current
  user's permission to view taxonomy terms.
- `createCurrency()` does not validate or dedupe; it writes whatever fields you pass.
