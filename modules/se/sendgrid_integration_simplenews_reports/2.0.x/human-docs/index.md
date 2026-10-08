# SendGrid Integration Simplenews Reports — manual setup guide

**SendGrid Integration Simplenews Reports** (`sendgrid_integration_simplenews_reports`)
bridges two things you may already run: the **Simplenews** newsletter module and
**SendGrid Integration**. For each newsletter issue node, it adds a dedicated
**SendGrid Statistics** tab that pulls the real SendGrid delivery analytics for
*that specific issue* and shows them as charts, a summary/totals table, and a CSV
export.

The metrics cover the numbers you'd expect from an email service: sending volume
(requests, processed, delivered, deferred), opens and clicks (including unique
opens and clicks), bounces and bounce drops, spam reports, unsubscribes,
blocks and invalid emails. You can filter by a custom date range — it defaults to
the node's creation date through today — and download the figures as CSV for
offline analysis. The statistics are scoped per newsletter by tagging each issue
with a SendGrid category (`node_{nid}`).

Importantly, this module holds **no SendGrid API key and makes no direct HTTP
call of its own** — it delegates all SendGrid API access to the parent SendGrid
Integration Reports service, so credential storage and TLS are that module's
responsibility. Access to the report is doubly gated: a viewer needs the
`access sendgrid simplenews report` permission, *and* the report is only allowed
on nodes that are actual Simplenews issues (nodes with a `simplenews_issue`
field) — anything else is forbidden. The CSV export escapes each cell safely.

One caveat from the maintainers: this module targets the 2.x branch of SendGrid
Integration and is currently in an alpha state because full functionality depends
on a patch to a related ticket. It requires Drupal 10 or 11, and is not covered by
Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it and its required companions, and grant the report permission.

## How to use it

There is no settings form. Once the module and its dependencies are configured:

1. Make sure **SendGrid Integration** (and its **Reports** submodule) and
   **Simplenews** are installed and working — this module relies entirely on them
   for API access and newsletter content.
2. Grant the **`access sendgrid simplenews report`** permission at **People →
   Permissions** to the roles that should see newsletter analytics.
3. Open a Simplenews newsletter issue node and click the **SendGrid statistics**
   tab (`node/{node}/sendgrid-statistics`). Pick a date range if you want to
   narrow the window, review the charts and summary table, and use the CSV option
   to export.

Because the report is an admin route restricted to Simplenews issue nodes, the
tab only appears/works on genuine newsletter issues; on any other node it is
forbidden.
