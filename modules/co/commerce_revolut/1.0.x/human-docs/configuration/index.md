# Configuration

Commerce Revolut is configured by adding a Commerce **payment gateway**. It has no
separate settings page and stays inactive until you add the gateway and enter your
Revolut credentials. The checkout flow works both with and without a review pane —
no extra configuration is needed for that.

## Store your Revolut credentials safely first

Revolut gives you an API key / secret for your merchant account. Protect these
like passwords — **never commit them to Git or paste them into exported
configuration**.

On a DDEV site the recommended pattern is an environment variable referenced
through a Key entity:

```bash
# Store the API secret in DDEV's env file (never commit .ddev/.env)
ddev dotenv set .ddev/.env --revolut-api-secret=<value>
ddev restart
```

With the [Key](https://www.drupal.org/project/key) module enabled, create a Key
that reads the `REVOLUT_API_SECRET` environment variable and reference it on the
gateway form rather than pasting the raw secret.

## Add the payment gateway

The module offers **three** Revolut gateway plugins — pick the one that matches how
you want customers to pay:

- **Revolut Checkout** (`revolut_checkout`) — onsite credit-card fields embedded in
  Commerce checkout (card data goes straight to Revolut's widget).
- **Revolut Pay** (`revolut_pay`) — an onsite Revolut Pay button in checkout.
- **Revolut Payment Link** (`revolut_payment_link`) — sends the customer to a hosted
  Revolut checkout page and back.

You can add more than one gateway if you want to offer several methods.

1. Log in as a user who can administer Commerce configuration.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a **name** and choose one of the three **Revolut** plugins above.
4. Enter your **Revolut Public Key** and **Secret Key** (prefer a Key entity /
   settings override over pasting raw live secrets).
5. Optionally tick **Log API calls** only for debugging (leave it off in
   production).
6. Choose the **mode** — **Test** while integrating, **Live** only after a
   confirmed test payment.
7. Save the gateway.

## How completion works (and why it's safe)

When the customer returns from paying, the module **re-fetches the Revolut order
from Revolut's API** (using the Revolut order ID stored against the local order)
and sets the payment state from the **API's** status — not from anything in the
browser redirect. A `completed` status completes the payment; `pending` or
`processing` raise a payment failure. Because the decision comes from Revolut's
server, a customer cannot fake a paid order.

The webhook handler (`onNotify()`) is currently a no-op, so fulfilment relies on
this verified return. If you enable Revolut webhooks in future, make sure their
signatures are verified before trusting them.

## Test before going live

Complete at least one full purchase in **Test** mode, confirm void/capture/refund
behave as expected from the order management interface, and only then switch the
gateway to **Live**. Serve checkout over HTTPS.
