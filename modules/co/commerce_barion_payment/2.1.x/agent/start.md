<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Barion Payment (commerce_barion_payment) — agent index

Drupal Commerce **off‑site (redirect) payment gateway** for **Barion** (Hungarian/EEA payment
provider). The customer is redirected to Barion's hosted page; Barion pings the site's notify URL
and the shopper returns to the return URL. In both cases the module **re‑queries Barion's
authenticated API `GetPaymentState(paymentId)`** (using the merchant Secret key) for the real status
instead of trusting the request — a forged notification cannot mark an order paid (correct posture).
Package `Commerce (contrib)`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed **2.1.1**
(version dir `2.1.x`).

## Dependencies

- Drupal modules: **`commerce:commerce`**, **`commerce:commerce_payment`** (`.info.yml`).
- PHP library: **`barion/barion-web-php` `^2.0`** (`composer.json`). `hook_requirements` (install
  phase) blocks install if `Barion\BarionClient` is missing.

## What it provides (from source — only two PHP files)

- **Payment gateway plugin** `barion_payment` (`#[CommercePaymentGateway]`),
  `src/Plugin/Commerce/PaymentGateway/BarionPaymentGateway.php`, extends `OffsitePaymentGatewayBase`
  and implements `SupportsAuthorizationsInterface` (authorize/capture/void).
- **Offsite redirect form** `src/PluginForm/BarionRedirectForm.php` (extends `PaymentOffsiteForm`) —
  calls `preparePayment()`, stores the returned `PaymentId` on the order, creates the local payment,
  then `REDIRECT_GET`s the buyer to Barion's `PaymentRedirectUrl`.
- **Hooks**: `hook_help` (`.module`), `hook_requirements` (`.install`). No routes/services/config
  YAML of its own — it reuses Commerce's standard payment routes (return/notify). Config schema is
  provided for the gateway settings; **no permissions**, no Drush.

## Config fields (gateway settings form)

`email`, `private_key` (Secret key / POSKey), `api_version` (default `2`), `payment_window`
(HMS, default `00:05:00`), `locale` (Barion UI locale, default EN), `reservation_period`
(`d.hh:mm:ss`, default `0.00:30:00`), plus Commerce's `mode` (mapped to Barion `Test`/`Prod`).

## Solution docs

- **Config fields, payment lifecycle (prepare → redirect → return/notify re‑poll), capture/void,
  state mapping** → [payment-gateway/gateway.md](payment-gateway/gateway.md)
