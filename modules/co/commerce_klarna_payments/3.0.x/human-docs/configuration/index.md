# Configuration

Klarna Payments is set up as a Drupal Commerce **payment gateway** — there is no
separate global settings page. You add one gateway and configure it there.

## Before you start: store your Klarna credentials safely

Klarna issues **API credentials** (an API user/username and password/secret).
These are secrets — never paste them into committed code or a configuration export
that lands in version control.

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

## Add the Klarna Payments gateway

1. Log in as a user who can **administer commerce payment gateways** (an
   administrator by default).
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway** and give it a customer‑friendly **Name**.
4. Choose the **Klarna Payments** plugin.

## Fill in the gateway settings

- **API credentials** — enter (or reference, via the Key above) your Klarna API
  username and password. These authenticate the module's server‑side calls to
  Klarna, including the `getOrder` call the push endpoint relies on.
- **Region** — select the correct **Klarna region** for your account. Klarna uses
  regional API endpoints; the wrong region causes authentication and payment
  failures.
- **Mode (test vs live)** — start in **test** and switch to **live** only after a
  successful end‑to‑end payment. Using the wrong mode either fails against the
  live service or produces orders that were never really charged.

## Register the push endpoint with Klarna

Klarna notifies your store of order status by calling a **push endpoint** on your
site. In your **Klarna merchant portal**, configure the push/notification URL that
points back to this site's Klarna Payments endpoint (the gateway configuration and
Klarna's onboarding docs indicate the exact URL to use). This lets Klarna tell your
store when an order has been authorized or captured, even if the shopper's browser
closed after paying.

**You do not need to secure this endpoint with a shared secret of your own.** When
Klarna calls it, the module does not trust the request body — it **re‑fetches the
order from Klarna's authenticated API** and acts only on verified statuses
(`AUTHORIZED`, `PART_CAPTURED`, `CAPTURED`). A forged push therefore cannot mark an
order paid; the authenticity check is the authenticated call back to Klarna.

## Save and test end to end

Click **Save**, then place a test order. Choose Klarna Payments at checkout,
complete Klarna's off‑site flow, and confirm the order is authorized/captured and
marked paid in Commerce once the push is processed. Verify this against **test**
before switching to **live**.
