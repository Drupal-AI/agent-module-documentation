# Configuration

Billwerk+ Payments is configured by adding a Commerce **payment gateway**. It has
no separate settings page and stays inactive until you add the gateway and enter
your API keys. Saving the gateway also registers the notify webhook with
Billwerk+ automatically.

## Store your private keys safely first

Billwerk+ gives you **private API keys** — a live key and a test key. These are
sent to Billwerk+ as HTTP Basic auth over HTTPS, and they must be protected like
passwords: **never commit them to Git or paste them into exported configuration**.

On a DDEV site the recommended pattern is an environment variable referenced
through a Key entity:

```bash
# Store the live private key in DDEV's env file (never commit .ddev/.env)
ddev dotenv set .ddev/.env --reepay-private-key=<value>
ddev restart
```

With the [Key](https://www.drupal.org/project/key) module enabled, create a Key
that reads the `REEPAY_PRIVATE_KEY` environment variable and reference it on the
gateway form rather than pasting the raw key.

## Add the payment gateway

1. Log in as a user who can administer Commerce configuration.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a **name** and choose the **Billwerk+ Payments** plugin.
4. Enter the **live** and **test private API keys** (prefer Key entities over raw
   values).
5. Choose the **checkout type** — **window** or **modal** — which controls how
   Billwerk+'s hosted checkout is presented.
6. Set the **locale** for the checkout, and choose the **allowed payment methods**
   (cards, MobilePay, Klarna, and so on).
7. Decide whether to use **instant settle** (capture on order placement) or to
   authorize now and settle later.
8. Choose the **mode** — **Test** while integrating, **Live** only after a
   confirmed test payment.
9. Save. Saving registers the notify webhook with Billwerk+.

## Understand the webhook behaviour (security-critical)

When a payment event happens, Billwerk+ calls your store's notify endpoint. **In
this release that handler does not verify a signature on the request, and it
places/completes the order before independently re-checking the payment with
Billwerk+.** That is a meaningful risk: a forged or replayed anonymous POST to
the notify endpoint that references a draft order at the payment step could push
that order to *complete* without a genuine payment.

The customer-return path (`onReturn`) does re-fetch the invoice from Billwerk+ and
is sound for the payment entity itself, but you should not rely on the webhook
alone to protect fulfilment. Practical precautions:

- **Reconcile before fulfilment** — confirm payment in the Billwerk+ dashboard (or
  via a verified re-fetch) before shipping goods, rather than trusting the order
  state alone.
- **Restrict and monitor** the notify endpoint where your infrastructure allows.
- **Re-test on your exact version** — verify whether a later release adds
  signature verification, and prefer that release.

## Test before going live

Complete at least one full purchase in **Test** mode, confirm the authorize /
settle / refund / void operations behave as expected from the order's payment
tab, and only then switch the gateway to **Live**. Always serve checkout over
HTTPS.
