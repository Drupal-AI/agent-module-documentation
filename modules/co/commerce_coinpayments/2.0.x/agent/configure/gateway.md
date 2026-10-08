<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the CoinPayments gateway

1. Enable the module and grant **access commerce coinpayments ipn** (typically to the anonymous role) so CoinPayments' servers can POST to `/commerce_coinpayments/ipn`.
2. Add a payment gateway (Commerce → Configuration → Payment gateways) of type **CoinPayments** and enter:
   - Merchant ID
   - Public / Private API keys
   - IPN secret (this value keys the HMAC-SHA512 verification)
3. Place it in test/sandbox mode first, run an order, and confirm the IPN transitions the payment to completed.

**How confirmation is secured:** `IPNCPHandler::checkIPNRequest()` recomputes `hash_hmac('sha512', <raw POST body>, <IPN secret>)` and compares it to the `HMAC` header, and validates merchant id, currency and amount before the order is completed (IPNCPHandler.php:215-244). A forged or replayed IPN without the correct secret fails verification, so the anonymous-reachable route is safe by design.
