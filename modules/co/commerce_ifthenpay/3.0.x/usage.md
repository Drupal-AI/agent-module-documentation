<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Ifthenpay provides Commerce integration for Ifthenpay.

---

Commerce Ifthenpay provides **Drupal Commerce payment gateways for ifthenpay** (the Portuguese payment
provider) — Multibanco references, MB WAY, and credit card — via the `commerce_ifthenpay_mbway` and
`commerce_ifthenpay_cc` submodules. It depends on Commerce Payment, in the Commerce (contrib) package.

Use it to accept ifthenpay payments. Its payment trust boundaries are **implemented correctly**
(verified from source):

- **Multibanco** confirms through an **authenticated ifthenpay callback** (`onNotify`): the
  anti-phishing shared secret is validated with a strict comparison, the Multibanco entity is bound
  per payment (API-mode payments against the entity ifthenpay assigned to the reference, offline
  payments against the configured entity), the optional `requestId` is validated against the stored
  value, and the callback amount is matched to the local pending payment before it is completed — so a
  forged or under-reported callback cannot force cheap or free fulfilment.
- The **credit-card** return handler (`IfthenpayCC::onReturn()`) recomputes and **verifies the
  security key** `SK = SHA-256(orderId + amount + requestId + CCARD_KEY)` with a strict `!==` and
  **re-checks that the charged amount equals the server-side order amount**, throwing a
  `PaymentGatewayException` on any mismatch — so tampered returns are rejected and only genuinely-paid
  orders complete.
- **MB WAY** confirms through its own anti-phishing-keyed callback, and its storefront repayment
  endpoint is access-restricted (order owner or cart-session owner), CSRF-token protected and
  flood-limited.

Handle the ifthenpay keys (`mb_key`, anti-phishing keys, `cccard_key`) as **secrets** — they live in
the payment-gateway configuration — and use HTTPS. All remote calls target hardcoded ifthenpay HTTPS
hosts with TLS verification enabled. The module has no access-control role of its own beyond the
repayment endpoint's owner check.

---

- Accept ifthenpay payments (Multibanco, MB WAY, credit card).
- Generate Multibanco references dynamically via the ifthenpay REST API, or offline.
- Confirm Multibanco/MB WAY via an anti-phishing-keyed callback that binds the amount server-side.
- Verify the credit-card security key (SHA-256 with `cccard_key`) and re-check the amount on return.
- Reject forged or tampered callbacks and returns.
- Re-send an MB WAY push for an unpaid order from order history (CSRF-protected, flood-limited).
- Handle ifthenpay keys as secrets and use HTTPS.
- Depend on Commerce Payment.
