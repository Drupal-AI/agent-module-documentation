# Configuration

The module's own configure link opens the API submodule's settings form, which
this module extends with a field‑import button. This page covers that form, then
the report pages, blocks, cache, and permissions.

## Before you start: get Google credentials

The report data comes from Google, so you need credentials first:

1. In the Google Cloud console, create (or reuse) a project and enable the
   **Google Analytics Data API**.
2. Create a **service account** and download its **JSON key**.
3. In Google Analytics, add that service account's email address as a **Viewer**
   on the GA4 property you want to report on.
4. Note your GA4 **Property ID**.

## Open the settings form

Go to **Configuration → Web services → Google Analytics Reports API**
(`/admin/config/services/google-analytics-reports-api`). You need the
**Administer Google Analytics Reports API** permission. The form has these fields:

- **Property ID** — your GA4 property ID.
- **Credential JSON** — upload the service‑account JSON key here. It is stored as
  a managed file (use private file storage for this).
- **Query cache** — how long GA query results are cached before the module calls
  Google again. The default is **3 days** (259,200 seconds). Because Google
  enforces API quotas, a longer cache means fewer API calls; a shorter one means
  fresher numbers.
- **Import fields** — this button (added by this module, and shown once the
  account authenticates) runs a batch that loads the catalogue of available GA
  dimensions and metrics into Drupal so they can be used as Views fields, filters,
  and arguments. Click it after entering valid credentials, and re‑run it later if
  Google adds new dimensions or metrics.

Save the form, then click **Import fields**.

## Report pages and blocks

- **Summary report** — a ready‑made GA summary at
  `/admin/reports/google-analytics-reports/summary`.
- **Blocks** — place these from **Structure → Block layout**
  (`/admin/structure/block`):
  - **Google Analytics Reports Summary Block** — a summary of key metrics.
  - **Google Analytics Reports Page Block** — statistics for the current page
    (path‑based).
- **Charts** — to render any of this as graphs, enable the contrib **Charts**
  module (with its Google Charts or Highcharts sub‑module).

## Building your own reports

Once fields are imported, create a new View and choose the Google Analytics query
backend. You can then add GA metrics as fields, GA dimensions as fields, filters,
or contextual arguments, and filter by a date range (start date / end date). This
is how you build reports like "top pages this week" or per‑country traffic
breakdowns.

## Permissions

- **Access Google Analytics reports** (`access google analytics reports`) — lets a
  role view the GA report pages. Grant it to trusted roles only.
- **Administer Google Analytics Reports API** — lets a role open the settings form
  and manage credentials.

## A note on Drush

The module ships a legacy `google_analytics_reports.drush.inc` field‑import
command, but it is a **non‑functional Drush 8 stub** that modern Drush does not
load — it only logs that Drush support is unavailable. Import fields from the
settings form, not from Drush.
