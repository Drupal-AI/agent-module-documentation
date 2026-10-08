<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Tokens (commerce_tokens) — agent index

Adds Token-API replacements for **Drupal Commerce** stores/currencies plus route-aware
"current/default" context tokens. Version **1.0.2**. License GPL-2.0-or-later.
Core `^9 || ^10 || ^11`. Depends only on **`commerce`** (Commerce core module).

The entire module is one file: **`commerce_tokens.tokens.inc`** implementing
`hook_token_info()` + `hook_tokens()`. **No** routes, forms, permissions, services, plugins,
config objects or config schema, `.install`, or Drush.

- **All token groups/names, how the route-aware types resolve, and how to reference them** →
  [api/tokens.md](api/tokens.md)

## What it provides (from `commerce_tokens_token_info()`)

New token **types**:
- `commerce_currency` — new type (needs-data `commerce_currency`), tokens `id`, `code`, `name`,
  `symbol`, `fraction-digits`.
- `current-commerce-store`, `default-commerce-store` — chain to `commerce_store`.
- `current-commerce-order` → `commerce_order`; `current-commerce-product` → `commerce_product`;
  `current-commerce-product-variation` → `commerce_product_variation`.

New tokens on the existing `commerce_store` type: `id`, `name`, `mail`,
`default_currency` (chains to `commerce_currency`).

## How the values are produced (`commerce_tokens_tokens()`)

- `commerce_store` id/name/mail read `$store->id()/getName()/getEmail()`; `id` falls back to
  `t('not yet assigned')` (comment references `commerce_store_presave`). `default_currency`
  chain uses `token->findWithPrefix()` + `token->generate('commerce_currency', …, $store->getDefaultCurrency())`.
- `commerce_currency` id/code → `$currency->id()`, name → `getName()`, symbol → `getSymbol()`,
  fraction-digits → `getFractionDigits()`.
- `current-commerce-*` types load the entity from `\Drupal::routeMatch()->getParameter(...)`
  (order/product/variation/store) and add `url` cache context + a cacheable dependency, then
  delegate to `token->generate()` for that entity type. `default-commerce-store` resolves via
  the `commerce_store.default_store_resolver` service instead of the route.
