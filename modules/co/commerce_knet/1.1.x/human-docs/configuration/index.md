# Configuration

KNET is set up as a Drupal Commerce **payment gateway** — there is no separate
global settings page. You add one gateway and configure it there.

## Before you start: store your KNET credentials safely

KNET issues a **terminal ID** and a **terminal resource key**. The resource key in
particular is a secret — it is what the module uses to decrypt the KNET response —
so keep it protected. Never paste these into committed code or a configuration
export that lands in version control.

On a DDEV site, keep the value in an environment variable and expose it to Drupal
through a **Key** entity:

1. Save the secret into DDEV's dotenv file:

   ```bash
   ddev dotenv set .ddev/.env --knet-resource-key=<your-key>
   ddev restart
   ```

   The flag `--knet-resource-key` becomes the environment variable
   `KNET_RESOURCE_KEY`. Keep `.ddev/.env` out of version control.

2. Install the **Key** module if you don't already use it:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ```

3. Create a Key that reads the environment variable and reference it from the
   gateway form rather than typing the raw secret.

## Add the KNET gateway

1. Log in as a user who can **administer commerce payment gateways** (an
   administrator by default).
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway** and give it a customer‑friendly **Name**.
4. Choose the **KNET** plugin.

## Fill in the gateway settings

- **Terminal ID** — the identifier KNET issued for your terminal.
- **Terminal resource key** — the AES key used to decrypt the `trandata` response
  from KNET. Enter this (or reference the Key you created above). Treat it as a
  secret and protect it accordingly.
- **Mode (test vs live)** — start in **test** while you set things up and switch to
  **live** only after confirming a real end‑to‑end payment. Using the wrong mode
  either fails against the live service or produces orders that were never really
  charged.

## Save and test end to end

Click **Save**, then place a test order. Choose KNET at checkout; you should be
redirected to KNET to pay, and on returning the module **decrypts the response and
checks it server‑side** — requiring a `CAPTURED` result, a matching order id, and a
returned amount equal to the order total — before marking the order paid. Confirm
the whole flow works in **test** before switching to **live**.

> Because of the PHP 8 compatibility caveat noted in the
> [overview](../index.md), verify that the redirect to KNET and the return both
> work on your Drupal 10/11 site (patching `src/Helper/SecureText.php` if needed)
> before going live.
