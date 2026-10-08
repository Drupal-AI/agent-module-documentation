# Configuration

BeGateway Payment is configured as a Commerce payment gateway; there is no
separate settings page.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a **Name**, and under **Plugin** choose **BeGateway**.

## Fields to fill in

Enter the values from your BeGateway account:

- **Shop Id** — your BeGateway shop identifier.
- **Shop secret key** — the shop's secret key. It is used both to build the
  payment request and to authorize the incoming webhook (`isAuthorized()`), so it
  is the sensitive value; treat it as a secret (see below).
- **Action** — **Payment** (charge immediately) or **Authorization** (reserve
  funds for later capture).
- **Payment page domain** — the checkout domain of your provider, e.g.
  `checkout.begateway.com`. The module adds `https://` automatically.
- **Payment description** — text shown in the provider interface; you can use
  `commerce_order` token replacement patterns (order number, site name, etc.).
- **Timeout** — the number of minutes the customer has to complete the payment.
- **Enable bankcard / Enable ERIP / Enable HALVA bankcard** — turn on the payment
  methods you want to offer on the checkout page.
- **Mode (Test / Live)** — start in **Test** while you validate the redirect and
  notification flow, then switch to **Live** for real payments. Make sure your
  credentials match the mode.

If you have not set up a BeGateway account yet, the module ships with beGateway's
public **test** credentials (Shop Id `361`, checkout domain
`checkout.begateway.com`) so you can try the flow with a test card.

## Storing credentials securely

The shop secret key is a payment credential and should be backed by an
environment variable, not committed to code or exported config. On DDEV:

```bash
ddev dotenv set .ddev/.env --begateway-secret='<your-secret-key>'
ddev restart
```

Keep `.ddev/.env` out of version control, and prefer excluding the gateway's
credentials from any exported configuration you commit.

## Save and test

1. Set **Mode** to **Test** and save.
2. Place a test order and pay through the BeGateway redirect, then confirm the
   order completes on return.
3. Switch to **Live** only after the test flow works end‑to‑end.

## Security notes

- Notifications are **authenticated**: the notify handler verifies
  `$webhook->isAuthorized()` (shop‑id/secret credential check) before acting, and
  the return path compares the transaction amount to the order amount — so a
  forged or amount‑mismatched callback cannot complete an order.
- Keep the **shop secret key** out of version control, backed by an environment
  variable, and always run the site over **HTTPS**.
