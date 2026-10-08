<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Agent orientation: commerce_eurobank_redirect

**What:** Off-site Commerce gateway for Eurobank / Modirum vPOS.

**Key files:**
- `src/Controller/CallbackController.php` — `callback()`/`processCallback()` verify SHA-256 digest, `calculateHash()` (fields + `shared_secret`), `createPayment()` (amount = `$order->getBalance()`).
- `src/Plugin/Commerce/PaymentGateway/EurobankPaymentRedirect.php` — config (default secret "SECRET").

**Route:** `/commerce_eurobank_redirect/callback` `_access: TRUE` (public callback — expected).

**Security (reviewed, SOUND):** digest = base64(sha256(response fields + per-order shared_secret)); strict `!==`; payment only on match + CAPTURED/AUTHORIZED; amount from server-side order balance; verification bound to the order via signed orderid. Change default secret in prod.
