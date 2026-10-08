# Configuration

Commerce Open Payment Platform is configured as a **Commerce payment gateway**, plus
one important shared setting — the **encryption secret** — if you use the webhooks
submodule.

## Store your credentials securely

Your OPP API credentials and the webhook encryption secret are secrets — never
hard‑code or commit them. With DDEV, keep each value in an environment variable and
load it through a Key entity:

```bash
ddev dotenv set .ddev/.env --opp-api-token=<value>
ddev dotenv set .ddev/.env --opp-encryption-secret=<value>
ddev restart
```

Install the Key module if it isn't enabled, then reference the variables from Key
entities so the secrets never live in exported configuration.

## Add the OPP payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **Open Payment Platform** plugin.
3. Enter your OPP API credentials (reference the Key entities above) and choose test
   or live mode.
4. Save. Only trusted roles should be able to administer payment gateways.

## How payments are confirmed (and why it's safe)

The COPYandPAY / PAYFRAME widget is embedded in checkout. Confirmation does **not**
rely on any client-supplied "paid" field. On return, and via the MB WAY polling
controller, the module re-queries the authoritative status directly from the OPP API
(authenticated `GET /v1/checkouts/{id}/payment` and `/v1/query`) and derives the
Commerce payment state from that response, checking that the order matches. This is
the correct server-authoritative pattern.

## The webhook encryption secret — set it and protect it

If you enable the **webhooks submodule** (`commerce_opp_webhooks`), OPP posts
notifications to a public endpoint (`/opp/webhooks`). That endpoint is protected by
**authenticated encryption**: it requires the `X-Initialization-Vector` and
`X-Authentication-Tag` headers and decrypts the body with **AES‑256‑GCM** using the
configured `encryption_secret`. A forged or tampered body fails the GCM
authentication tag and is rejected, so an attacker who doesn't know the secret cannot
drive fulfilment.

This security **depends entirely on the encryption secret being set and kept
secret**:

- Set `commerce_opp.settings:encryption_secret` (as a protected secret, per the DDEV
  + Key pattern above) to the value agreed with OPP.
- The endpoint **fails closed** if the secret is empty — it rejects *all* calls
  rather than accepting anything — so an unset secret means webhooks simply won't
  work, not that the door is open. Configure it correctly and never expose it.

## Test first

Run in test mode and confirm that a successful checkout corresponds to a genuine OPP
payment (and, if using webhooks, that notifications are accepted only when correctly
signed) before going live.
