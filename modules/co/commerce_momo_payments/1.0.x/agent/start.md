<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Agent orientation: commerce_momo_payments

**What:** Commerce gateway for MoMo (Vietnam) — Wallet/ATM/CreditCard offsite payment.

**Key files:**
- `src/Plugin/Commerce/PaymentGateway/MoMoOffsitePaymentGatewayBase.php` — `getPayUrl()` (signs), `onReturn()`, `onNotify()`, `verifySignature()` (`hash_hmac sha256`), `generateSignature()`.
- Gateways: `MoMoWallet`, `MoMoPayWithATM`, `MoMoCreditCard`.

**Deps:** `commerce_payment`.

**Security:** the response signature is verified with the merchant secret (`verifySignature()`).
