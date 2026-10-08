<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Redsys payment provides secure off-site Redsys (Spanish bank TPV) payments for Drupal without requiring Drupal Commerce, with optional Webform and Commerce integrations that share its signing and callback validation.

---

Redsys payment (2.x, renamed from "Redsys Button to Drupal") lets a Drupal site accept off-site Redsys
card, Bizum, PayPal, and xPay (Apple/Google Pay) payments. It ships a **Redsys payment form** block
(`redsys_button_block`) that redirects the customer to the Redsys gateway, and every attempt is stored as
an auditable `redsys_payment` content entity listed at `/admin/content/redsys-payments`. Merchant secrets
are stored through the **Key** module (a hard dependency), never in exported config. Signing supports
`HMAC_SHA512_V2` (default for new installs) and `HMAC_SHA256_V1` (legacy terminals). Version 2.1 adds
fixed-amount, token-protected **payment requests** (`redsys_payment_request` entity) — shareable payment
links with an immutable amount/concept, allowed methods, optional payer email and expiry. The bank posts
results to `/redsys/notify`; that callback verifies the Redsys `Ds_Signature` and the immutable
amount/currency/merchant/terminal/transaction-type against the local operation before marking anything paid,
is idempotent, and sends confirmation email only after a signed success. Optional submodules
`commerce_redsys_button` (four off-site Commerce gateways) and `redsys_button_webform` (a `redsys_payment`
Webform handler with draft-until-paid submissions) reuse the same core.

---

- Accept off-site Redsys payments without installing Drupal Commerce.
- Place a Redsys payment form block for one-off payments.
- Take card, Bizum, PayPal, or xPay (Apple/Google Pay) payments.
- Store the Redsys merchant secret in a Key entity, not in config.
- Sign requests with HMAC SHA-512 V2 (or legacy SHA-256 V1).
- Verify the signed Redsys notification before fulfilling.
- Audit every payment attempt as a `redsys_payment` entity.
- Create fixed-amount, token-protected payment links (payment requests).
- Set an optional expiry on a payment link, auto-expired via cron.
- Duplicate a pending payment request to reissue with a fresh token.
- Cancel or reopen rejected/canceled payment requests.
- Restrict which methods a payment request allows.
- Send a signed-payment confirmation email to payer and/or admin.
- Show a token-protected receipt page after the customer returns.
- Add Redsys card/Bizum/PayPal/xPay gateways to Drupal Commerce.
- Give each Commerce gateway its own terminal and key.
- Accept EUR, USD, or GBP through Commerce.
- Collect payment inside a Webform via the Redsys payment handler.
- Keep a Webform submission a draft until Redsys confirms payment.
- React to completed payments with the `redsys_button.payment_completed` event.
- Observe status changes via the `redsys_button.payment_status` event.
- Migrate a legacy 1.x plaintext key into a Key entity on update.
- Operate a separate test and live Redsys environment per config.
- Reconcile against the local audit log and Redsys back office.
