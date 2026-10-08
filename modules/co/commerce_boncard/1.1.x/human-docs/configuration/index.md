# Configuration

Setting up Commerce Boncard has two parts: entering your account credentials, and
adding the redemption pane to your checkout flow.

## 1. Enter your Boncard credentials

1. Log in as a user with the **administer commerce_boncard configuration**
   permission.
2. Go to **Administration → Commerce → Configuration → Boncard**
   (`/admin/commerce/config/boncard`).
3. Fill in the credentials from your Boncard contract:
   - **User ID** — your Boncard user identifier.
   - **Terminal ID** — the terminal identifier used in signed requests.
   - **Merchant ID / merchant name** — your merchant identity (can be localised
     per store).
   - **API password** — the shared secret used both to authenticate to Boncard
     and as the **HMAC‑SHA256 signing key** for every outbound request. This is
     the sensitive value; treat it as a secret (see below).
   - **Endpoint** — the Boncard API base URL for your account/environment.

Save the form.

## 2. Add the redemption pane to your checkout flow

1. Go to **Commerce → Configuration → Checkout flows**
   (`/admin/commerce/config/checkout-flows`) and edit the flow you use.
2. Add the **Boncard Redemption** form to the sidebar step, alongside where
   coupon redemption normally sits.
3. **Important:** in the **Payment** step, place **"Boncard processing"** *before*
   "Payment process". Order matters here — the gift card must be processed ahead
   of the remaining payment.
4. Save the checkout flow and run a test order end‑to‑end.

## Managing transactions

Once live, each redemption creates a `commerce_boncard` transaction that moves
through its workflow (New → Authorized → Complete → Partially refunded →
Refunded). Manage them from the **Giftcards** tab on the order — you can capture,
cancel/void, and refund from there. These operations are gated by the module's
permissions (create/view/edit/cancel/refund/delete Boncard transaction), so grant
those carefully to the right roles.

## Storing the API password securely

The API password is both a credential and the request‑signing key, so it must not
be committed to code or exported in plain text. On DDEV, store it as an
environment variable:

```bash
ddev dotenv set .ddev/.env --boncard-api-password='<your-password>'
ddev restart
```

Reference it through a **Key** entity where supported rather than pasting the raw
value into the form, and keep `.ddev/.env` out of version control.

## Security notes

- This is an **outbound‑only** integration — your site calls Boncard and there is
  **no inbound webhook** to forge. Every request is **HMAC‑SHA256 signed** with
  your API password, and the HTTP client uses standard TLS verification.
- Order operations are protected by **per‑operation entity access checks** and
  granular **permissions**, so limit who can refund/cancel.
- Be aware that the **card number and CVC are stored on the transaction entity**.
  Restrict access to Boncard transaction entities and protect your database
  accordingly.
- Always run the site over **HTTPS**.
