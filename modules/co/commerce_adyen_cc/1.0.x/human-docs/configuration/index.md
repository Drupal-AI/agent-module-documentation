# Configuration

You configure Commerce Adyen (Credit Card) by adding it as a **payment gateway**
in Drupal Commerce, then entering your Adyen credentials and choosing whether it
runs in test or live mode.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a name (for example "Credit card (Adyen)") and choose the **Adyen**
   plugin provided by this module.

## Key fields

The exact labels depend on the release, but you'll configure:

- **Mode: Test or Live** — start in **Test** while you integrate, and switch to
  **Live** only once you've verified real card flows. This determines which Adyen
  environment the module talks to.
- **API key** — your Adyen API key. Reference it from a Key entity backed by an
  environment variable rather than pasting the raw value (see
  [Installation](../installation/index.md)).
- **HMAC key** — the key Adyen uses to sign notification webhooks. The module
  verifies this signature to confirm payment outcomes, so it must match the HMAC
  key configured in your Adyen dashboard. Keep it secret.
- **Merchant account** and any client/component settings required by Adyen's Card
  Component, plus 3D Secure 2 options where offered.

## Set up the Adyen notification webhook

Adyen confirms payment results asynchronously by sending **HMAC‑signed
notifications** to your site. In your Adyen dashboard, configure the notification
(webhook) to point at your site, and set the same HMAC key you entered above. The
module **verifies the HMAC signature** on each notification before recording a
payment — this is what stops an attacker forging a "paid" result, so never
short‑circuit or disable that verification, and never treat a browser return as
proof of payment on its own. Always serve these endpoints over HTTPS.

## Save and test

Save the gateway. With the gateway in **Test** mode, place an order and pay using
Adyen's published test card numbers (including a 3D Secure test card to exercise
that flow). Confirm the payment appears against the order and that Adyen's
notification is received and validated. Because this is a development release,
review the notification/verification behaviour for your exact version before
switching to **Live**.
