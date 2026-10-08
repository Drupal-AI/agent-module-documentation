# Configuration

Klarna is set up as a Drupal Commerce **payment gateway** — there is no separate
global settings page. You add one Klarna gateway and configure it there.

## Before you start: store your Klarna credentials safely

Klarna issues **API credentials** (an API key/username, and for some integrations
a client token). These are secrets. Never paste them into committed code or into a
configuration export that lands in version control.

On a DDEV site, keep the value in an environment variable and expose it to Drupal
through a **Key** entity:

1. Save the secret into DDEV's dotenv file:

   ```bash
   ddev dotenv set .ddev/.env --klarna-api-password=<your-secret>
   ddev restart
   ```

   The flag `--klarna-api-password` becomes the environment variable
   `KLARNA_API_PASSWORD`. Keep `.ddev/.env` out of version control.

2. Install the **Key** module if you don't already use it:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ```

3. Create a Key that reads the environment variable and reference it from the
   gateway form rather than typing the raw secret.

## Add the Klarna payment gateway

1. Log in as a user who can **administer commerce payment gateways** (an
   administrator by default).
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway** and give it a customer‑friendly **Name**.
4. Choose the **Klarna** plugin.

## Fill in the gateway settings

Work through the gateway form:

- **API credentials** — enter (or reference, via the Key above) your Klarna API
  key / username and, where required, the client token. This authenticates the
  server‑side calls the module makes to Klarna to authorize and manage orders.
- **Region** — **select the correct Klarna region for your account.** Klarna
  operates regional API endpoints, and choosing the wrong region is a common cause
  of authentication and payment failures.
- **Mode (test vs live)** — start in **test** while you set things up and switch to
  **live** only after confirming a real end‑to‑end payment. Using the wrong mode
  either fails against the live service or produces "orders" that were never really
  charged.
- **On‑site messaging** — optionally enable Klarna's promotional messaging (the
  "pay in installments from…" text) on product and cart pages, with style options
  for how it appears.
- **Express checkout** — enable this if you want the Klarna express‑checkout button
  on the cart page. If you also want to **collect the shipping address through
  Klarna**, tick that option *and* enable the **`commerce_klarna_shipping`**
  submodule (see [Installation](../installation/index.md)); without the submodule
  the express‑checkout flow will fail.
- **Button style** — configurable styling for the Klarna button.
- **Merchant Card Service** — only available if Klarna has enabled this for your
  account; it lets you use Klarna‑issued cards for payment. Treat it as a base
  integration to finish for your specific needs, and check with Klarna support.

## A note on order completion (why forged callbacks don't matter)

You don't need to expose or protect a "payment notification" URL for this gateway:
its notification handler is intentionally a **no‑op**, and orders are completed
through **authenticated server‑side calls to Klarna's API**. That means the store
never trusts a status sent in a request body — a forged callback cannot mark an
order paid. Authenticity comes from your credentials talking directly to Klarna.

## Save and test end to end

Click **Save**, then place a test order. Choose Klarna at checkout, complete the
Klarna flow, and confirm the order is marked paid in Commerce and reconciled
against Klarna's order management. Verify this against **test** before switching
to **live**. If you enabled express checkout or on‑site messaging, check those on
the cart and product pages too.

## Customization (for developers)

For most actions the module fires **events** you can subscribe to — see
`\Drupal\commerce_klarna\Event\KlarnaEvents`. These cover creating and updating
payment sessions (the order payload sent to Klarna), express checkout, shipment
events, and the Merchant Card Service card‑promise event, so you can enrich the
data sent to Klarna without patching the module.
