<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Pei adds an on-site Drupal Commerce payment gateway for Pei, an Icelandic buy-now-pay-later / installment provider.

---

Commerce Pei integrates the Pei payment provider (https://pei.is) with Drupal Commerce as an on-site payment gateway. During checkout the buyer identifies themselves with their SSN (kennitala) and phone number, receives a one-time SMS PIN from Pei, and confirms it — all on your own site, with no redirect and no inbound asynchronous callback. Once purchase access is confirmed, the order is charged synchronously against Pei's OAuth2-authenticated REST API and the payment is marked completed. It depends on Drupal Commerce (`commerce_payment`) and core `telephone`, requires `drupal/commerce ^2.25 || ^3.0`, and supports Drupal 10 and 11.

---

- Accept Pei (Icelandic BNPL / installment) payments in Drupal Commerce checkout.
- Offer an on-site gateway that keeps the buyer on your site through the payment step.
- Authorize a purchase with the buyer's SSN (kennitala) plus a one-time SMS PIN.
- Let Pei send the verification PIN to the buyer's phone via `requestAccess`.
- Confirm merchant purchase access for a buyer with `confirmAccess`.
- Skip the PIN step automatically when the merchant already has standing access to that buyer (`hasAccess`).
- Charge the order server-side via Pei's `api/orders/pay` endpoint on capture.
- Store the Pei order id as the Commerce payment `remote_id`.
- Configure the gateway with a merchant id and OAuth client id / secret.
- Switch between Pei test (staging) and live environments with the gateway `mode`.
- Validate Pei credentials at config-save time by fetching an OAuth token.
- Pre-fill the checkout SSN and phone fields from the customer billing profile (optional field mapping).
- Map arbitrary `profile.customer` fields to the SSN and telephone inputs.
- Add a `pei` payment method type carrying `telephone`, `issn`, and `pincode` fields.
- Present an AJAX-driven checkout form (request confirmation → enter PIN → confirm).
- Send order line items (SKU, name, quantity, unit price, adjusted total) to Pei.
- Use OAuth2 client-credentials authentication (scope `externalapi`) with the Pei auth server.
- Surface Pei API error codes (credit rating, buyer allowance, invalid PIN, card declined, etc.) as human-readable checkout messages.
- Log Pei API errors to the `commerce_pei` logger channel for debugging.
- Run entirely over HTTPS to the fixed Pei API and auth hosts (TLS verification on, redirects off).
- Support test/demo onboarding with Pei's public demo credentials.
- Manage stored Pei payment methods (update / delete the local entity).
- Integrate with the standard Commerce checkout and payment workflow without custom routes.
