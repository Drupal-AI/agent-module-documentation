<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, settings form, receipts (54-FZ)

## Install / enable

`ddev drush en yookassa -y` (project `yoomoney`; **module id `yookassa`**). Requires Commerce
`commerce_payment`, `commerce_tax`, `commerce_cart`, PHP 8.0+, cURL, and the
`yoomoney/yookassa-sdk-php` (+ validator) SDK. The SDK is loaded via **Ludwig** — `ludwig.json`
pins `yookassa-sdk-php v3.14.0`, `yookassa-sdk-validator v1.0.3`, `php-ds v1.5.0`, `psr/log 3.0.0`;
`YooKassaLudwigRequireHelper::checkLudwigRequire()` autoloads it, and `yookassa_requirements()`
(`yookassa.install`, install phase) blocks install with `REQUIREMENT_ERROR` if
`\YooKassa\Client` / `\YooKassa\Validator\Validator` are absent.

## Where config lives

No settings route and no shipped config schema. Configuration is a Commerce **payment gateway**:
*Commerce → Configuration → Payment gateways → Add* (`plugin: yookassa`), stored in config entity
`commerce_payment.commerce_payment_gateway.<machine_name>` under `configuration`. The settings form
is `YooKassa::buildConfigurationForm()`. Multiple gateways (machine names) can coexist; each has its
own token and notification URL.

## Connecting the store

Instead of manual keys, the form drives the OAuth flow (see api/oauth-and-notifications.md): the
"Connect your store" / "Change store" button opens YooMoney authorization; on success the module
stores `access_token`, `token_expires_in`, `shop_id` and registers webhooks. `getShopInfo()`
(SDK `me()`) shows whether the connected store is a **Test store** or **Real store** and its
Shop ID.

## Config keys (`defaultConfiguration()`)

- `shop_id` — YooMoney account id (set from OAuth `me()`; also shown in the UI).
- `access_token`, `token_expires_in`, `oauth_state` — OAuth credentials/state (managed by the flow;
  not hand-edited).
- `notification_url` — read-only field; the `commerce_payment.notify` URL for this gateway
  (`generateNotificationUrl()`), registered as the YooKassa webhook target.
- `description_template` — payment description; supports `%order_id%` and other order-field
  placeholders; max 128 chars. Default "Payment for order No. %order_id%".
- `receipt_enabled` — send 54-FZ receipt data with each payment (AJAX-toggled).
- `default_tax` — default YooKassa VAT code (options from `YooKassaTaxRateEnumHelper::getTaxRate()`).
- `yookassa_tax` — per-Commerce-tax-rate → YooKassa VAT code map ("Compare the receipts" grid,
  built from all `commerce_tax_type` rates).
- `default_tax_rate` — default tax system: 1 OSN, 2 USN income, 3 USN income-minus-costs, 4 ENVD,
  5 ESN, 6 PSN. Sent as `taxSystemCode`.
- `default_payment_subject` — receipt subject (`commodity`, `excise`, `job`, `service`, …,
  `another`).
- `default_payment_mode` — receipt payment mode (`full_prepayment`, `partial_prepayment`,
  `advance`, `full_payment`, `partial_payment`, `credit`, `credit_payment`).
- `second_receipt_enabled` — send a "second receipt" (only when `receipt_enabled`).
- `order_type` — which `commerce_order_type` the second-receipt status applies to (AJAX-populates
  the status list).
- `second_receipt_status` — the order state that triggers the second receipt (states pulled from
  the order type's workflow via `getStates()`).

## Receipts (54-FZ)

- **First receipt**: built at checkout in `PaymentOffsiteForm::factoryReceipt()` — customer email
  from `order.mail`, one receipt item per order item with a VAT code (from `yookassa_tax` map or
  `default_tax`), `default_payment_mode`, `default_payment_subject`; receipt is `normalize()`d to
  the payment amount.
- **Second receipt**: `YooKassaEventSubscriber` (service `yookassa.yoo_kassa_event_subscriber`) on
  `OrderEvents::ORDER_PRESAVE`. When `second_receipt_enabled` and the order reaches
  `second_receipt_status`, it fetches the last YooKassa receipt (`getReceipts` by payment id),
  rebuilds items whose mode was `full_prepayment` as `full_payment`, and POSTs a new
  `CreatePostReceiptRequest` (`createReceipt`). It sets order data flag
  `yookassa_send_second_receipt` to run once, and (if `commerce_log` is enabled) writes a
  `order_sent_second_reciept` log entry.

## Order workflow & logging

`yookassa.workflows.yml` defines `yookassa_workflow` (group `commerce_order`): states
draft/waiting/paid/completed/canceled with place/waiting/paid/complete/cancel transitions. Select
it as the order type's workflow to expose the paid/completed steps the gateway drives. All module
activity logs to dblog channel **`yookassa`** (settings form links to
`/admin/reports/dblog?type[]=yookassa`).

## Tax-code migration

`yookassa_update_8100()` (and the runtime `migrateTaxRates()`) remap stored VAT codes 4→11 and
6→12 across all `yookassa` gateways, so old configs keep valid YooKassa VAT codes after upgrade.
