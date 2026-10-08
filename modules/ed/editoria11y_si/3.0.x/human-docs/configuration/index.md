# Configuration

Setup is a short sequence: store your SiteImprove credentials in a Key, configure
the settings form (Key, domain, and which checks to run), schedule the import, and
export config. The admin reports and in-page tips populate once data is imported.

## Step 1 — create the SiteImprove Key

1. Go to **Configuration → System → Keys** (`/admin/config/system/keys`).
2. Add a Key using the key type **Editoria11y SiteImprove**
   (`editoria11y_si_key`). It is a multivalue authentication key with these
   fields:
   - **username** *(required)* — your SiteImprove API user email.
   - **api_key** *(required)* — your SiteImprove API key.
   - **site** *(required)* — the SiteImprove site id.
   - **group** *(optional)* — a SiteImprove group id, to scope results.

   You can generate/manage these values in SiteImprove under
   *Integrations → API → Manage API keys*.

## Step 2 — the settings form

Go to **Configuration → Content authoring → Editoria11y → SI**
(`/admin/config/content/editoria11y/si`). You need the **Administer site
configuration** permission. The fields are:

- **SiteImprove API key** — select the Key you created in step 1 (the list is
  filtered to the `editoria11y_si_key` type). Required.
- **Domain** — your site's scheme + host (for example `https://example.com`). This
  is stripped from SiteImprove's URLs so they line up with your internal paths.
  It defaults to the current host.
- **Broken links import** — enable or disable importing pages with broken links.
- **Misspellings import** — enable or disable importing misspellings (disabled by
  default).
- **Reading score import** — enable or disable importing reading scores.
- **Reading score error grade level** — a number (default **8**). Pages whose
  reading level is below this grade get flagged on the page's `h1`.

Save the form. It also provides three **"Update … manually"** buttons — one per
data type — that run that single import synchronously right away and show the last
import time for each type, which is handy for a first run or for testing your
credentials.

## Step 3 — schedule the import

For ongoing updates, run the import periodically. It drains a queue, so both a
Drush command and normal Drupal cron will process items:

```bash
drush ev "editoria11y_si_queue_cronjob();"
```

This imports all enabled data types and processes the
`editoria11y_si_import_processor` queue. Stored issues that SiteImprove no longer
reports are pruned automatically, and imports are de-duplicated with a per-row
content hash.

> **If cron processing fails to start**, install the **Purge** module — the queue
> worker references Purge services that are not declared as a dependency (see
> Installation).

## Step 4 — export config

Installing the module increments Editoria11y's `custom_tests` counter by one (so
Editoria11y loads the three custom JS checks). After setup, **export your
configuration** (`drush cex`) so this is captured.

## Where the results appear

- **In-page tips:** content authors with the **View Editoria11y checker**
  permission see broken links, misspellings, and low reading-level warnings as
  Editoria11y tooltips, each linking back to its SiteImprove page report.
- **Admin reports:** three views under **Reports → Editoria11y**, each also gated
  by **View Editoria11y checker**:
  - `/admin/reports/editoria11y/si-broken-links`
  - `/admin/reports/editoria11y/si-misspellings`
  - `/admin/reports/editoria11y/si-reading-score`

## Clearing stored data

To remove all stored SiteImprove issue entities:

```bash
drush entity:delete editoria11y_si
```

## Permissions

- **Administer site configuration** (core) — required to reach the settings form.
- **View Editoria11y checker** (from the Editoria11y module) — required to see the
  in-page tips and all three report views.
- **Administer editoria11y_si** — governs create/edit/delete of the module's
  stored issue entities. Note the settings form is *not* gated by this permission;
  it uses Administer site configuration.
