# Configuration

Klarna Checkout is set up as a Drupal Commerce **payment gateway**, and because it
provides a *hosted checkout* you also connect it to your checkout flow. There is
no separate global settings page.

## Before you start: store your credentials safely

Klarna/Kustom issues **API credentials** (a merchant ID and a shared secret).
These are secrets — never paste them into committed code or a configuration export
that lands in version control.

On a DDEV site, keep the value in an environment variable and expose it to Drupal
through a **Key** entity:

1. Save the secret into DDEV's dotenv file:

   ```bash
   ddev dotenv set .ddev/.env --klarna-shared-secret=<your-secret>
   ddev restart
   ```

   The flag `--klarna-shared-secret` becomes the environment variable
   `KLARNA_SHARED_SECRET`. Keep `.ddev/.env` out of version control.

2. Install the **Key** module if you don't already use it:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ```

3. Create a Key that reads the environment variable and reference it from the
   gateway form rather than typing the raw secret.

## Add the Klarna Checkout gateway

1. Log in as a user who can **administer commerce payment gateways** (an
   administrator by default).
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway** and give it a **Name**.
4. Choose the **Klarna Checkout** plugin.

## Fill in the gateway settings

- **Merchant ID / API credentials** — enter (or reference, via the Key above) the
  merchant ID and shared secret from your Klarna/Kustom account. These authenticate
  the server‑side `getOrder` calls the module uses to confirm order status.
- **Environment (test vs live)** — start in the **test/playground** environment and
  switch to **live** only after confirming a real end‑to‑end checkout. Also confirm
  the correct **region** for your account.
- **Terms / merchant URLs and display options** — standard hosted‑checkout options
  such as the terms page and how the gateway presents itself.

## Wire it into the checkout flow

Because Klarna Checkout is a hosted checkout, connect it to your Commerce
**checkout flow** so the Klarna Checkout pane appears at the payment step. Review
your checkout flow under **Commerce → Configuration → Checkout flows** and confirm
the Klarna Checkout pane is placed where you expect.

## A note on order completion (why forged callbacks don't matter)

Order status is **confirmed by querying Klarna's authenticated API** (`getOrder`),
and the module's notification handler acts on that authoritative state — not on
whatever a callback request body claims. This means a forged or replayed
notification **cannot** mark an order paid. You still store your credentials
securely and pick the right environment, but you do not need to build extra
callback‑verification logic yourself.

## Save and test end to end

Click **Save**, then place a test order and complete the Klarna Checkout flow.
Confirm the order is created and marked paid in Commerce, reconciled against the
order fetched from Klarna. Verify against the **test** environment before switching
to **live**.
