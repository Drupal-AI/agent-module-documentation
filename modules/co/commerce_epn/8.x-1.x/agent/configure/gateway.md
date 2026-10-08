<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the EPN gateway

1. Enable the module (requires `commerce_payment`).
2. Add a payment gateway of type **eProcessingNetwork** and set:
   - **Username** — your EPN account id (`ePNAccount`). Sandbox test value is `080880`.
   - **Restrict Key** — the RestrictKey from the EPN back end. Sandbox test value is `yFqqXJh9Pqnugfr`.
   - **Test mode** — only for production accounts (sends the account id instead of the PAN).
3. Because this is an **on-site** gateway, card fields render on your checkout; ensure HTTPS and be aware of PCI scope.

## Transaction lifecycle (TranType)
- `Store` — tokenize a card (createPaymentMethod); only last 4 digits stored locally.
- `Sale` / `AuthOnly` — createPayment (capture flag decides).
- `Auth2Sale` — capturePayment / voidPayment.
- `Return` — refundPayment.

## Security posture
Server-to-server only: `_post_transaction()` POSTs to the EPN HTTPS endpoint with Guzzle and does not disable TLS verification. There is no return/notify route, so no unauthenticated callback can complete an order. The amount sent is always `$payment->getAmount()->getNumber()` (the order/payment amount), not a client-supplied value, so no payment-amount tampering via request. Replace the shipped sandbox credentials with your live EPN account before taking real payments.
