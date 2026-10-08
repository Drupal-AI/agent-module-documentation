# Configuration

Mollie needs your account's **API key** before it can create any payments.
Everything on this page assumes you have a Mollie account and have opened its
dashboard to copy your keys.

## Open the settings form

1. Log in as a user with the **Administer Mollie** permission (an administrator
   by default).
2. Go to **`/admin/mollie`** (config route `mollie.configuration`).

## The API key

Mollie gives you two keys in its dashboard: a **test** key (starts with `test_`)
and a **live** key (starts with `live_`). Always develop and verify against the
test key first, then switch to the live key when you are ready to take real
money.

**Treat the API key as a secret.** It authorises charges against your Mollie
account, so it should never be committed to your repository or end up in
`config:export` output. The safe pattern on this project is to keep the value in
an environment variable and let Drupal read it from there:

1. Store the value with DDEV's dotenv helper (this never gets committed):

   ```bash
   ddev dotenv set .ddev/.env --mollie-api-key=live_xxxxxxxxxxxxxxxxxxxx
   ddev restart
   ```

   The flag `--mollie-api-key` becomes the environment variable
   `MOLLIE_API_KEY` inside the web container.

2. Prefer surfacing it through a **Key** entity (install the Key module if it is
   not already enabled) using the built-in environment provider, then point the
   Mollie settings at that key. Where a Key entity does not fit, read the variable
   directly in `settings.php` with `getenv('MOLLIE_API_KEY')`.

Because this key reaches out to Mollie's servers, make sure your site's outbound
network (egress) allows HTTPS calls to Mollie's API.

## The payment-confirmation webhook

When a customer pays, Mollie calls back to your site to confirm the result. This
callback is the security-critical part of any payment integration and must be
treated as untrusted: the module confirms a payment by **re-fetching the
authoritative status from Mollie's API** using the payment id, rather than
trusting values in the callback request. Keep your site on **HTTPS** so Mollie
can reach the webhook and so the exchange is encrypted.

## Commerce and Webform settings

- **Drupal Commerce:** after enabling `mollie_commerce`, add Mollie as a payment
  gateway under your Commerce configuration (**Commerce → Configuration →
  Payment gateways**) and select it in checkout.
- **Webform:** after enabling `mollie_webform`, add the Mollie payment handler to
  the individual webform whose submissions should take a payment.

## Save

Click **Save configuration**. Run a test payment end to end with your test key
before switching to the live key.
