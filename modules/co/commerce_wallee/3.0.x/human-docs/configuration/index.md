# Configuration

Commerce Wallee is configured as a Drupal Commerce payment gateway. You enter
your Wallee credentials, then register the webhook URL in the Wallee backend.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**, name it (for example "Wallee"), and choose
   **Wallee** as the plugin.

## Gateway settings

Enter the credentials from your Wallee account:

- **Space ID** — the id of the Wallee space this store transacts in. The webhook
  handler uses the space id to match an incoming callback to the right gateway.
- **User ID** — the application user id used to authenticate SDK calls.
- **Secret** — the API secret paired with the user id. This is a secret value.
- Standard Commerce options let you mark the gateway test/production and enable or
  disable it.

If you are migrating from a Commerce 2 install, this is where you re‑enter the
credentials you backed up, and where you **manually migrate payment methods**
(tokens are not carried over automatically).

## Set up the webhook

In the **Wallee backend**, configure a webhook that points at your site's
Commerce Wallee webhook URL (and update it after any reinstall/upgrade). Wallee
calls this URL when a transaction or token version changes. The handler reads
only the entity/space id from the payload and re‑fetches the authoritative state
from Wallee via the SDK, so it stays correct even though the route is public and
unsigned.

> **Operational hardening.** Because the webhook route is public and its
> Transaction branch performs a `sleep(20)`, put **rate‑limiting** or worker
> limits in front of it (for example at your web server / reverse proxy) so that
> repeated public requests cannot tie up PHP workers.

## Handle the credentials safely

The Wallee **Secret** is sensitive. Never commit it to code. On DDEV, store it in
an environment variable and reference it through a **Key** entity where the field
allows, rather than pasting it into exported configuration:

```bash
ddev dotenv set .ddev/.env --wallee-secret=<value>
ddev restart
```

Always serve the site over **HTTPS**.

## Save and test

Click **Save**. Because 3.0.x is an early, minimally tested Commerce 3 release,
run a full test transaction — checkout redirect, return, and a webhook‑driven
status update — and confirm the payment records correctly before going live.
