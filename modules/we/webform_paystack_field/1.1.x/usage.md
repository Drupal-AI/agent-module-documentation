<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Paystack Field lets webforms collect Paystack payments, verified server-side.

---

Webform Paystack Field integrates Paystack (a popular African payment gateway) with the Webform module — adding a payment field/handler so a webform submission can collect a payment via Paystack, redirecting to Paystack and returning to confirm the transaction.

Security: on return, the module looks up the stored transaction by reference and calls Paystack's server-side `transaction->verify()` API to confirm the payment (rather than trusting the redirect parameters), and reads stored data with `unserialize(..., ['allowed_classes' => FALSE])` (no object injection) — a defensively-correct flow. Paystack API keys should be stored securely (env-backed). Supports Drupal 10 and 11.

---

- Collect Paystack payments in webforms.
- Add a payment field/handler.
- Redirect to Paystack to pay.
- Confirm the transaction on return.
- Verify payment server-side via Paystack's verify API.
- Not trust redirect parameters.
- Use safe unserialize (allowed_classes=FALSE).
- Store transactions in a table.
- Store Paystack keys securely (env-backed).
- Support Drupal 10 and 11.
- Serve African payments.
- Process payment on submission.
- Turn forms into payment forms
- Configure the gateway
- Look up transactions by reference.
- Verify payments securely.
- Integrate Paystack.
- Support donations/fees
