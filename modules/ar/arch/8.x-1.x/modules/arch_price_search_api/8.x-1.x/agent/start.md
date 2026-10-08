<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Price (Search API) (arch_price_search_api) — agent index

Search API integration submodule of **Arch**. Registers a currency-aware net/gross **price Views
filter** on Search API indexes that carry Arch price fields. Package `Arch Search API`. Core
`^9.4 || ^10 || ^11`. Depends on **`arch_price`**, **`views`**, **`search_api`**. No permissions,
no routes, no Drush.

## What it actually is

- `arch_price_search_api.views.inc` → `hook_views_data_alter()`: for each `search_api\Entity\Index`,
  if `$index->id() === 'products'` and any table field's `real field` matches
  `%^entity:(.*?)/arch_price_(net|gross)(_currency)?_(.*?)%`, it adds a virtual field
  **`arch_price_value_filter`** with `filter.id = arch_price_search_api`, `allow empty = TRUE`.
- One filter plugin **`SearchApiPriceFilter`** (`@ViewsFilter("arch_price_search_api")`,
  `src/Plugin/views/filter/SearchApiPriceFilter.php`) extending `search_api`'s `SearchApiNumeric`.
- Config schema (`config/schema/arch_price_search_api.schema.yml`): `views.filter.arch_price_search_api`
  (base, currency_expose, currency) and `views.filter_value.arch_price_search_api`.

## `SearchApiPriceFilter` behaviour

- Constructed with `@current_user`, `@price_type.manager`, and the `currency` config-entity storage.
- Options: `base` (net|gross, default net), `currency`, `currency_expose` (bool). Forms:
  `buildOptionsForm()`, `buildExposeForm()`, `valueForm()` add the base/currency/expose controls.
- `getFilteringFields()`: resolves `base` and selected `currency`, then iterates
  `priceTypeManager->getAvailablePriceTypes($currentUser, 'view')` × currencies and builds field
  names `strtolower('arch_price_'.$base.'_'.$priceType->id().'_'.$currency->id())`. **Only price
  types the current user may view are included.**
- `query()`: creates an **OR** `ConditionGroup(['arch_price'])` and adds each field via the operator
  method — `opBetween` (`BETWEEN`/`NOT BETWEEN`), `opSimple`, or `opEmpty` (`IS NULL`/`IS NOT NULL`) —
  using Search API's `ConditionGroup::addCondition()` / `query->addWhere()` (parameterized backend).
- `valueForm()` lets the exposed currency be altered via
  `hook_arch_price_search_api_filter_currency_alter()`.

## Notes

- All conditions go through Search API's query builder, not raw SQL. Price-type visibility from
  `arch_price` is enforced in `getFilteringFields()`, so search results honour the same per-role
  price-type access as entity views.
- Requires the index to be named `products` and to include Arch price fields; otherwise the filter
  is not offered.
