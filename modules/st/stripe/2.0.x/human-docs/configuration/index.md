# Configuration

Stripe does nothing until you enter your API keys. This page covers the settings
form field by field, how to keep your secret keys out of exported configuration
(important — read the security section), and how to hook up Stripe's webhook.

## Open the settings form

1. Log in as a user with the **Administer stripe** permission (an administrator by
   default).
2. Go to **Configuration → System → Stripe**, or navigate directly to
   `/admin/config/system/stripe`.

## Environment

At the top of the form, **Environment** is a required radio choice between **Test**
and **Live**. It selects which set of keys (below) is active. Keep it on **Test**
while you build and verify your flow with Stripe's test cards, then switch to
**Live** when you go into production. You store keys for both environments at once,
so switching is a single toggle.

## Test and Live key sets

The form has a **Test** fieldset and a **Live** fieldset, each containing the same
three fields. Enter the matching keys from your Stripe dashboard:

- **Publishable** — your `pk_...` publishable key. This is sent to the browser (it's
  designed to be public) and is used by Stripe.js and the payment elements.
- **Secret** — your `sk_...` secret key, used server‑side to talk to Stripe. This
  field behaves like a password: it only overwrites the stored value if you type a
  new one, so you won't accidentally blank it by re‑saving the form. **Treat this
  as sensitive** — see the security note below.
- **Webhook secret** — your `whsec_...` webhook signing secret for the
  `/stripe/webhook` endpoint. If you set it, incoming webhooks are verified against
  this signature. If you leave it empty, the module falls back to re‑fetching each
  event from Stripe to validate it. Setting the signing secret is the recommended,
  more efficient approach.

Click **Save configuration** when done.

## Keeping secrets out of config

The form itself warns you: these keys are stored in the `stripe.settings` config
object, which Drupal exports as **plain text** and which is typically committed to
version control. You should **never commit a live secret key or webhook signing
secret**.

The recommended pattern is to leave the secret fields empty in the UI (or fill them
only for the test environment) and override them from an environment variable in
`settings.php`. For example:

```php
// settings.php
$config['stripe.settings']['apikey']['live']['secret'] = getenv('STRIPE_SECRET_KEY');
$config['stripe.settings']['apikey']['live']['webhook'] = getenv('STRIPE_WEBHOOK_SECRET');
```

That way the real secret lives in the environment, never in exported config.

> **DDEV tip.** Store the value as an environment variable rather than hard‑coding
> it: `ddev dotenv set .ddev/.env --stripe-secret-key=sk_live_...` (which becomes
> the variable `STRIPE_SECRET_KEY`), then `ddev restart` so the web container picks
> it up. Keep `.ddev/.env` out of version control. The `getenv()` calls above then
> read it inside the container.

## Setting keys from the command line

If you're scripting a non‑production environment, you can set the config values
directly with Drush (avoid this for live secrets — use the `settings.php` /
environment approach above instead):

```bash
drush config:set stripe.settings environment test -y
drush config:set stripe.settings apikey.test.public  'pk_test_xxx' -y
drush config:set stripe.settings apikey.test.secret  'sk_test_xxx' -y
drush config:set stripe.settings apikey.test.webhook 'whsec_xxx'  -y
```

## Hooking up the webhook

To have Stripe notify your site of events (successful payments, subscription
changes, and so on):

1. In your Stripe dashboard, add a webhook endpoint pointing at
   **`https://yoursite.example/stripe/webhook`**.
2. Copy the endpoint's signing secret (`whsec_...`) into the **Webhook secret**
   field for the matching environment (or into `settings.php` as shown above).
3. Write an event subscriber for the module's `WEBHOOK` event to act on the
   incoming Stripe event — for example fulfil an order on
   `payment_intent.succeeded`. The code pattern is in the sibling
   [`agent/`](../../agent/start.md) docs (the "Reacting to Stripe payments &
   webhooks" reference), and a complete working example ships in the
   `stripe_examples` submodule.

## Front‑end note

Once the module is enabled, Stripe.js (`https://js.stripe.com/v3/`) is loaded on
**every** page. This is intentional — Stripe uses it for fraud detection across
your site, not just on checkout pages. The publishable key is passed to the browser
by the payment elements when they render.
