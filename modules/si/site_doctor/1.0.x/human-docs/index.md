# Site Doctor — manual setup guide

**Site Doctor** (`site_doctor`) answers a question that gets harder as a Drupal site
ages: *is my site healthy — and is it getting better or worse?* It runs **read-only
diagnostic checks** on a schedule and, unlike a one-time audit, **remembers what it
finds**. Every finding carries a stable fingerprint, so the built-in report can show you
what appeared this week, what stopped being found, what got worse, and what has been
quietly degrading for months.

The checks are deliberately read-only and cover the chronic problems that a normal
deploy does not surface: pending database/post-deployment updates and mismatched
entity/field definitions, the site being left in maintenance mode, risky permission
grants (for example "restrict access" permissions handed to anonymous or non-admin
roles), dormant privileged accounts that have not logged in for months, configuration
drift between your active config and your sync directory, and low-severity "entropy"
checks like unused image styles or roles with no users. Site Doctor never changes your
configuration or content — it writes only to its own reporting tables, with configurable
retention, and it never auto-fixes anything: it diagnoses and reports, and fixing stays a
deliberate human decision.

Crucially, the same structured results are available three ways: a **plain-language
report page** with history and trends at `/admin/reports/site-doctor`; **CLI commands**
on both Drupal core's new `dr` CLI and Drush, with CI-friendly output and exit codes for
your deployment pipeline; and **machine-readable output** that automation and AI agents
can consume. It is scoped to site-level diagnostics over time — it is not a
database/query monitor (see Site Health) and not a per-request developer profiler (see
Webprofiler). It depends only on core **User** and targets Drupal 11. Note this release
is an early alpha and the project is **not covered by Drupal's security advisory
policy**.

This guide is written for a **human** using the module through the admin UI and CLI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The report lives at **`/admin/reports/site-doctor`**. It shows current problems with an
age breakdown, a filterable "what changed" timeline (new / no longer found / got worse /
improved, each with fix guidance), severity trends charted over time, and an **Inventory**
of facts on file about the site — every permission grant, configuration overrides (the
key paths only, never the values, which is where secrets live), and the declared workflow.
Every filtered view is a bookmarkable URL.

## How to use it

Enable the module and let cron run the check-ups on a schedule (the frequency is
configurable, defaulting to daily); results from CLI runs are stored too, with a per-run
opt-out. Review the report page for trends, or wire the **`dr`/Drush** commands into CI —
their exit codes let a deployment pipeline fail on the classes of finding you choose to
gate on (advisory "entropy" and inventory checks never gate CI). Retention is
configurable, and the horizons are printed on the very views they bound.
