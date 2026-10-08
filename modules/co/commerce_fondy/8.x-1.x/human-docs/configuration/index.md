# Configuration

Fondy is configured like any other Drupal Commerce payment gateway: you create a
gateway entity and enter the credentials Fondy gave you. There is no separate
global settings form.

## Add the gateway

1. Log in as a user who can **administer commerce payment gateways** (an
   administrator by default).
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a **Name** (for example "Fondy") that customers may see at checkout,
   and select the **Fondy** plugin.

## Fondy credentials

Enter the values from your Fondy merchant dashboard:

- **Merchant ID** — your Fondy merchant identifier.
- **Secret key** — the secret used to sign and verify callbacks. This is what the
  module uses to confirm that a payment notification genuinely came from Fondy,
  so it must match exactly.

## Test vs live mode

Every Commerce gateway has a **Mode** setting — **Test** and **Live**. Start in
**Test** and run an end-to-end order using Fondy's test credentials before you
switch to **Live** with real ones. Save the gateway, then place a test order and
confirm the order is marked paid when you return from Fondy.

## Keep your secret key out of the codebase

The Fondy **secret key** is a credential: anyone who has it can forge valid-looking
payment notifications. The module stores it as an ordinary field on the payment
gateway configuration entity (it does **not** integrate with the
[Key module](https://www.drupal.org/project/key)), so the value ends up in your
exported site configuration. Do not commit that value to Git or paste it into a
tracked configuration file.

A clean pattern is to keep the real secret in an environment variable and inject
it with a configuration override in `settings.php`, so the exported config can
hold a placeholder:

1. Save the secret into DDEV's env file (this does *not* get committed):

   ```bash
   ddev dotenv set .ddev/.env --fondy-secret-key=<your-secret>
   ddev restart
   ```

2. Override the gateway's secret from the environment in `settings.php`
   (replace `<gateway_id>` with your payment gateway's machine name):

   ```php
   $config['commerce_payment.commerce_payment_gateway.<gateway_id>']['configuration']['secret_key'] = getenv('FONDY_SECRET_KEY');
   ```

If you do commit the gateway config, use a config-split or config-ignore workflow
so the secret is excluded from version control.

## How the payment is confirmed (why this gateway is safe)

You do not configure anything here, but it is worth understanding: when a shopper
returns from Fondy — and when Fondy posts its background notification — the module
verifies the response **signature** against your secret key and checks that the
**amount** in the callback equals the order amount. Only then does it complete the
payment, and it completes it using the **order's own total**, never a figure taken
from the callback. A tampered or unsigned callback is rejected. This is the
correct, defensive behavior for an off-site gateway, so there is nothing you need
to harden yourself beyond keeping the secret key confidential.
