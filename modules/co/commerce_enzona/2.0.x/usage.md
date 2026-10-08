<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Enzona is a Drupal Commerce off-site payment gateway for EnZona, the Cuban payment platform.

---

Commerce Enzona integrates the EnZona payment gateway with Drupal Commerce so a store operating in Cuba can accept online payments. It adds an off-site gateway plugin ("Enzona Redirect Checkout"): at the checkout payment step the module authenticates to EnZona's REST API with OAuth2 (client-credentials or password grant), creates a payment order, and redirects the shopper to EnZona's hosted checkout to pay. When the shopper returns, the module re-fetches the transaction status from EnZona's API by its transaction UUID, and when EnZona reports the transaction confirmed/completed it records a `commerce_payment` and places the order. The gateway supports test (sandbox) and live modes, a configurable API base URL, merchant id/UUID and terminal id, and the credit-card brands Visa, Mastercard and American Express. It depends on Drupal Commerce's core, payment, order and checkout modules, targets Drupal 11 and PHP 8.3+, and is maintained by Carlos Z (cz9dev).

---

- Accept EnZona payments in a Drupal Commerce store (Cuban payment platform).
- Add an off-site "Enzona Redirect Checkout" gateway under Commerce payment gateways.
- Authenticate to EnZona's REST API over OAuth2 (client-credentials or password grant).
- Create a payment order at EnZona from the Commerce order (amount, items, currency, invoice number).
- Redirect the shopper to EnZona's hosted checkout page to complete payment.
- Re-fetch the transaction status from EnZona on return before recording payment.
- Complete a confirmed EnZona transaction and place the Commerce order.
- Configure sandbox vs. live via the API base URL and a test-mode toggle.
- Set merchant id, merchant UUID and terminal id per gateway.
- Store gateway credentials (consumer key/secret) in the payment-gateway configuration.
- Support Visa, Mastercard and American Express card brands.
- Cancel a checkout and return the shopper to the payment step.
- Look up an EnZona transaction's details by its UUID.
- Run on Drupal 11 with Drupal Commerce 3.x and PHP 8.3+.
