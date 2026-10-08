# Configuration

Each Iranian bank is a standard Drupal Commerce **payment gateway**, so you
configure it the same way you would any gateway — there is no separate global
settings page for the pack. You add one gateway per bank you want to accept.

## Before you start: store your merchant credentials safely

Every bank issues **merchant credentials** — terminal IDs, merchant numbers,
merchant keys, and so on. These are secrets. Never paste them into code you
commit or into a configuration export that lands in version control.

On a DDEV site, keep each value in an environment variable and expose it to
Drupal through a **Key** entity:

1. Save the secret into DDEV's dotenv file (use a variable name that fits the
   bank and credential):

   ```bash
   ddev dotenv set .ddev/.env --saman-terminal-key=<your-key>
   ddev restart
   ```

   The flag `--saman-terminal-key` becomes the environment variable
   `SAMAN_TERMINAL_KEY`. Keep `.ddev/.env` out of version control.

2. Install the **Key** module if you don't already use it:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ```

3. Create a Key that reads the environment variable and reference it from the
   gateway form instead of typing the raw secret.

## Add a bank gateway

1. Log in as a user who can **administer commerce payment gateways** (an
   administrator by default).
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a customer‑friendly **Name** (for example "Pay with Saman").
5. Choose the **plugin** for the bank you want — for example **Saman**, **Mellat**,
   **Melli**, **ZarinPal**, **Zibal**, **Pasargad**, or **Saderat**.

## Fill in the gateway settings

The exact fields depend on the bank you selected, but every gateway asks for the
same categories of information:

- **Merchant credentials** — the terminal ID / merchant number / key that the
  bank issued you. Enter these (or reference the Key you created above). This is
  what authenticates your store to the bank and lets the module verify
  transactions on your behalf.
- **Mode / environment** — where the gateway offers **test** and **live**
  (production) modes, start in **test** while you set things up and switch to
  **live** only after you have confirmed a real end‑to‑end payment. Sending live
  traffic to a test terminal (or vice versa) is a common and confusing failure.
- **Display name and conditions** — standard Commerce options for what the gateway
  is called at checkout and the stores/order conditions under which it is offered.

## Save and test end to end

Click **Save**, then place a test order. At checkout, choose the bank gateway; you
should be redirected to the bank's hosted payment page, and on returning the
module should **verify the transaction server‑side with the bank** before marking
the order paid. This server‑side verification is the safeguard that stops a forged
or tampered browser return from completing an unpaid order — confirm it works in
**test** before going live. If you enable more than one bank, repeat the whole
flow for each gateway.
