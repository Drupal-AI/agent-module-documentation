# Configuration

Setting up Commerce Opayo Pi has four parts: enter your Opayo credentials on the
generic settings form, add a Commerce payment gateway, attach the Opayo checkout
flow to your order types, and make sure a customer phone number is collected.

## Store your Opayo credentials securely

Your Opayo integration keys and passwords are secrets — never hard‑code or commit
them. With DDEV, keep each value in an environment variable and load it through a Key
entity:

```bash
ddev dotenv set .ddev/.env --opayo-live-password=<value>
ddev restart
```

Install the Key module if it isn't enabled, then reference the variables from Key
entities where possible so the credentials never live in exported configuration.

## 1. Generic settings

1. Go to **Commerce → Configuration → Opayo Pi settings**
   (`/admin/commerce/config/opayo_pi/settings`). You need the **Administer opayo
   transactions** permission.
2. Enter:
   - **Opayo vendor name**.
   - **Live and test integration keys and passwords**.
   - **Expired-record retention** — how long old payment methods and Opayo
     transactions are kept before cron cleans them up.
3. Save.

## 2. Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **Opayo (Pi integration)** plugin.
3. Enable **Collect billing information**.
4. Save.

## 3. Attach the Opayo checkout flow

Use the **Opayo checkout flow**, which adds the 3‑D Secure pane, and make sure the
relevant order types use it. Without this flow the 3‑D Secure step won't be
presented.

## 4. Collect a customer phone number

Opayo requires the customer's phone number in **international format** for 3‑D Secure
authentication. Provide it either as a plain-text field or (better) a **Phone
International** field on the customer profile/checkout.

## How the payment flow works (and why it's low-risk)

Card details are tokenized **client-side** — either through Opayo's drop-in checkout
widget or the module's own custom card form — using a short-lived **merchant session
key** minted by the module. The server then creates the transaction via the Opayo Pi
API, an optional **3‑D Secure** step runs (in an iframe or as a standalone page), and
the result is processed. Because the PAN goes only to Opayo and never to Drupal, your
PCI scope stays at SAQ‑A / SAQ‑A‑EP.

Four checkout-flow routes support this (two mint merchant session keys for the
browser JavaScript, two handle the 3‑D Secure redirect/result). They are reachable
during checkout, but the merchant session key is a **public-flow token**, not
order-owner-sensitive data, so this is an expected part of the design rather than a
weakness. The admin settings are gated behind the *Administer opayo transactions*
permission.

A cron handler (with Queue Unique) reconciles transaction status and expires old
`opayo_transaction` records according to the retention you set — so make sure cron
runs regularly.

## Note on security-advisory coverage

This project is **not** covered by Drupal's security advisory policy. Keep it
updated, run against Opayo's **test** integration keys first, and confirm the full
3‑D Secure flow before switching to live keys.
