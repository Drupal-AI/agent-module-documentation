# Configuration

Commerce Paybox Payment is configured as a Drupal Commerce **payment gateway**.

## Add the gateway

1. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **Paybox** plugin.
3. Give it a name and configure the settings:
   - **Site / rank / identifier** — your Paybox merchant credentials.
   - **Secret / HMAC key material** — used to sign the requests your site sends to
     Paybox.
   - **Paybox public key** — the key used to **verify the signature** on the return
     from Paybox. This is what makes the return trustworthy, so it must be correct.
   - **Mode** — choose **Test** while integrating, then switch to **Live
     (production)** when you go live. Test data is available in Paybox's (French)
     bank documentation.
4. Save, then attach the gateway to your **checkout flow** so customers can select
   it.

## How a payment is confirmed (and why it's safe)

When the shopper finishes on Paybox's hosted page they are redirected back to
`/checkout/{order}/payment/api-return`. Before the module records anything, an access
check runs in this order — any failure blocks the payment:

1. The request must be **anonymous** (authenticated sessions are rejected on the
   return route, which is meant for the redirect back).
2. The `Ref`, `Mt`, `Signature`, and `Error` query parameters must all be present.
3. The payment referenced by `Ref` must load and must **not already be completed**
   (so a return can't be replayed to reprocess an order).
4. The signature must verify: `openssl_verify()` against your configured **Paybox
   public key** must succeed.

Only when all of these pass does the module record the payment. A forged or missing
signature therefore cannot complete an order — the fulfilment path is unreachable
without a valid Paybox signature.

Staff can also add a payment to an order from the admin UI (a redirect form plus
return/cancel handling under the order's payments tab); those routes require
**create payment** access.

## Keeping credentials safe

Your Paybox secret/HMAC material and identifiers are sensitive. Prefer keeping the
real values **out of version control** — for example, set them in your environment
and reference them rather than committing them in exported configuration. With DDEV
you can store a secret as an environment variable:

```bash
ddev dotenv set .ddev/.env --paybox-secret=<value>
ddev restart
```

(Never commit `.ddev/.env`.) Restrict who can administer payment gateways, and
protect your configuration exports, since gateway settings live in Drupal
configuration.
