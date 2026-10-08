# Configuration

All configuration happens at **Commerce → Clover Sync**
(`/admin/config/commerce/clover-sync`), which requires the **Administer clover
commerce sync** permission.

## 1. Get your Clover credentials

**Merchant ID** — log in to your Clover dashboard, go to **Settings → Business
Information**, and copy your **alphanumeric** Merchant ID (for example
`FB923TN9SW3X1`). Do not use the shorter numeric MID shown in some places — the
REST API requires the alphanumeric form.

**API Token** — in the Clover dashboard, open **Settings**, search for **API**, and
choose **API Tokens**. Click **Create new token**, name it (for example "Drupal
Sync"), and enable the **Inventory → Read** permission. Copy the token immediately —
Clover shows it only once.

## 2. Fill in the settings form

| Field | What to enter |
|-------|---------------|
| **Merchant ID** | Your alphanumeric Clover Merchant ID. |
| **API Access Token** | The token you just created. |
| **Environment** | **Production** for a live store, or **Sandbox** for testing. |
| **Currency Code** | Your store currency, e.g. `USD`. |
| **Cron Sync Interval** | How often cron runs a sync (every 15 minutes up to once a day). |
| **Sync prices** | Check to update variation prices from Clover. |
| **Sync stock levels** | Check to update stock from Clover. |
| **Stock Field (fallback)** | Machine name of the integer stock field on your product variation — used **only** when the Commerce Stock module is not installed. |
| **Webhook secret** | The shared secret used to verify incoming Clover webhooks. See the webhook section below. |

### Keep the API token and webhook secret safe

The Clover API token grants access to your merchant inventory, so treat it as a
secret. If you prefer to keep it out of the database and configuration exports, you
can supply it from an environment variable.

> **Using DDEV?** Store a secret without committing it:
> `ddev dotenv set .ddev/.env --clover-api-token=<value>`, then `ddev restart`.
> Keep `.ddev/.env` out of version control.

## 3. Match SKUs

Every Clover item you want to sync **must have a SKU set in Clover that exactly
matches the SKU on the corresponding Drupal Commerce product variation**. Items
without a matching SKU are skipped silently — this is the most common reason a sync
appears to "do nothing".

## 4. Test the sync

Click **Run sync now** on the settings page. Then check **Reports → Recent log
messages** for the run's results — the module reports counts of updated, skipped and
errored items, and logs errors to the dblog.

## 5. Set up the webhook safely (optional)

For near‑real‑time updates, register this URL in your Clover developer app's webhook
settings:

```
https://yoursite.com/clover-sync/webhook
```

**Set the webhook secret first.** The endpoint verifies Clover's
`X-Clover-Signature` (HMAC‑SHA256) with the configured webhook secret. Always
configure the secret before you rely on the webhook. When Clover sends a change event it includes only the changed item's
id, so the module re‑fetches the current price/stock from the Clover API before
applying it.

## Save

Save the form, run a manual sync to confirm, and check the log. Once cron is running
on your site, scheduled syncs will keep prices and stock aligned automatically.
