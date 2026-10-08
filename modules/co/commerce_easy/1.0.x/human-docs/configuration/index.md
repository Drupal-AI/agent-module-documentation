# Configuration

Commerce Easy is configured on the payment‑gateway form — there is no separate
settings page.

## Add the gateway

1. Log in as a user who can administer Commerce.
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Choose the **Nets Easy** plugin.
4. Enter your **Nets Easy credentials** (the API keys from your Nets/Nexi
   account) and choose the **mode** (test vs live) for this gateway.
5. Save.

## Handle your credentials as secrets

Your Nets API keys are secrets. Rather than pasting a live key into exported
configuration, store it in an environment variable and reference it through a
**Key** entity:

1. Save the value into DDEV's env file (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --nets-easy-secret-key=<value>
   ddev restart
   ```

2. Create a Key backed by that environment variable and select it (or reference
   the variable from settings) when configuring the gateway, so the secret is not
   stored in plain configuration.

Always operate over **HTTPS**, and keep separate test and live keys for your
development and production environments.

## Confirm payments server‑side

The important point for a hosted gateway like Nets Easy is the **payment
confirmation**. Your site should retrieve the payment/charge status from the Nets
API and only fulfil an order once Nets confirms the payment — it should **not**
treat the shopper's return from the hosted checkout as proof of payment on its
own. Because this is a development release, review the gateway's confirmation flow
for the version you install, and run a test‑mode order end to end before switching
to live.
