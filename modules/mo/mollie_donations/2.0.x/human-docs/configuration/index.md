# Configuration

The donation form needs your Mollie **API key** and at least one donation amount
before it will work.

## Open the settings form

1. Log in as a user with the **`access mollie_donations admin`** permission (an
   administrator by default).
2. Go to **`/admin/config/services/mollie_donations`** (config route
   `mollie_donations.settings_form`).

## The Mollie API key

Mollie provides a **test** key (starts with `test_`) and a **live** key (starts
with `live_`) in its dashboard. Always run test donations with the test key
first, then switch to the live key for real money.

**Treat the API key as a secret** — it authorises charges against your Mollie
account and must not be committed to your repository or exported into
configuration. The safe pattern on this project:

1. Store the value in an environment variable with DDEV's dotenv helper (never
   committed):

   ```bash
   ddev dotenv set .ddev/.env --mollie-api-key=live_xxxxxxxxxxxxxxxxxxxx
   ddev restart
   ```

   The flag becomes the environment variable `MOLLIE_API_KEY` in the container.

2. Prefer surfacing the value through a **Key** entity (install the Key module if
   needed) with the built-in environment provider, or read it directly with
   `getenv('MOLLIE_API_KEY')` where a Key entity does not fit.

Because the module calls Mollie's servers, make sure your site's outbound network
allows HTTPS requests to Mollie's API.

## Donation options

On the same form you configure how the donation form behaves:

- **Donation amounts** — offer fixed amounts, an open "enter your own amount"
  field, or a mix, depending on what your campaign needs.
- **Form title and description** — the text donors see on `/mollie_donations`.
- **Redirect / thank-you** — where donors land after a completed payment.

## Publish the form

The donation form is served at **`/mollie_donations`**. Add a **menu link** or a
**block** pointing there so donors can find it. You can localise the form's
labels through Drupal's usual translation tools.

## The callback is safe by design

When a donor returns, the module re-fetches the real payment status from Mollie
to decide success — it does not trust the returning request. You do not need to
configure anything for this; just keep the site on **HTTPS**.

## Save

Click **Save configuration**, then run a full test donation with your test key
before switching to the live key.
