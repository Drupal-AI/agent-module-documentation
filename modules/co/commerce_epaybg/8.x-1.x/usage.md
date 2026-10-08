<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce EpayBG

Adds an off-site redirect payment gateway for the Bulgarian ePay.bg service to Drupal Commerce, verifying ePay's HMAC-SHA1 signed notifications before updating payment state.

- Redirects the buyer to ePay.bg with a signed, base64-encoded payment request.
- Receives ePay's server notification (IPN) and verifies its checksum before acting.
- Maps ePay statuses (PAID/DENIED/EXPIRED) to Commerce payment transitions.
- Stores an invoice-to-order mapping so notifications resolve to the correct order.

---

## Installation & configuration

- Requires `commerce`/`commerce_payment` (>= 8.x-2.21); enable with `drush en commerce_epaybg`.
- Add a payment gateway of type "EpayBG (Redirect to EpayBG system)".
- Configure live/test MIN (merchant id), secret key, user email, description phrase and expiration time.
- Provide ePay with the module's notify (IPN) URL.
- An install hook creates the `commerce_epaybg_payments` tracking table.

---

## Usage & API

- `EpayConnectionService::commerceEpaybgCreatePostData()` builds the base64 payload and HMAC-SHA1 checksum keyed by the merchant secret.
- `commerceEpaybgReceiveData()` recomputes the HMAC and only parses the payload when the checksum matches.
- `onNotify()` reads `encoded` + `checksum`, verifies the signature, then loads the order via the invoice mapping.
- Signed statuses map to transitions: PAID→authorize_capture, DENIED→void, EXPIRED→expire.
- The invoice is stored per order in `commerce_epaybg_payments`, binding notifications to the originating order.
- `onReturn()` records the payment for the returning buyer.
- The notify response echoes `INVOICE=...:STATUS=OK/ERR` back to ePay as required.
- Checksum verification uses an HMAC-SHA1 implementation with the configured secret.
- Invalid checksums produce `ERR=Not valid CHECKSUM` and no state change.
- Payment amount is taken from the order total when creating the Commerce payment.
- Test vs live secret/MIN are selected by the gateway mode.
- The included `EpayRedirectController` is a development mock and is not wired to any route.
- Suitable for merchants using ePay.bg in Bulgaria.
- Ensure the merchant secret is kept confidential; it is the sole signature key.
- Logs exceptions to the `commerce_epaybg` logger channel.
