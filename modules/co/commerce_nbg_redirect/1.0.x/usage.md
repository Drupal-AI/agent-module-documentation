<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce National Bank of Greece (Redirect) integrates the NBG (National Bank of Greece) payment gateway (Greece) with Drupal Commerce.

---

Commerce National Bank of Greece (Redirect) provides Commerce integration for NBG (National Bank of Greece) — a payment gateway for Greece — the shopper is redirected to NBG to pay and returns to a public return URL.

Security: the return route is public (`_access: 'TRUE'`) but the controller verifies the `X-GP-Signature` header (`hash('sha512', minified_input . app_key)`) and rejects the request on mismatch before completing — signature-authenticated despite the open route. Store the NBG (National Bank of Greece) API credentials securely (env-backed), never committed. Depends on `commerce_payment`; supports Drupal per ^11.

---

- Integrate the NBG (National Bank of Greece) gateway.
- Serve Greece.
- Redirect/charge via the provider.
- Complete the order after payment.
- the return route is public (`_access: 'TRUE'`) but the controller verifies the `X-GP-Signature` header (`hash('sha512', minified_input .
- Use Drupal Commerce payment.
- Store credentials securely (env-backed).
- Never commit credentials.
- Depend on `commerce_payment`.
- Support ^11.
- Handle checkout.
- Process payments.
- Confirm the payment.
- Handle notifications.
- Support Commerce.
- Integrate NBG (National Bank of Greece).
- Charge customers.
- Reconcile orders.
