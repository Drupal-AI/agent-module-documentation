# Configuration

DrupalFit's core, on‑site audit needs **no configuration** — enable it, open the
report, and it works. The Settings tab exists only to connect the module to the
optional **DrupalFit platform** for enhanced reporting. If you do not need that,
you can skip this page entirely.

## Open the Settings tab

1. Log in as a user with the **Administer DrupalFit** permission.
2. Go to **Reports → DrupalFit Report** (`/admin/reports/drupalfit-report`) and
   open the **Settings** tab.

## Settings fields

- **API Key** — the key used to connect your site to the DrupalFit platform for
  enhanced reporting. Register at [DrupalFit.com](https://drupalfit.com) and
  generate the key from your account, then paste it here. This is a **credential**:
  keep it private, do not commit it to version control, and treat it like any
  other secret.
- **Domain** — your site's domain, used when connecting the site to the DrupalFit
  platform.

Leave both blank to run DrupalFit purely as an on‑site auditor with no external
connection.

## What connecting enables

Once the API key and domain are set, an additional **DrupalFit** tab provides
enhanced reporting drawn from the platform:

- **SEO insights** — advanced search‑optimisation reporting.
- **Accessibility insights** — enhanced accessibility analysis.

> **Before you connect:** enabling the platform connection means your site
> communicates with an external service (DrupalFit.com). Make sure that is
> acceptable for your privacy and data‑handling requirements, and remember that
> both the API key and any reports/exports are sensitive.

## Save

Save the Settings form. If the connection is valid, the enhanced DrupalFit tab
becomes available alongside the on‑site Analysis Report.
