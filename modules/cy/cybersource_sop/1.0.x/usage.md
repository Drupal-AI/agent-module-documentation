<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cybersource SOP is a Drupal Commerce payment gateway that uses Cybersource Secure Acceptance Silent Order POST, signing the outbound request and verifying the HMAC signature on every reply.
---
At checkout the gateway builds a Secure Acceptance form whose fields (including the amount, currency and reference number) are covered by an HMAC-SHA256 signature computed with the profile's shared secret, so the customer's browser cannot tamper with the signed values. Cybersource POSTs a signed reply back to the site's return and cancel routes; these are open (`_access: 'TRUE'`) on purpose because the request is a cross-site POST with no Drupal session — authentication is the HMAC signature, verified inside the gateway's `onReturn()`/`onCancel()`. The signer uses `hash_hmac('sha256', …)` and comparison uses constant-time `hash_equals` (reviewed sound).

Verification is defence-in-depth: the reply must carry a valid signature AND the signature must cover every field the payment logic acts on (`decision`, `reason_code`, `req_reference_number`, `transaction_id`, `req_amount`, `req_currency`) — a reply that appends an unsigned amount is rejected. The recorded payment amount is the order total (`$order->getTotalPrice()`), and the signed `req_amount`/`req_currency` must equal it or the payment is refused ("never record a payment for an amount that was not the one authorised"). Credentials live in an external `.yml` (one test profile for all currencies, one live profile per currency), never in site config. Set up by placing the credentials file and adding a Cybersource SOP gateway in Commerce.
---
- Add a Cybersource Secure Acceptance (Silent Order POST) gateway to Commerce
- Accept hosted card payments without handling raw card data on the server
- Sign outbound Secure Acceptance form fields with HMAC-SHA256
- Verify the HMAC signature on every Cybersource reply with hash_equals
- Reject replies whose signature does not cover amount/currency/decision fields
- Use the order total as the authoritative charge amount
- Handle the signed return POST at /cybersource-sop/return/{order}
- Handle the signed cancel POST at /cybersource-sop/cancel/{order}
- Store credentials in an external .yml outside site config
- Use one test profile for all currencies and a live profile per currency
- Map Cybersource reason codes to human-readable messages (ReasonCodes)
- Log gateway requests/responses through commerce_log templates
- Show a credentials-status warning when the .yml is missing
- Test in the Cybersource sandbox before switching to live profiles
- Complete or fail an order based on the signed decision/reason_code
