# Configuration

Configuring Commerce Mercado Pago means adding a payment gateway and entering the
credentials from your Mercado Pago developer account. The 3.0 release refactored
this form for a cleaner admin experience.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a **Name** and choose the **Mercado Pago (Checkout Pro)** plugin.

## The settings, field by field

- **Environment / mode** — the module supports **Test**, **Stage**, and
  **Production** environments to ease implementation. Start in Test, move to Stage
  to rehearse your production account with test keys, and finally switch to
  Production keys to go live.
- **Public key** and **Access token** — paste these from your Mercado Pago
  integration. Use your **test** credentials while in the test/stage
  environments, and your **production** credentials to accept real payments.
- **Checkout redirect style** — choose **Redirect** (same window, the default) or
  **External redirect** (opens Checkout Pro in a new window).
- **Installments** — enable installment handling at checkout if your market and
  account support it.
- **Excluded payment methods / types** — optionally exclude specific payment
  methods or types directly from the store settings so they are not offered.
- **Debugging mode** — turn on the debug/logging option while implementing to get
  cleaner, more detailed logs; leave it off in normal production use.

Save the gateway.

## Keep your access token secret

Your Mercado Pago **access token** is a secret — treat it like a password:

- Don't commit it to version control.
- Prefer storing it in an environment variable rather than hard-coding it. With
  DDEV you can set it once with the built-in dotenv command:

  ```bash
  ddev dotenv set .ddev/.env --mercadopago-access-token='<your token>'
  ddev restart
  ```

  Keep `.ddev/.env` out of version control.
- Always serve checkout over **HTTPS**.

## How the payment is confirmed (why it's safe)

When the customer returns from Mercado Pago, the module **verifies the payment
against the Mercado Pago API before trusting the return query parameters**, and it
also listens for Mercado Pago's **IPN webhook** (`onNotify()`). Both paths derive
the order's paid status from Mercado Pago's authenticated API rather than from
data the browser could forge, so a spoofed return cannot mark an order paid.

## Test before going live

Create a test integration and a test user in Mercado Pago, run payments through
the Test (and then Stage) environments, and track them in your Mercado Pago test
account. Only swap to your production keys once the flow works end to end.
