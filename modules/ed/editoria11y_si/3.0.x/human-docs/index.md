# Editoria11y SI (SiteImprove) — manual setup guide

**Editoria11y SI (SiteImprove)** (`editoria11y_si`) imports quality-assurance data
from [SiteImprove](https://www.siteimprove.com/) (a subscription service) and
surfaces it to content authors inside the
[Editoria11y](https://www.drupal.org/project/editoria11y) accessibility checker's
in-page interface, backed by admin report views. Rather than asking editors to log
in to a separate SiteImprove dashboard, the module brings the findings to them, in
the same tooltips they already use for accessibility checks.

This is the **3.0.x** release, and it imports three kinds of SiteImprove QA data:

- **Pages with broken links**,
- **Misspellings** (with the suggested correction shown inline), and
- **Reading scores** (Flesch–Kincaid grade level) — pages below a grade level you
  choose get flagged.

Each issue links back to its SiteImprove page report, and each of the three data
types also has its own admin report view. This is a departure from the earlier
1.2.x line, which focused on broken links alone — 3.0.x adds misspellings and
reading scores, per-check on/off toggles, and three report views, and it requires
**Editoria11y 3.x**.

The module authenticates to SiteImprove's REST API using credentials held in a
**Key** entity (username, api key, site, optional group) — a real security plus —
and it makes outbound calls to SiteImprove to fetch data. It needs the
**Editoria11y** module, the **Key** module, and an active **SiteImprove
subscription with an API key**. One gotcha to know before you start: the import
queue worker references the **Purge** module's services even though Purge is not
declared as a dependency, so install `drupal/purge` if cron processing fails to
start.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside its Editoria11y and Key dependencies (and Purge if needed).
2. [Configuration](configuration/index.md) — create the SiteImprove Key, choose
   the domain and which checks to run, schedule the import, and find the reports.

## Where it lives in the admin menu

The settings form sits under Editoria11y at **Configuration → Content authoring →
Editoria11y → SI** (`/admin/config/content/editoria11y/si`). Credentials are
created as a Key at **Configuration → System → Keys**
(`/admin/config/system/keys`). The three admin reports live under
**Reports → Editoria11y** at `/admin/reports/editoria11y/si-broken-links`,
`/si-misspellings`, and `/si-reading-score`.
