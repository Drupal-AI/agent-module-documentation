<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Coinbase adds a Coinbase Commerce cryptocurrency payment gateway to Drupal Commerce, with an off-site redirect checkout and a signature-verified webhook.

---

Commerce Coinbase implements the Coinbase Commerce API as an off-site payment gateway for Drupal Commerce, letting customers pay with cryptocurrency. At checkout the module creates a Coinbase charge through the Coinbase Commerce REST API and redirects the shopper to Coinbase's hosted invoice page; when the payment is made, Coinbase notifies the site through a webhook at `/coinbase/webhook/{commerce_payment_gateway}` and the order is placed on a confirmed charge. The webhook is anonymous by design (Coinbase's servers must reach it) but verifies the `X-CC-Webhook-Signature` HMAC — it recomputes `hash_hmac('sha256', payload, secret)` over the raw request body with the gateway's shared secret and rejects the request on any mismatch before fulfilling, so forged callbacks cannot complete an order. Fulfilment happens only on a genuine `charge:confirmed` event, the order is identified by an id carried in the signed payload, and an already-completed payment is skipped so a replayed event is ignored. The module depends only on Commerce (`commerce`) and Commerce Payment (`commerce_payment`); it needs no external PHP library, no cURL check, and no cron. It supports Drupal 9, 10, and 11.

---

- Accept cryptocurrency payments through Coinbase Commerce.
- Integrate the Coinbase Commerce REST API (`api.commerce.coinbase.com`).
- Provide an off-site redirect payment gateway (`coinbase_offsite`).
- Create a Coinbase charge at checkout and redirect to the hosted invoice.
- Carry the order id, order number, and customer id in the charge metadata.
- Receive payment status via a webhook.
- Verify the webhook HMAC signature over the raw body before acting.
- Reject forged or unsigned callbacks.
- Complete the payment and place the order on `charge:confirmed`.
- Skip an order whose payment is already completed (replay-safe).
- Bind the payment to the order via the signed metadata order id.
- Store the remote charge code as the payment remote id.
- Support token replacement in the charge name and description.
- Depend only on Commerce `commerce` and `commerce_payment`.
- Run without any external PHP library, cURL requirement, or cron.
- Support Drupal 9, 10, and 11.
- Configure the API key and webhook shared secret on the gateway.
- Provide a `crypto_wallet` payment method type.
- Keep an internal request/response/webhook log table.
- Validate charge parameters before calling Coinbase.
