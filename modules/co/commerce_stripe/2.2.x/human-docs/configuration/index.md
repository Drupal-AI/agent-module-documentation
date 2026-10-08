<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

There are two layers to configure: a small set of **global settings**, and a
**payment gateway** for your Stripe account (where the API keys and webhook secret
live).

## Get your Stripe keys

From your Stripe dashboard (Developers → API keys) you need:

- a **publishable key** — `pk_test_…` for testing, `pk_live_…` for production;
- a **secret key** — `sk_test_…` for testing, `sk_live_…` for production.

The publishable key is safe to expose in the browser. The **secret key is a
credential** — treat it like a password (see "Keeping the secret key out of
config" below).

## Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
   (This needs Commerce's *Administer payment gateways* permission.)
2. Choose the **Stripe Payment Element** plugin — the modern, recommended option.
   (The legacy **Stripe Card Element** plugin is still available if you need it.)
3. Set the **Mode** to **Test** while you set things up.
4. Enter your **publishable key** and **secret key** (or connect via Stripe Connect
   — see below).
5. Configure the payment behavior you need:
   - **Capture method** — automatic (charge immediately) or manual (authorize now,
     capture later).
   - **Payment method usage** — whether to store cards on file for repeat
     customers.
   - **Express checkout** — enable Apple Pay / Google Pay / Link buttons, optionally
     on the cart page, and choose which methods to offer and whether to collect a
     phone number or billing address.
   - **Style** — the Payment Element's theme and layout, and the checkout display
     label.
6. Add the **webhook signing secret** (see the webhook section below).
7. **Save** the gateway.

Saving the gateway does not itself call Stripe — only real checkout and refund
operations hit the API.

## Keeping the secret key out of config

Your Stripe secret key must never be committed to version control or exported in
your site's configuration. The recommended approach is to store it in an
environment variable and reference it, rather than typing it into config that gets
exported.

With DDEV, save the value into `.ddev/.env` (which stays out of version control)
and restart so the container picks it up:

```bash
ddev dotenv set .ddev/.env --stripe-secret-key=sk_test_XXXXXXXX
ddev restart
```

The flag `--stripe-secret-key` becomes the environment variable
`STRIPE_SECRET_KEY` inside the web container. You can then feed that value into the
gateway's secret key from `settings.php` with a configuration override, so the real
secret lives only in the environment:

```php
// settings.php (or settings.local.php)
$config['commerce_payment.commerce_payment_gateway.<your_gateway_id>']['configuration']['secret_key'] = getenv('STRIPE_SECRET_KEY');
```

Replace `<your_gateway_id>` with the machine name of the gateway you created. This
keeps the secret out of the database export and out of Git, while the publishable
key (which is not sensitive) can stay in the gateway config.

## Set up the Stripe webhook

Stripe uses webhooks to tell your site about payment events (captures, refunds,
disputes, and asynchronous payment methods). Without the webhook, some payment
statuses will not update correctly.

1. In your Stripe dashboard, add a webhook endpoint pointing at your site's Stripe
   webhook URL (Commerce Stripe exposes a webhook receiver route; consult the
   module's README for the exact path for your version).
2. Stripe shows a **signing secret** for that endpoint (`whsec_…`).
3. Put that signing secret into the gateway's **Webhook signing secret** field so
   incoming webhooks are verified. Because this is also a credential, you can store
   it in an environment variable and override it from `settings.php` the same way as
   the secret key.
4. Enable the **Commerce Stripe Webhook Event** submodule (see
   [Installation](../installation/index.md)) if you want incoming events logged and
   processed.

## Stripe Connect (instead of pasting keys)

Rather than entering a secret key, an admin can authorize a Stripe account via
**Stripe Connect** OAuth from the gateway's *Connect* tab. The resulting access
token and Stripe user id are then stored on the gateway in place of the secret key.

## Global settings

Go to **Commerce → Configuration → Stripe settings**
(`/admin/commerce/config/stripe`), which needs the **Administer commerce stripe**
permission:

- **Load Stripe.js on every page** *(off by default)* — loads Stripe's script
  site-wide for fraud detection and session continuity, not only on checkout pages.
- **Collect user fraud signals** *(on by default)* — sends Stripe's advanced fraud
  detection signals.
- **Link payments to their remote ID** *(off by default)* — turns each payment's
  remote ID into a deep link to the Stripe dashboard (works together with the
  *View stripe dashboard links* permission).

## Permissions

- **Administer commerce stripe** *(restricted)* — the global Stripe settings form
  and the Stripe Connect forms.
- **View stripe dashboard links** — lets staff open the linked object directly in
  the Stripe dashboard.

Creating and editing the gateway entities themselves is governed by Commerce's own
**Administer payment gateways** permission.

## Going live

When testing is complete: switch the gateway **Mode** to **Live**, swap the
publishable and secret keys for your live (`pk_live_…` / `sk_live_…`) values via the
same environment-variable mechanism, and create a live webhook endpoint in Stripe
with its own signing secret.
