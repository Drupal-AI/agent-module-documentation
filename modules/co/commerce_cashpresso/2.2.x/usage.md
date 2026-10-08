<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce cashpresso adds an off-site Commerce payment gateway that lets customers pay by instalments through cashpresso (www.cashpresso.com).

---

The `CashpressoGateway` plugin (extending `OffsitePaymentGatewayBase`) authorises a payment by POSTing the order amount, basket, addresses and a SHA-512 verification hash to the cashpresso REST API (`rest.cashpresso.com`, or `backend.test-cashpresso.com` in test mode) using Drupal's `http_client`. The charged amount is always taken from the order-derived `$payment->getAmount()`, never from client input. A product-page financing label and a "direct checkout" flow (`/cashpresso/direct-checkout/{entity_type}/{entity_id}`) are provided; that route resolves the price server-side via the chain price resolver and gates access on the `access checkout` permission plus the purchasable entity's own view access.

The asynchronous status callback (`onNotify`) recomputes `hash('sha512', secret;status;remoteId;orderId)` and rejects the request unless the incoming `verificationHash` matches, then maps the cashpresso status to a Commerce transition (SUCCESS→capture, CANCELLED→void, TIMEOUT→expire). Configure the gateway with your cashpresso API key, secret, order-valid-time and merchant interest-free days on the standard Commerce payment-gateway form. TLS verification uses Guzzle defaults (enabled).

---

- Add a cashpresso payment gateway under `/admin/commerce/config/payment-gateways`.
- Enter your cashpresso API key and secret in the gateway config.
- Switch the gateway between test and live modes.
- Set how long an authorised-but-incomplete payment stays valid (hours).
- Grant additional merchant interest-free days (validated against partner limits).
- Show a financing-cost label on product pages via the preview renderer.
- Offer a "finance this now" direct-checkout button that adds an item and jumps to checkout.
- Let customers complete instalment payment off-site during checkout.
- Capture a payment automatically when cashpresso reports SUCCESS.
- Void a payment when cashpresso reports CANCELLED.
- Expire a payment when cashpresso reports TIMEOUT.
- Verify callback authenticity with the SHA-512 verification hash.
- Fetch and display partner-account info (status, limits, rates) on the config form.
- Pass basket line items and billing/shipping addresses to cashpresso.
- Restrict direct checkout to users with the `access checkout` permission.
- Localise the checkout to the current interface language.
- Review payment state transitions in the Commerce payments UI.
- Log API errors to the `commerce_cashpresso` channel.
- Use the financing preview to estimate monthly instalments before purchase.
