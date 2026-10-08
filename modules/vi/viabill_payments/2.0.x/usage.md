<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A ViaBill payment gateway for Drupal Commerce.

---

ViaBill Payments provides a ViaBill payment gateway integration for Drupal Commerce — so customers can pay via ViaBill (a buy-now-pay-later / instalment provider popular in the Nordics), with a callback that confirms the payment before the order is completed.

The callback `/payment/viabill/callback` verifies a SHA-256 signature over the transaction fields + the configured API secret and rejects mismatches (400) before touching the order — so forged 'paid' callbacks are rejected (minor: the compare is `===`, non-constant-time). The ViaBill API keys are admin-configured; store them securely (env-backed). Depends on `commerce`, `commerce_payment`, and `commerce_log`; supports Drupal 10 and 11.

---

- Integrate ViaBill payments.
- Provide a Commerce gateway.
- Support buy-now-pay-later.
- Confirm via a signed callback.
- Verify the callback signature.
- Store API keys securely.
- Depend on `commerce`/`commerce_payment`/`commerce_log`.
- Support Drupal 10 and 11.
- Configure the gateway.
- Handle ViaBill.
- Process payments.
- Take instalments
- Support Drupal.
- Support Drupal.
- Support Drupal.
