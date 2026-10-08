<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Agent orientation: commerce_hyperpay

**What:** Commerce gateway for HyperPay/OPPWA COPYandPAY (+ Apple Pay variant).

**Key files:**
- `src/Plugin/Commerce/PaymentGateway/HyperPayCopyAndPay.php` — `onReturn()` re-fetches status from `resourcePath` via `sendRequest()` (Bearer/HTTPS), **verifies amount == expected AND order id match** before capture; `createPayment()` (recurring) also amount-checks; `refundPayment()`.
- `src/Transaction/Status/*` — status factory/classes.

**Deps:** `commerce_payment`.

**Security (reviewed, SOUND):** no reliance on browser-supplied result — status/amount fetched server-side and bound to order+amount. TLS default-on. Bearer token in config.
