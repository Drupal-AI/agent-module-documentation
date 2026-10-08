# Configuration

You configure Commerce Adyen Drop-in by adding it as a **payment gateway** in
Drupal Commerce, entering your Adyen credentials, and then registering the Adyen
webhook that finalises payments.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a name (for example "Adyen") and choose the **Adyen Drop-In** plugin.

## Key fields

- **Mode: Test or Live** — start in **Test**; switch to **Live** only after
  verifying the full flow. This, together with the live endpoint prefix, decides
  which Adyen environment is used.
- **API key** — your Adyen API key (reference a Key entity rather than pasting the
  raw value; see [Installation](../installation/index.md)).
- **Client key** — the Adyen client key used by the Drop-in component in the
  browser.
- **HMAC key** — the key Adyen uses to sign notifications; the module verifies
  this on every webhook. It must match the HMAC key set in your Adyen dashboard.
- **Merchant account** — your Adyen merchant account.
- **Live endpoint prefix** — required for live mode (from your Adyen account).
- **Timeout** — request timeout for calls to Adyen.

Billing information is required by this gateway, so make sure your checkout
collects it.

## Set up the AUTHORISATION webhook

In your Adyen dashboard, configure a **standard/AUTHORISATION webhook** pointing at
this gateway's notify URL, and set the **same HMAC key** you entered above. This is
essential: the module finalises payments from the webhook, not from the browser.
Each notification is **HMAC‑verified** before anything happens — failed
verifications are logged and skipped, only `AUTHORISATION` events with success
create a payment, and the order and amount come from the *signed* payload. Serve
the notify endpoint over HTTPS.

## How the payment flow behaves

- On return from the Drop-in, the gateway re‑fetches the session status directly
  from Adyen — it never trusts the browser result alone. Only `completed` /
  `paymentPending` sessions proceed; cancelled or expired sessions raise an error.
- Payment is finalised when the verified AUTHORISATION webhook arrives, which is
  Adyen's recommended pattern. Duplicate notifications for the same payment
  reference are detected and ignored.
- Refunds are issued through the Adyen Checkout API and tracked as partial or full.

## Save and test

Save the gateway. In **Test** mode, place an order, pay through the Drop-in with an
Adyen test card, and confirm the payment is recorded once the webhook is received
and validated. Only then switch the mode to **Live**.
