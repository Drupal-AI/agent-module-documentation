# Configuration

Commerce EuPlatesc is configured on the payment‑gateway form — there is no
separate settings page.

## Add the gateway

1. Log in as a user who can administer Commerce.
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Choose the **EuPlatesc Checkout** plugin.

## Fill in the fields

- **Merchant ID** — the merchant id issued by EuPlatesc.
- **Secret key** — your hex‑encoded EuPlatesc secret key. This field is
  write‑only: leaving it blank when editing an existing gateway keeps the stored
  value, so you never have to re‑enter it. This secret is the sole signing key —
  keep it confidential.
- **Redirect method** — how the off‑site form is submitted: **POST** (default) or
  **GET**.

Save the gateway.

## Set the IPN URL on EuPlatesc

In your EuPlatesc merchant account, set the IPN (notification) URL to your site's
notify route for this gateway:

```
https://yoursite.example/payment/notify/<gateway-machine-name>
```

Replace `<gateway-machine-name>` with the machine name of the gateway you created.

## Handle the secret as a secret

The secret key is what makes forged or replayed callbacks impossible, so protect
it like any credential — prefer storing it in an environment variable and
referencing it rather than committing it to exported configuration, and restrict
who can edit payment gateways:

```bash
ddev dotenv set .ddev/.env --euplatesc-secret-key=<value>
ddev restart
```

## How a payment is verified

You don't configure this — it's how the gateway protects you. Each outbound
request is signed with an HMAC‑MD5 `fp_hash` and carries a fresh timestamp and a
random 16‑byte nonce, and the amount is taken from the order, not from client
input. On both the browser **return** and the server **notification**, the module
recomputes the fingerprint and compares it with `hash_equals()`, then asserts that
the signed invoice id matches the order, that the order belongs to this gateway,
and that the signed amount and currency equal the order total — so a valid
signature cannot be replayed against a different order or amount. On success the
payment is captured and the order advances to *place*; on failure the order is
unlocked and an `authorization_voided` payment is recorded. The
`EuPlatescEvents::PAYMENT_SUCCESS` and `PAYMENT_FAILURE` events let other modules
react to the outcome.
