<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# taxjar tax-type plugin, API client & transaction lifecycle

Source: `src/Plugin/Commerce/TaxType/TaxJar.php`, `src/ClientFactory.php`,
`src/EventSubscriber/TaxJarTransactionSubscriber.php`.

## Plugin definition

`@CommerceTaxType(id = "taxjar", label = "TaxJar")`, extends
`Drupal\commerce_tax\Plugin\Commerce\TaxType\RemoteTaxTypeBase`. Constructed with
`entity_type.manager`, `event_dispatcher`, `commerce_taxjar.client_factory`,
`module_handler`, `logger.factory` (channel `commerce_taxjar`). The Guzzle client
is created once in the constructor from the plugin configuration.

`defaultConfiguration()`: `display_inclusive => FALSE`, `api_key => ''`,
`sandbox_key => ''`, `api_mode => 'production'`, `enable_reporting => TRUE` (plus
parent defaults).

## API client (`ClientFactory::createInstance($config)`)

- `api_mode === 'production'` → `base_uri = https://api.taxjar.com/v2/`, token =
  `api_key`.
- otherwise (`development`/sandbox) → `base_uri =
  https://api.sandbox.taxjar.com/v2/`, token = `sandbox_key`.
- Options passed to core `http_client_factory->fromOptions()`: `base_uri` and
  headers `Authorization: Token token=<token>` + `Content-Type: application/json`.
  No other transport options are set, so the client inherits Drupal core's default
  Guzzle configuration (HTTPS with certificate verification on).

The host is one of the two literals above — never built from order/request input.

## Endpoints used

| Method | Path | Called by |
| --- | --- | --- |
| POST | `taxes` | `apply()` — real-time quote |
| GET | `categories` | `syncCategories()` |
| POST | `transactions/orders` | `createTransaction()` |
| PUT | `transactions/orders/{order_number}` | `updateTransaction()` |
| GET/POST/PUT | `transactions/refunds[/{id}]` | `refundTransaction()` |
| GET/DELETE | `transactions/refunds/{n}-refund`, `transactions/orders/{n}` | `deleteTransaction()` |

## `apply(OrderInterface $order)` — the tax quote

1. `buildRequest($order)` builds the body (returns empty/`NULL` if no `to_country`
   resolvable → no tax added).
2. If the order already stored an identical `request` + a `response` under
   `data.taxjar`, the cached response is reused; otherwise POST `taxes` with
   `json => $request_body`.
3. Adds an `Adjustment` of type `tax`, label `Sales tax`, `amount` =
   `response.tax.amount_to_collect` (order currency), `percentage` =
   `response.tax.rate`, `source_id` = `taxjar|{tax_type_id}`.
4. Stores `data.taxjar = [plugin_id, request, response]` on the order.
5. On `ClientException`/`Exception`: logs via `Error::logException()` and records
   the TaxJar response body / message under `data.taxjar.transactionError`; no
   adjustment is added.

## `buildRequest($order, $mode = 'quote'|'transaction')`

Common body: `plugin => 'drupal-commerce'`, `shipping`, `line_items[]`.
- **From address**: only when `store.taxjar_address_mode === 'store'` — the store's
  address (`from_country/zip/state/city/street`, street line 2 appended). Mode
  `on_file` sends no `from_*` (TaxJar uses the address on file).
- **To address**: from the first order item's resolved customer profile
  (`resolveCustomerProfile()`); `to_country/zip/state/city/street`. If none →
  returns nothing (no request sent).
- **Line items**: `id`, `quantity`, `unit_price`, optional `product_tax_code` from
  the variation's `taxjar_category_code` term, and `discount` summed from each
  line's `promotion` adjustments.
- **Shipping**: summed from order `shipping` adjustments.
- `hook_commerce_taxjar_tax_request_alter(&$body, $order)` fires.

`transaction` mode additionally: drops `plugin`; sets `transaction_id`
(order number or id), `transaction_date` (`Y-m-d` from `getCalculationDate()`),
re-sums `shipping`, computes `sales_tax` from adjustments whose source id contains
`taxjar|`, `amount` = order total − sales tax; adds per-line `product_identifier`
(SKU) and `description` (title); then fires
`hook_commerce_taxjar_transaction_request_alter`.

## Category sync (`syncCategories()`)

GET `categories`, decode, upsert `taxjar_categories` terms keyed by
`product_tax_code` (sets term `name`, `taxjar_category_code`, `description`). On
`ClientException` logs the response body. Triggered from `submitConfigurationForm`
when the "Sync Product Tax Categories" box is checked; if the API token was just
added, a fresh client is built before syncing.

## Transaction lifecycle (event subscriber)

`TaxJarTransactionSubscriber` (`entity_type.manager` injected). Subscribed events:
- `commerce_order.commerce_order.presave` → `updateTransaction`: reads
  `order.data.taxjar`; if the tax type's `enable_reporting` is on and there is an
  `original` order, calls the plugin's `createTransaction` when the order just left
  `draft`, or `updateTransaction` (after `recalculateTotalPrice()`) on later
  non-draft changes.
- `commerce_payment.refund.post_transition` → `refundTransaction`: refunds the
  refunded amount to TaxJar.
- `commerce_order.commerce_order.delete` → `deleteTransaction`.

All transaction calls are gated on `getConfiguration()['enable_reporting']`.

## Extension points

- `hook_commerce_taxjar_tax_request_alter(array &$request_body, OrderInterface $order)`
- `hook_commerce_taxjar_transaction_request_alter(array &$request_body, OrderInterface $order)`
- Public `getClient()` returns the configured Guzzle client.
