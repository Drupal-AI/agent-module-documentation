# Configuration

CoinsPaid is configured like any Commerce payment gateway: add a gateway and enter
your CoinsPaid public and secret keys.

## About your keys

The gateway needs a CoinsPaid **public key** and **secret key**, both entered
directly in the payment-gateway configuration form (they are saved with the
gateway's Commerce configuration). The **secret key is what keys the callback
signature verification**, so protecting it is what keeps forged callbacks out:
keep it confidential, and treat any exported configuration containing the gateway
as sensitive (do not commit it to a public repository, and restrict who has the
payment-gateway administration permission). Always serve the site over HTTPS.

## Add the gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Give it a name and display label, and choose the CoinsPaid plugin.
3. Enter your **public key** and **secret key**.
4. Choose test/live mode and save.

## How confirmation is secured

This gateway follows the correct, defensive pattern:

- On each callback, the handler computes an **HMAC‑SHA512** over the callback body
  using your secret key and compares it to the **`X‑Processing‑Signature`** header,
  **throwing on any mismatch**. No payment is recorded for an invalid signature, so
  a forged or tampered callback is rejected.
- The payment is recorded using the **order's own total**, never an amount supplied
  in the callback — so a callback can't change what the customer is charged.

There is nothing extra you need to switch on for this protection; it is how the
gateway works. Your responsibility is to **keep the secret key confidential** and
serve the site over HTTPS.

## Test before going live

Put the gateway in test mode, run an order through to CoinsPaid, complete the
payment, and confirm the order finalizes only when the signed callback verifies.
Then switch to live mode.
