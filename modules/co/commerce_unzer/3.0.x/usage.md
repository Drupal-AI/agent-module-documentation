<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Unzer provides Drupal Commerce payment gateways for the Unzer provider.

---

Commerce Unzer **adds Unzer** (formerly Heidelpay) payment gateways to Drupal
Commerce, built on the official `unzerdev/php-sdk`. It ships two gateway plugins: an
**on-site** tokenised credit-card gateway (hosted Unzer card fields, server-side
charge, optional 3-D Secure) and an **off-site** hosted-checkout gateway that
redirects the customer to an Unzer **Paypage** and records the payment on return. It
depends on Commerce Payment.

Use it to accept Unzer payments. Its result handling is server-authoritative: on the
off-site return, `onReturn()` **re-fetches the paypage and payment from Unzer's
authenticated API** (`fetchPaypageV2()` → `fetchPayment()`, using the private key)
and records the payment **only when Unzer reports the payment state COMPLETED** — so
the status comes from Unzer's API, not from forgeable request parameters. On-site
charges run server-side (`performCharge()`) and complete only on success. Security
essentials: store the Unzer **private key** out of committed config (env/Key), serve
over HTTPS. The module defines no routes or permissions of its own. Set PHP
`serialize_precision = -1` to avoid Unzer SDK rounding-error exceptions.

---

- Provide Unzer on-site and off-site payment gateways for Drupal Commerce.
- Build on the official `unzerdev/php-sdk` library.
- Use a hosted Unzer Paypage for the off-site redirect flow.
- Tokenise the card client-side and charge server-side for the on-site flow.
- Record the payment on return.
- Depend on Commerce Payment.
- RE-FETCH the paypage and payment from Unzer's authenticated API on return.
- Record the payment only when Unzer reports the state COMPLETED.
- Complete on-site charges only on success.
- Derive the status from Unzer's authenticated API (not forgeable request params).
- Expose only the public key to the browser; keep the private key server-side.
- Store the Unzer private key out of committed config (env/Key).
- Serve over HTTPS.
- Define no routes or permissions of its own.
- Set serialize_precision = -1 for the Unzer SDK.
- Support optional 3-D Secure on the on-site gateway.
- Configure the Unzer keys per gateway.
