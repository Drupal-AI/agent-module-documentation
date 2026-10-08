# Configuration

Configuring Commerce Monetico means adding a payment gateway and entering the
credentials from your Monetico (CIC / Crédit Mutuel) contract.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a **Name** and choose the **Monetico** plugin.

## The settings, field by field

- **Mode** — choose **test** while integrating and **production** for real
  payments. Monetico issues test and production parameters separately.
- **TPE number** — your Monetico terminal (TPE) number from your bank contract.
- **Company / merchant code** — the merchant identifier tied to your contract.
- **Security key** — the Monetico security key used to compute and verify the
  HMAC seal on the payment callback. This is the credential the whole security
  model depends on, so keep it confidential.

Save the gateway.

## Connect the callback URL

Monetico confirms payments by calling your site back at
`/commerce_monetico/response`. Make sure the return/notification URL configured in
your Monetico back office points at this endpoint on your site so the module can
process the result.

## Keep your security key secret

The Monetico **security key** is what makes the HMAC seal trustworthy — treat it
like a password:

- Don't commit it to version control.
- Prefer storing it in an environment variable rather than hard-coding it. With
  DDEV you can set it once with the built-in dotenv command:

  ```bash
  ddev dotenv set .ddev/.env --monetico-security-key='<your security key>'
  ddev restart
  ```

  Keep `.ddev/.env` out of version control.
- Always serve checkout over **HTTPS**.

## How the payment is confirmed

The `/commerce_monetico/response` callback recomputes the **HMAC-SHA1 seal** over
the returned fields and only accepts the payment when its computed MAC matches the
one Monetico posted; a mismatch is rejected as "MAC-NOT-OK" and never processed.
This verification depends on your Monetico security key staying secret.

## Test before going live

With the gateway in **test** mode and your Monetico test parameters, run a full
checkout and confirm the payment records against the order. Switch to
**production** parameters only once the test flow works cleanly.
