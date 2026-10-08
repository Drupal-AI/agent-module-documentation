<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce PostFinance (commerce_postfinance_checkout) — agent index

**Off-site Drupal Commerce payment gateway for the PostFinance Checkout API.**

- **Version:** 2.0.x
- **Core:** `^10.3 || ^11`  · package Commerce (contrib)
- **Requires:** `commerce:commerce_payment`, `commerce:commerce_price`.
- **Route:** `commerce_postfinance_checkout.webhook` (`/commerce_postfinance_checkout/webhook`, `_permission: 'access content'`, `_disable_route_normalizer: TRUE`, `WebhookController::content`).
- **Service:** `commerce_postfinance_checkout.service_factory` (`PostFinanceServiceFactory`).

**Security:** the webhook is `access content` but does **not** trust the request body — it reads `entityId` and re-fetches the transaction from the PostFinance API (bounded re-fetch) before fulfillment, so a forged POST cannot mark an order paid (previously reviewed — documented, not re-investigated). Card data stays off-site. No security findings.

See [configure/gateway.md](configure/gateway.md)
