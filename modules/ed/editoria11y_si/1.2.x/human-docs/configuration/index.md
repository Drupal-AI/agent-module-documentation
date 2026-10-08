# Configuration

Setting up Editoria11y SI is a short sequence: store your Siteimprove credentials
in a Key, point the module at that Key, schedule the import, and export config.

## Step 1 — create the Siteimprove Key

1. Go to **Configuration → System → Keys** (`/admin/config/system/keys`).
2. Add a new Key for Editoria11y SI and enter the values Siteimprove gives you:
   - **username** — your Siteimprove API user.
   - **api_key** — your Siteimprove API key.
   - **site** — the Siteimprove site identifier.
   - **group** *(optional)* — a Siteimprove group id, if you want to scope results.

Storing the credentials as a Key rather than in plain configuration is the point
of the Key dependency — keep them there.

## Step 2 — select the Key on the settings form

1. Go to **Configuration → Content authoring → Editoria11y → SI**
   (`/admin/config/content/editoria11y/si`).
2. Select the Siteimprove Key you just created.
3. Save.

## Step 3 — schedule the import

The module pulls data from Siteimprove through a queued cron job. Run it
periodically — for example from your system cron or with Drush:

```bash
drush ev "editoria11y_si_queue_cronjob();"
```

This fetches the Siteimprove data and queues it for processing so the issues
appear in the Editoria11y interface.

## Step 4 — export config

Installing the module bumps Editoria11y's own `custom_tests` counter by one (so
Editoria11y loads the extra check). After completing setup, **export your
configuration** (`drush cex`) so this change is captured.

## What authors and admins see

Once data has been imported, content authors with access to the Editoria11y
checker see Siteimprove's **broken links** flagged in the in-page Editoria11y
tooltips, and administrators get a **broken-links report view** listing them
across the site.
