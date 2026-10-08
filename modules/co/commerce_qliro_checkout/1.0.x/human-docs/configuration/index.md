# Configuration

Commerce Qliro Checkout is configured the way every Commerce payment method is:
by adding a **payment gateway**. Until you do this and enter valid Qliro
credentials, the module does nothing.

## Handle your Qliro API credentials carefully

Qliro gives you API credentials (an API key and secret) that let your site talk
to its Merchant API. Treat these like passwords.

In this release the payment-gateway form takes the API key and secret as plain
text fields — it does **not** offer a Key-module selector — so the values are
saved into the payment-gateway configuration entity. Because of that:

- Restrict who can reach the gateway form: only trusted administrators should
  hold the *administer payment gateways* permission.
- Keep the gateway configuration out of any publicly shared or committed
  configuration export. If you export site config to Git, exclude this gateway's
  settings (or store the export privately) so the secret is not committed.
- Use **Test** credentials while integrating and only enter the **Live**
  credentials once you are ready to go live.

## Add the payment gateway

1. Log in as a user who can administer Commerce configuration.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a **name** customers won't necessarily see (for example "Qliro
   Checkout") and choose the **Qliro Checkout** plugin.
4. Enter your **Qliro API credentials** (merchant API key and secret) in the
   provided fields.
5. Set the other options as needed: **transaction mode** (authorize-and-capture
   vs. authorize-only), **purchase country**, **locale**, and the **path to your
   terms** (required) and integrity policy.
6. Choose the gateway **mode** — **Test** while you are integrating, **Live** only
   once you have confirmed end-to-end payments in test.
7. Save the gateway.

## How completion works

When a shopper pays through Qliro, they are sent to Qliro's embedded checkout and
then returned to your site. To decide whether an order was paid, the module calls
Qliro's **server-side Merchant API** and reads the order's status and amount from
that authenticated response; in this release the anonymous validation callback
handler is a no-op. The captured amount recorded against the order comes from the
Merchant API response rather than from the browser redirect.

## Test before going live

Complete at least one full purchase in **Test** mode and confirm the order moves
to a paid/completed state in Commerce before switching the gateway to **Live**.
