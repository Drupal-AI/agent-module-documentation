# Configuration

You configure this module by adding a Stripe iDEAL payment gateway, entering your Stripe
credentials, and registering a signed webhook in your Stripe Dashboard.

## Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose **Stripe iDEAL**.
3. Enter your Stripe **secret key**, **publishable key**, and the **webhook signing secret**.
4. Choose the **mode** — **Test** while setting up, **Live** for real payments — with the
   matching keys. The module validates the key/mode against the Stripe Balance API.
5. Save the gateway.

## Register the signed webhook

In your Stripe Dashboard, add a webhook endpoint pointing at this gateway's notify URL, then
copy its **signing secret** (beginning `whsec_`) into the gateway's webhook signing secret
field in Drupal.

The webhook handler verifies the `Stripe-Signature` header via Stripe's
`Webhook::constructEvent()` using that signing secret, and rejects any request whose
signature does not validate. It completes payment on `payment_intent.succeeded` and voids it
on `payment_intent.payment_failed`. Because verification depends on the signing secret being
set, configure it before going live so forged webhook calls are rejected.

## Handle the Stripe secrets securely

The Stripe **secret key** and the **webhook signing secret** are credentials — keep them out
of committed configuration by storing the values in environment variables. With DDEV:

```bash
ddev dotenv set .ddev/.env --stripe-secret-key=<sk_...> --stripe-webhook-secret=<whsec_...>
ddev restart
```

Keep `.ddev/.env` out of version control. Where the fields support it, reference the values
through [Key](https://www.drupal.org/project/key) entities rather than pasting the raw
secrets into the form. The publishable key is not secret.

## How payment is confirmed (why it is safe)

Order status never comes from request data. On return from the iDEAL flow the module
re-retrieves the PaymentIntent directly from Stripe, and the webhook handler verifies
Stripe's signature before acting. Only Stripe's authoritative report of success completes the
payment, and the returned payment method is stored on the order.

## Test before going live

In **Test** mode with your Stripe test keys and a test webhook, place a test order, complete
the iDEAL flow, and confirm the order is marked paid only after Stripe confirms it. Use
Stripe's webhook tester to confirm unsigned/forged requests are rejected. Then switch to
**Live** mode with your live keys and live webhook secret.
