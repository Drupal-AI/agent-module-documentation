<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Paystack payment gateway

## Prerequisites
- Drupal Commerce with `commerce_payment` enabled.
- Composer library: `composer require yabacon/paystack-php` (install fails via `hook_requirements` without it).
- A Paystack account with API keys (`sk_test_...` / `sk_live_...`).

## Add the gateway
1. Go to **Commerce > Configuration > Payment gateways** (`/admin/commerce/config/payment-gateways`) and **Add payment gateway**.
2. Choose plugin **Paystack Standard (Off-site)**.
3. Set **Mode** (Test or Live) and paste the **Secret Key**. The form validates that the key starts with `sk_` (`PaystackStandard::validateConfigurationForm`).
4. Save. There are no module-specific permissions — use the standard Commerce *Administer payment gateways* permission.

## How the payment flow works
- **Initialize (checkout):** `PaystackStandardForm::buildConfigurationForm` calls `transaction->initialize()` with `reference` = order UUID, `amount` = order amount x 100 (kobo), `email`, `callback_url` = Commerce return URL, and billing first/last name as custom fields. The buyer is redirected (GET) to Paystack's `authorization_url`.
- **Return / verify:** `PaystackStandard::onReturn()` reads `trxref`, then `verifyTransaction()` performs a server-side authenticated `transaction->verify()`. A payment is created only when the verified status is truthy.
- **Status mapping** (`getStatusMapping`): `success`->`completed`, `abandoned`->`authorization_voided`, `failed`->`refunded`.

## Operational / security notes
- Verification is **pull-based** (server calls Paystack), so there is no inbound webhook to authenticate and no `x-paystack-signature` handling — the return cannot be forged without a valid, server-verifiable reference.
- TLS verification is left at the `yabacon/paystack-php` default (enabled); the module does not disable it.
- `onReturn()` sets the payment amount from `$order->getTotalPrice()` and does not compare Paystack's returned `data->amount`/currency to the order. For high-value stores, add an amount/currency check against `$verify_transaction->data` before creating the payment.
- The Secret Key is stored in plaintext payment-gateway config; restrict who can administer payment gateways and who can export config.
