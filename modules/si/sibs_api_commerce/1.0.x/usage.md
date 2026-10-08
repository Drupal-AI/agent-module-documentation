<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SIBS API Commerce provides SIBS API integration for Drupal Commerce.

---

SIBS API Commerce **provides the SIBS payment gateway** for Drupal Commerce — the customer pays via SIBS
(off-site), and the module records/completes the payment. It depends on Commerce Payment and the SIBS API module.

Use it to accept SIBS payments. It is a **payment gateway**, and its fulfillment is **API-verified** (the important
control): both the `onReturn()` handler and the status endpoint call `SIBS API`'s `getPaymentStatus($remote_id)` —
**re-fetching the payment status from SIBS's authenticated API server-side** — and only mark the payment
`completed` (and transition the order) when the **API** reports `Success`; `onReturn` throws on Declined/Timeout. So
the outcome comes from SIBS, not from request data. The status route is `/sibs-api-commerce/payment-status/{order_id}`. Store the SIBS **merchant credentials as
secrets** (env/Key via the SIBS API module) and serve over HTTPS. Configure the SIBS gateway.

---

- Provide a SIBS payment gateway.
- Let the customer pay via SIBS.
- Record/complete the payment.
- Depend on Commerce Payment + the SIBS API module.
- VERIFY fulfillment via SIBS's API (re-fetch getPaymentStatus server-side).
- Complete only when the API reports 'Success' (onReturn throws on Declined/Timeout).
- Not trust request data for the payment outcome.
- Store the SIBS merchant credentials as secrets (env/Key) + HTTPS.
- Configure the SIBS gateway.
- Handle SIBS payments.
- Accept payments.
- Configure the gateway.
- Verify via API.
- Complete orders.
- Record payments.
- Re-fetch status.
- Secure the credentials.
- Provide a SIBS gateway.
