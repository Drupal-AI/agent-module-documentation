<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Tokens — the tokens it adds

Everything lives in **`commerce_tokens.tokens.inc`** (`hook_token_info()` +
`hook_tokens()`). There is nothing else to configure.

## Install & enable

```bash
composer require drupal/commerce_tokens
drush en commerce_tokens -y
```

Requires `drupal/commerce` (`^2.0 || ^3.0`). No sub-modules, permissions, routes or config.
After enabling, the tokens appear anywhere the Token API is used (email/message templates,
Metatag, Views global text, Rules/ECA, etc.). Use core **Token** module's browser to see them.

## Token types & names (`commerce_tokens_token_info()`)

Type declarations returned under `types`:

| Type key | Chains to | Meaning |
|---|---|---|
| `commerce_currency` | — (new type, `needs-data => commerce_currency`) | a currency entity |
| `current-commerce-store` | `commerce_store` | store from the current route |
| `default-commerce-store` | `commerce_store` | the site's default store |
| `current-commerce-order` | `commerce_order` | order from the current route |
| `current-commerce-product` | `commerce_product` | product from the current route |
| `current-commerce-product-variation` | `commerce_product_variation` | variation from the current route |

Tokens returned under `tokens`:

- `commerce_store`: `id`, `name`, `mail`, `default_currency` (chains → `commerce_currency`).
- `commerce_currency`: `id`, `code`, `name`, `symbol`, `fraction-digits`.

Note the module **adds** `commerce_store` tokens onto the store type already known to
Commerce/Token; it does not redefine the store type itself.

## Value generation (`commerce_tokens_tokens()`)

Branches keyed on `$type`:

- **`commerce_store`** (needs `$data['commerce_store']`, a `StoreInterface`):
  - `id` → `$store->id() ?: t('not yet assigned')` (id may be unset during `presave`).
  - `name` → `$store->getName()`.
  - `mail` → `$store->getEmail()`.
  - `default_currency` chain → `\Drupal::token()->findWithPrefix($tokens, 'default_currency')`
    then `->generate('commerce_currency', $currency_tokens, ['commerce_currency' => $store->getDefaultCurrency()], …)`.
- **`commerce_currency`** (needs `$data['commerce_currency']`, a `CurrencyInterface`):
  - `id` and `code` → `$currency->id()` (both return the currency code, e.g. `USD`).
  - `name` → `$currency->getName()`; `symbol` → `$currency->getSymbol()`;
    `fraction-digits` → `$currency->getFractionDigits()`.
- **`current-commerce-store`** → `\Drupal::routeMatch()->getParameter('commerce_store')`,
  adds `url` cache context + cacheable dependency, then delegates via
  `token->generate('commerce_store', …)`.
- **`default-commerce-store`** → `\Drupal::service('commerce_store.default_store_resolver')->resolve()`,
  adds a cacheable dependency, then delegates to `commerce_store` generation (no `url` context).
- **`current-commerce-order` / `-product` / `-product-variation`** → the matching route
  parameter (`commerce_order` / `commerce_product` / `commerce_product_variation`), add `url`
  cache context + cacheable dependency, then delegate to that entity type's normal tokens via
  `token->generate()`.

## Usage examples

```
[default-commerce-store:name]
[default-commerce-store:mail]
[default-commerce-store:default_currency:code]     -> e.g. USD
[current-commerce-store:default_currency:symbol]   -> e.g. $
[current-commerce-order:order_number]              -> handled by commerce_order tokens
[current-commerce-product:title]                   -> handled by commerce_product tokens
[current-commerce-product-variation:sku]           -> handled by commerce_product_variation tokens
```

## Behavior notes

- The `current-commerce-*` tokens only resolve when the corresponding entity is a parameter of
  the **current route** (e.g. `current-commerce-order` on an order route). Off that route the
  route parameter is `NULL`; the delegated `token->generate()` then yields no replacements.
- Cache correctness is handled: route-based types add the `url` cache context and each type adds
  the resolved entity as a cacheable dependency to the `BubbleableMetadata`.
- `current-commerce-order/product/variation` do not implement per-field tokens themselves — they
  reuse the entity's existing token set, so any field token Commerce/Token exposes for that
  entity works after the `current-commerce-*:` prefix.
