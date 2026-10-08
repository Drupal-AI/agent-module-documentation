<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the PostFinance Checkout gateway

**Depends on:** `commerce:commerce_payment`, `commerce:commerce_price`.
**Service factory:** `commerce_postfinance_checkout.service_factory` (`PostFinanceServiceFactory`).

## Payment flow (off-site redirect)
Add a Commerce payment gateway of type **PostFinance**. At checkout the customer is redirected to PostFinance (`postfinance.ch`) to pay with PostFinance Card, Visa, Mastercard, Twint and other activated methods, then returns to the Commerce return/cancel URLs.

## Webhook
**Route:** `commerce_postfinance_checkout.webhook` — `/commerce_postfinance_checkout/webhook` (`_permission: 'access content'`, `_disable_route_normalizer: 'TRUE'`), `WebhookController::content`.

The webhook does **not** trust the request body for fulfillment. It reads the `entityId` from the notification and **re-fetches the transaction from the PostFinance API** to determine authoritative state before updating the Commerce payment — a bounded server-to-server re-fetch, so a forged POST cannot mark an order paid. (Previously reviewed — documented, not re-investigated.)

## Setup
1. `composer require drupal/commerce_postfinance_checkout` and enable.
2. Create a **PostFinance** payment gateway; enter the PostFinance space / user / API credentials.
3. Register the webhook URL in the PostFinance portal.
