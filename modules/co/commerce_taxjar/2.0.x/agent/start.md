<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce TaxJar (commerce_taxjar) — agent index

Integrates **TaxJar SmartCalcs** into **Drupal Commerce** as a **remote tax type**:
US sales tax is calculated per order by calling TaxJar's REST API instead of
building local tax rate rules. Optionally records each order to TaxJar for
automated sales-tax reporting/filing. Version **2.0.5**. Core
`^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Package: Commerce (contrib).

Dependencies (all Commerce): `commerce`, `commerce_order`, `commerce_store`,
`commerce_tax`, `commerce_payment`. Composer floor `drupal/commerce ^2.8 || ^3`.

Ships **no** `*.routing.yml`, **no** controllers, **no** `*.permissions.yml`, **no**
`*.install`, **no** JS/CSS, **no** Drush commands. All configuration is done through
Commerce's own **Tax types** UI (`/admin/commerce/config/tax-types`). (Note: the
`.info.yml` `configure:` key points at `commerce_taxjar.config_settings`, a route
the module does not actually define — the working entry point is the Tax types UI.)

## What it provides (from source)

- **One Commerce tax-type plugin** `taxjar`
  (`src/Plugin/Commerce/TaxType/TaxJar.php`, extends
  `commerce_tax`'s `RemoteTaxTypeBase`) — builds the request, calls TaxJar, and
  adds a `tax` **Adjustment** to the order. See [tax-type.md](tax-type.md).
- **One client factory service** `commerce_taxjar.client_factory`
  (`src/ClientFactory.php`) — returns a Guzzle client with a fixed TaxJar
  `base_uri` and the `Authorization: Token token=<token>` header.
- **One event subscriber** `commerce_taxjar.taxjar_transaction_subscriber`
  (`src/EventSubscriber/TaxJarTransactionSubscriber.php`) — syncs the order to
  TaxJar's transactions API on order state change / payment refund / order delete
  (only when `enable_reporting` is on).
- **Two base fields** (`commerce_taxjar.module`,
  `hook_entity_base_field_info`):
  - `commerce_store.taxjar_address_mode` (list_string, required, default `store`):
    `on_file` (use address on file with TaxJar) vs `store` (use store address) —
    the tax-origin ("from") address.
  - `commerce_product_variation.taxjar_category_code` (entity_reference →
    `taxjar_categories` taxonomy term): optional TaxJar product tax code per
    variation.
- **A taxonomy vocabulary + field** (`config/optional/`): `taxjar_categories`
  vocabulary with a `taxjar_category_code` text field on its terms. Terms are
  fetched from TaxJar's `categories` endpoint (on the "Sync Product Tax Categories"
  form checkbox) and let products carry reduced-rate / exempt tax codes.
- **Two alter hooks** (`commerce_taxjar.api.php`):
  `hook_commerce_taxjar_tax_request_alter(&$request_body, $order)` and
  `hook_commerce_taxjar_transaction_request_alter(&$request_body, $order)` — mutate
  the outbound body before it is sent.
- **Config schema** `commerce_tax.commerce_tax_type.plugin.taxjar`
  (`config/schema/commerce_taxjar.schema.yml`): `api_mode`, `api_key`,
  `sandbox_key`, `enable_reporting`.

## Configuration form (tax-type plugin)

Fields in `buildConfigurationForm()`:
- **API mode** (radios, required): `production` → `https://api.taxjar.com/v2/`;
  `sandbox` → `https://api.sandbox.taxjar.com/v2/` (sandbox needs TaxJar Plus).
- **API Token** (`api_key`, required) and **Sandbox API Token** (`sandbox_key`,
  shown/required only in sandbox mode) — the TaxJar credential(s).
- **Use TaxJar for sales tax reporting** (`enable_reporting`, default on) — turns
  on the transaction-sync event subscriber.
- **Sync Product Tax Categories** (checkbox) — re-fetch categories from TaxJar into
  the `taxjar_categories` vocabulary (auto-checked/required when no categories
  exist yet).

## Request / tax model (positive posture)

Tax is resolved **server-side**. `apply()` POSTs `taxes` with a body built by
`buildRequest()` from the order: from-address (store address or on-file), the
resolved customer profile to-address, line items (id, quantity, unit price,
optional `product_tax_code`, promotion discounts) and shipping adjustments. The
returned `tax.rate` and `tax.amount_to_collect` become the order's tax Adjustment
— **no client-supplied rate or tax amount is trusted**. Identical repeat requests
reuse the cached response stored in the order's `data.taxjar` key.

The TaxJar API **host is fixed/hardcoded** (production or sandbox, chosen by
config), not request-controllable. The client is built through Drupal core's
`http_client_factory` with only `base_uri` + auth/content-type headers, so it
uses core's default HTTPS behaviour (TLS certificate verification on). API errors
log the TaxJar **response** body (not the request/auth header) to the
`commerce_taxjar` logger channel.

## Transaction sync (reporting)

When `enable_reporting` is on, `TaxJarTransactionSubscriber` mirrors orders to
TaxJar's transactions API:
- order leaves `draft` → `createTransaction()` (POST `transactions/orders`),
- non-draft order changes → `updateTransaction()` (PUT
  `transactions/orders/{order_number}`, only if the request changed),
- payment refund transition → `refundTransaction()` (POST/PUT
  `transactions/refunds`),
- order delete → `deleteTransaction()` (DELETE the order + any `-refund`).
Transaction bodies (`buildRequest($order, 'transaction')`) add `transaction_id`,
`transaction_date`, `sales_tax`, `amount`, and per-line SKU/description.

## Related / see also

- [tax-type.md](tax-type.md) — the `taxjar` plugin, request builder, API endpoints,
  category sync, and transaction lifecycle in detail.
- Human setup guide: [`../human-docs/index.md`](../human-docs/index.md).
