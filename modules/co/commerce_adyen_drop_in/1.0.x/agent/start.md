<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Agent orientation: commerce_adyen_drop_in

**What:** Commerce payment gateway using Adyen Drop-in + Sessions.

**Key files:**
- `src/Plugin/Commerce/PaymentGateway/DropIn.php` — `setUpAdyenSession()`, `onReturn()` (re-fetches session from Adyen API), `onNotify()` (**HMAC-verified** via `HmacSignature::isValidNotificationHMAC`), `refundPayment()`.
- `src/PluginForm/OffsiteRedirect/PaymentOffsiteForm.php` — Drop-in JS wiring.

**Deps:** `commerce_payment` + Adyen PHP SDK.

**Security (reviewed, SOUND):** onNotify validates HMAC per item, only AUTHORISATION+success, order from signed `merchantReference`, amount from signed payload, dedupes by `pspReference`. onReturn re-fetches status server-side. TLS default-on.
