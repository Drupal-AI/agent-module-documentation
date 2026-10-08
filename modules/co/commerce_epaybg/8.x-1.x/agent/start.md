<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Agent orientation: commerce_epaybg

**What:** Off-site Commerce gateway for ePay.bg (Bulgaria).

**Key files:**
- `src/Plugin/Commerce/PaymentGateway/EpayoffsiteRedirect.php` — `onNotify()` (verifies HMAC via service, maps status→transition), `createCommercePayment()`.
- `src/EpayConnectionService.php` — `commerceEpaybgReceiveData()` verifies HMAC-SHA1 before parsing; `commerceEpaybgCreatePostData()` builds signed request.

**Security:** IPN checksum = HMAC-SHA1 keyed by merchant secret; payload parsed only on match; order resolved via signed invoice→`commerce_epaybg_payments` mapping. `EpayRedirectController` is an unrouted dev mock.
