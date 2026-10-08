# Configuration

Commerce Banca Intesa is configured as a Commerce payment gateway. There is no
separate settings page — everything lives on the gateway you add.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a **Name** (shown to admins) and, under **Plugin**, choose **Banca
   Intesa**.

## Fields to fill in

The gateway plugin exposes the credentials the bank issued to you. Enter them
exactly as provided by Banca Intesa Serbia:

- **Merchant / client ID** — your NestPay merchant identifier. The module checks
  the value returned by the bank against this on the return leg, so it must
  match your account.
- **Store key** — the shared secret used to sign and verify the transaction
  hash. This is the single most sensitive value: anyone who has it can forge a
  valid signature. Treat it as a secret (see below).
- **Mode (Test / Live)** — every Commerce gateway offers a test vs live toggle.
  Start in **Test** and point at the bank's test environment while you validate
  the flow, then switch to **Live** for real transactions. Confirm you're using
  the matching endpoint/credentials for the mode you pick.

Any other fields (currency, language, or endpoint URL, depending on the release)
should be set to the values Banca Intesa gives you for your account.

## Storing the store key securely

The **store key** is a payment secret and must never be committed to code or
exported into configuration in plain text. On DDEV, save it as an environment
variable and, where the gateway supports referencing one, expose it through a
**Key** entity:

```bash
ddev dotenv set .ddev/.env --banca-intesa-store-key='<your-store-key>'
ddev restart
```

Then create a Key that reads that environment variable and reference it from the
gateway, rather than pasting the raw value into the form. Keep `.ddev/.env` out
of version control.

## Save and test

1. Set **Mode** to **Test** and save the gateway.
2. Place a test order and pay through the Banca Intesa redirect, then confirm the
   order is marked paid on return.
3. Only once the test flow works end‑to‑end, switch **Mode** to **Live**.

## Security notes

- The return leg is **signature‑verified**: the module recomputes the bank's hash
  with your store key and rejects any mismatch, requires the bank's success code
  (`ProcReturnCode == 00`), and records the payment for the order's own
  server‑side total — so a forged or amount‑tampered return cannot mark an order
  paid.
- Always run the site over **HTTPS**, and keep the **store key** (and the API
  **password**) secret as described above.
