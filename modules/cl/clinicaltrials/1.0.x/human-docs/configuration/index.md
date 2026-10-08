# Configuration

Clinical Trials is configured from a settings page in the admin interface, where you
control how the module talks to the ClinicalTrials.gov API and which trials it pulls
in. Access to this page is gated by the **`administer clinical trials config`**
permission.

## Open the settings form

1. Log in as a user with the **`administer clinical trials config`** permission.
2. Go to **`/admin/config/clinical-trials`** (it is also linked from the site's
   **Configuration** page as *Clinicaltrials*). Note: the *Configure* link on the
   Extend page does not work in this release — the module points it at a route name
   that does not exist — so use the URL above.

## What you configure

- **API settings and query parameters** — how the module queries the
  ClinicalTrials.gov API, including the query parameters that decide *which* trials
  are fetched. Set these to match the trials you want to appear on your site (for
  example by condition, sponsor, or other criteria the API supports).
- **Scheduled fetching / updates** — the module is designed to fetch and refresh
  data regularly so your listings stay current. Imports run via the
  `drush ct-import-studies` command, which you can run manually or schedule with
  cron.

## Running an import

After saving your query parameters, run:

```bash
drush ct-import-studies
```

This fetches the matching trials from ClinicalTrials.gov and creates or updates
**Clinical Trial** content-type nodes. The import provides logging and error
handling, so check the output (or the logs) to confirm the run succeeded and see how
many studies were imported.

## A note on the data source

The module makes outbound requests to the public ClinicalTrials.gov registry. The
data is public, so there are no API credentials to store — but be aware that
enabling scheduled imports means your site regularly contacts an external service.
