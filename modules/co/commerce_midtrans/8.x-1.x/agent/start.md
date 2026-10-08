<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Midtrans (commerce_midtrans) — agent index

A **Drupal Commerce off-site payment gateway for Midtrans** — the Indonesian
payment aggregator (Snap checkout; 16+ channels: credit card, bank transfer,
Alfamart, GoPay, etc.). At checkout the shopper pays through Midtrans's Snap
pop-up or hosted redirect page, and Midtrans confirms the outcome by POSTing an
asynchronous notification to the site. Community (unofficial) module. Package
`Commerce (contrib)`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.
Installed as **8.x-1.2** (version dir `8.x-1.x`). Configured through the standard
Commerce payment-gateway UI (no dedicated admin page).

## Dependencies

- Drupal module (`.info.yml`): **`commerce:commerce_payment`**.
- PHP library (`composer.json`): **`midtrans/midtrans-php` `^2.0.0`** (the
  official Midtrans PHP SDK — provides `Midtrans\Config`, `Midtrans\Snap`,
  `Midtrans\Notification`, `Midtrans\Transaction`).

## What it provides (from source)

Four payment-gateway plugins (all extend `OffsitePaymentGatewayBase`), each with
a matching offsite-payment plugin form, one notification controller, one route,
and config schema. No `.permissions.yml`, `.install`, `.services.yml`, templates,
or standalone JS files of its own.

- **`midtrans`** — "Midtrans" / "Online Payment via Midtrans"
  (`src/Plugin/Commerce/PaymentGateway/Midtrans.php`, form `MidtransForm`). The
  primary Snap full-payment gateway.
- **`midtrans_installment`** — "Midtrans Online Installment"
  (`MidtransInstallment.php`, form `MidtransInstallmentForm`). Adds `min_amount`.
- **`midtrans_installmentoff`** — "Midtrans Offline Installment"
  (`MidtransOfflineInstallment.php`, form `MidtransForm`). Adds `installment_term`,
  `acquiring_bank`, `min_amount`, `bin_number`.
- **`midtrans_promo`** — "Midtrans Promo Payment" (`MidtransPromo.php`, form
  `MidtransPromoForm`). Adds `discount_type`, `discount_amount`, `max_discount`,
  `method_enabled`, `min_amount`, `bin_number`, `custom_expiry`.
- **Notification controller/route** — `commerce_payment_midtrans.notify` at
  `path: /payment/notify/midtrans` →
  `MidtransNotification::notifyPage`. This is a **single fixed path** (not the
  per-gateway `getNotifyUrl()`); it reads `order_id` from the JSON body, loads the
  order, resolves the order's payment-gateway plugin, and dispatches to its
  `onNotify()`.
- **Config schema** — `config/schema/commerce_midtrans.schema.yml` maps each
  plugin's config keys onto `commerce_payment_gateway_configuration`.

## Common gateway configuration fields

Stored on the `commerce_payment_gateway` config entity (from
`buildConfigurationForm`), shared by all four plugins:

- **`merchant_id`** (required), **`server_key`** (required — the secret API
  credential), **`client_key`** (required — the public Snap key).
- **`enable_3ds`** (default on), **`enable_redirect`** (hosted redirect page vs.
  Snap pop-up), **`enable_savecard`**, **`custom_expiry`**, **`custom_field`**.
- Plus the standard Commerce **mode** (`sandbox` / `production`), which selects
  the Snap endpoint and sets `Midtrans\Config::$isProduction`.

## Payment flow (from source)

1. **Checkout out** — the offsite plugin form (`MidtransForm` and siblings)
   builds the Snap `$params` server-side: `transaction_details.order_id =
   $order->id()` and `gross_amount = intval($order->getTotalPrice()->getNumber())`,
   plus `item_details` from the order items/adjustments and `customer_details`
   from the billing profile. It sets `Config::$serverKey` / `$isProduction` /
   `$is3ds`, then either calls `Snap::getSnapToken($params)` and renders the Snap
   pop-up (`snap.pay`), or (when `enable_redirect`) `Snap::createTransaction()`
   and redirects to the Midtrans-hosted page. The `commerce_payment`'s
   `remote_id` is set to the order id.
2. **Browser return** — `onReturn()` loads the payment by `remote_id`, reads its
   current state, and only displays a status message ("Thank you for your
   payment." or a "complete your payment" instruction). It **does not** transition
   the payment to complete on the return leg — completion happens only via the
   authenticated notification.
3. **Async notification** — `onNotify()` sets `Config::$serverKey` /
   `$isProduction`, then constructs `new Midtrans\Notification()`. The SDK's
   `Notification` constructor reads the raw body only to obtain `transaction_id`
   and immediately calls `Transaction::status($transaction_id)`, an
   **authenticated GET to Midtrans's API** (`/v2/{id}/status`, HTTP Basic with the
   server key). The resulting `transaction_status`, `order_id`, and `fraud_status`
   come from that server-side API response, not from the posted body. The module
   loads the payment by that `order_id` and maps the authoritative status to a
   Commerce payment state (`capture`+`accept`/`settlement` → complete;
   `capture`+`challenge` → challenge; `cancel`/`expire` → cancelled; `deny` →
   failed; `pending` → pending).

## Security posture (positive)

- **Notification confirmation is server-authoritative.** Although the notify
  route is `_access: 'TRUE'` (Midtrans must reach it unauthenticated), the module
  never trusts the posted `transaction_status`/`gross_amount`. The Midtrans SDK
  `Notification` re-queries the transaction status directly from Midtrans's
  authenticated API using the server key before any state change — a forged
  notification cannot complete an unpaid order.
- **Amount is fixed server-side.** `gross_amount` is computed from the order's own
  `getTotalPrice()` at Snap-token creation, not taken from client input, so the
  charged amount is bound to the order total.
- **The browser return path does not complete the order** — completion depends on
  the authenticated notification only.
- **TLS is enforced** — the Midtrans SDK uses cURL with certificate verification
  at defaults and only `https://` endpoints; the module sets no insecure cURL
  options.
- Store `server_key` (and `merchant_id`/`client_key`) via environment-backed
  secrets rather than committing exported config.

## Related docs

- Human setup guide: [`../human-docs/index.md`](../human-docs/index.md)
- Semantic overview: [`../usage.md`](../usage.md)
