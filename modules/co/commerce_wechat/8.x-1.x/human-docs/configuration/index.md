# Configuration

Commerce WeChat Pay is configured as a Drupal Commerce payment gateway. You enter
your WeChat merchant credentials, and on save the module fetches and caches the
WeChat platform certificate it needs to verify notifications.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**, name it (for example "WeChat Pay"), and choose
   **WeChat Pay** as the plugin.

## Gateway settings, field by field

Enter the values from your WeChat Pay merchant account:

- **App ID** — the WeChat application id associated with the merchant.
- **Merchant ID** — your WeChat Pay merchant number.
- **API v3 secret key** — the APIv3 key used to decrypt (AES‑GCM) the notification
  payloads. Keep it confidential.
- **Merchant serial number** — the serial number of your merchant certificate,
  used when signing requests.
- **Merchant private key** — your merchant API private key. This is highly
  sensitive.
- QR‑code options let you set the **color and size** of the PC payment QR code
  (rendered via `yunke_qrcode`), and you can set a custom **payment expiration**
  time.

On save, the module contacts WeChat to fetch and cache the **platform
certificate** used to verify incoming notifications; it refreshes this roughly
every 12 hours automatically.

## How payments and notifications flow

- Asynchronous notifications arrive at Commerce's standard
  `commerce_payment.notify` route. The module verifies the notification's
  signature against the WeChat platform certificate (within a 5‑minute timestamp
  window), decrypts the payload with your APIv3 key, binds it to the local order
  by `out_trade_no`, checks the amount and currency, and only then completes the
  payment — repeated success notifications are handled idempotently.
- On the customer's return page the module actively re‑queries WeChat and
  re‑checks the paid amount and order ownership, so it never trusts the browser.
- Refunds (full and partial) are supported and tracked in order data.

## Handle the credentials safely

The APIv3 key and the merchant private key are secrets. Never commit them to
code. On DDEV, store each in an environment variable and reference it through a
**Key** entity where the field allows, rather than pasting it into exported
configuration:

```bash
ddev dotenv set .ddev/.env --wechat-apiv3-key=<value>
ddev restart
```

Always serve the site over **HTTPS** — WeChat notifications require it.

## Save and test

Click **Save**, then run a full test cycle — place an order, complete the payment
(Native/H5/JSAPI as appropriate), confirm the notification completes the Commerce
payment, and test a refund — before going live.
