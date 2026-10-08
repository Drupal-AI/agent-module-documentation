# Configuration

Commerce EpayBG is configured on the payment‑gateway form — there is no separate
settings page.

## Add the gateway

1. Log in as a user who can administer Commerce.
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Choose the **EpayBG (Redirect to EpayBG system)** plugin.

## Fill in the fields

The fields come from your ePay.bg merchant account. The gateway stores separate
live and test values and uses the set that matches the gateway **mode**:

- **MIN (merchant id)** — your ePay.bg merchant identification number.
- **Secret key** — the merchant secret. This is the **sole signature key** for
  both the outgoing request and the incoming notification, so keep it
  confidential.
- **User email** — the ePay.bg account email.
- **Description phrase** — the payment description sent to ePay.
- **Expiration time** — how long the payment request stays valid.

Set the **mode** (test vs live) so the matching MIN/secret are used, then save.

## Give ePay the notify (IPN) URL

In your ePay.bg account, set the notification (IPN) URL to the module's notify
route for this gateway, so ePay can post the transaction result back to your site.
On a successful, verified notification the module echoes `INVOICE=…:STATUS=OK`
back to ePay as their protocol requires.

## Handle the secret as a secret

The merchant secret key is what makes forged notifications impossible, so treat it
like any credential: prefer storing it in an environment variable and referencing
it rather than committing it to exported configuration, restrict who can edit
payment gateways, and use distinct test and live secrets.

```bash
ddev dotenv set .ddev/.env --epaybg-secret=<value>
ddev restart
```

## How a payment completes

When ePay posts a notification, the module recomputes the HMAC‑SHA1 checksum from
the payload plus your secret and only parses and acts on the payload when the
checksum matches; an invalid checksum returns `ERR=Not valid CHECKSUM` and changes
nothing. Verified ePay statuses map to Commerce transitions — **PAID** captures,
**DENIED** voids, **EXPIRED** expires — and the payment amount is taken from the
order total. The invoice‑to‑order mapping created at install binds each
notification to the order that started it.
