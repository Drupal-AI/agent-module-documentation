# Configuration

GoCardless is set up in two places: the payment gateway (credentials and webhook)
and the individual product variations (which payment type each one uses).

## Add the gateway

1. Log in as a user who can **administer commerce payment gateways**.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a **Name** and select the **GoCardless** plugin.
4. Enter your **GoCardless credentials** — the API access token and the webhook
   secret from your GoCardless dashboard.

## Test vs live mode

Set the gateway **Mode** to **Test** (sandbox) first and complete a full order
before switching to **Live**. Because bank debits take time to settle, testing the
whole confirm-via-webhook cycle matters more here than with a card gateway.

## Register the webhook

GoCardless confirms the real state of a payment or mandate by calling your site's
**webhook** — this is essential, not optional, because a Direct Debit is not
settled at checkout. In your GoCardless dashboard, register the webhook endpoint
the module exposes and set the **webhook secret** to the same value you entered on
the gateway. The module **verifies the webhook signature** before acting on an
event, so the secret must match exactly.

## Per-variation payment types

Each product variation is configured to use one of the three payment styles:

- **Instant payment** — a single open-banking payment at checkout (British/German
  bank accounts).
- **Subscription** — automatic recurring payments; define the recurrence rules
  (amount and interval) on the variation.
- **One-off** — a mandate-backed payment your site triggers on demand or on a
  client-side schedule.

You can also expose a **recurrence field** so customers choose their own
preference, and enable **recurring orders** when each recurring payment needs its
own order number and confirmation/invoice.

## Store credentials securely

The GoCardless **API access token** and **webhook secret** are credentials — treat
them like passwords and keep them out of version control. The recommended pattern
on this project is to store each value in an environment variable and reference it
through a **Key** entity:

1. Save the value into DDEV's env file (not committed):

   ```bash
   ddev dotenv set .ddev/.env --gocardless-access-token=<your-token>
   ddev restart
   ```

2. If the [Key module](https://www.drupal.org/project/key) is not already
   enabled, add it:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ```

3. Create a Key that reads the environment variable and reference it from the
   gateway where the module supports it.

## Remember: payment is asynchronous

Do not treat a completed checkout as a settled payment. The order is confirmed
paid only when GoCardless's **signed webhook** reports success, which may be
several days later, and a debit can still fail or be returned. Build your
fulfilment around the webhook-driven payment state, and reconcile against your
GoCardless dashboard.
