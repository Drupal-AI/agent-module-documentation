# Configuration

Setting up Khalti is a four‑step job: make your store use NPR, add the Khalti
payment gateway, give it your secret keys (stored securely), and test in the
sandbox before going live. You need the relevant Commerce administration
permissions (an administrator has them by default).

## Step 1 — Enable NPR currency

1. Go to **Commerce → Configuration → Currencies**
   (`/admin/commerce/config/currencies`).
2. If **Nepalese Rupee (NPR)** is not listed, click **Add currency**, search for
   it, and save.

## Step 2 — Set the store currency to NPR

1. Go to **Commerce → Configuration → Stores**
   (`/admin/commerce/config/stores`).
2. Edit your store and set the **Default currency** to **NPR**.
3. Save. (Khalti requires amounts in paisa; the module converts for you as long
   as the store is in NPR.)

## Step 3 — Add the Khalti payment gateway

1. Go to **Commerce → Configuration → Payment Gateways**
   (`/admin/commerce/config/payment-gateways`).
2. Click **Add payment gateway** and fill in the form:

   | Field | Value |
   |-------|-------|
   | **Name** | Khalti (or any label your customers will see) |
   | **Plugin** | **Khalti Payment** |
   | **Mode** | **Test** for sandbox · **Live** for production |
   | **Test Secret Key** | Your sandbox `live_secret_key` from `test-admin.khalti.com` |
   | **Live Secret Key** | Your production `live_secret_key` from `admin.khalti.com` |

3. Save.

> **Note:** Khalti's Authorization header uses the format `Key <secret_key>` —
> not `Bearer`. The module handles this for you.

### Store the secret keys securely

The secret keys authenticate your store to Khalti and must be treated as
secrets. Rather than committing them to configuration, keep them in environment
variables. With DDEV:

```bash
ddev dotenv set .ddev/.env --khalti-live-secret-key=<your-live-secret-key>
ddev restart
```

Never commit `.ddev/.env`. Where the field accepts a
[Key](https://www.drupal.org/project/key) entity, create one backed by that
environment variable and select it on the gateway; otherwise reference the
variable from `settings.php` via `getenv()` and a configuration override. The aim
is the same everywhere: the live secret key should not live in your git history.

## Step 4 — Confirm the checkout flow

1. Go to **Commerce → Configuration → Checkout Flows**
   (`/admin/commerce/config/checkout-flows`).
2. Edit the flow your store uses and confirm the **Payment** and **Payment
   process** panes are present and in the correct order. These panes drive the
   redirect to Khalti and the server‑side verification on return — the security
   behaviour described in the [overview](../index.md#a-note-on-the-returncallback-please-read).

## Sandbox testing

The Khalti sandbox is completely isolated from production — no real money moves.
Get sandbox credentials at `test-admin.khalti.com`, set the gateway **Mode** to
**Test**, and place a test order end to end. Only switch **Mode** to **Live** and
plug in the live secret key once the sandbox flow works.
