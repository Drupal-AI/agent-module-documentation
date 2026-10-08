<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure LiqPay

Settings form `LiqpaySettingsForm` at `/admin/config/development/liqpay`
(route `liqpay.settings`, permission **`access liqpay settings`** — `restrict access: true`).
All values live under the `config` key of the `liqpay.settings` config object.

## Keys (defaults from `config/install/liqpay.settings.yml`)

| Key (`config.*`) | Default | Meaning |
|---|---|---|
| `sandbox` | `1` | When truthy, `LiqPay::getConfig()` swaps `public_key`/`private_key` for the `*_sandbox` pair. |
| `public_key` / `private_key` | `''` | Live LiqPay API keys. |
| `public_key_sandbox` / `private_key_sandbox` | `''` | Sandbox keys used while `sandbox` is on. |
| `currency` | `UAH` | Default payment currency (LiqPayApi supports `UAH`, `USD`, `EUR`). |
| `description.{en,uk,ru}` | localized "Payment order" | Order description sent to LiqPay, by language. |
| `success.{en,uk,ru}` | processed-text (full_html) | Success message shown on `/liqpay/payment_result`. |
| `rro` | (unset) | If set (+ Basket + node), fiscalization goods data is added to the checkout params. |

The private key is also the HMAC secret for the callback signature — see
[api/payments.md](../api/payments.md). Sandbox/live keys are admin-entered; a Key-module or
`settings.php` `$config['liqpay.settings']['config']['private_key']` override is possible if you
prefer not to persist them in config.

## Routes

| Route | Path | Access |
|---|---|---|
| `liqpay.settings` | `/admin/config/development/liqpay` | `access liqpay settings` |
| `liqpay.payments` | `/admin/config/development/liqpay/payments` | `access liqpay settings` (payments list, `LiqpayPaymentsForm`) |
| `liqpay.pages` | `/liqpay/{page_type}` | `access content` — `page_type` ∈ `api`, `pay`, `payment_result` |

## Basket integration

When the `basket` module is enabled, `Plugin/Basket/Payment/BasketLiqpay` exposes LiqPay as a
Basket payment method and `basket->paymentFinish($nid)` is called on a verified successful callback.
Standalone use (no Basket) works too: create a payment row and send the buyer to `/liqpay/pay`.
