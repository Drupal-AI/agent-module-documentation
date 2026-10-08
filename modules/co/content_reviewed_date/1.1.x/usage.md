Content Reviewed Date records when each node was last reviewed by an editor and reports which content is overdue for review.

---

Content Reviewed Date adds two revisionable base fields to every node type — `content_reviewed_date` (a "Last Reviewed" date) and `content_reviewed_uid` (a "Reviewed By" user reference). An administrator picks which content types actually participate on a settings form, sets a global staleness threshold in days, and can override that threshold per content type. Once a bundle is tracked, saving a node as an authenticated editor auto-stamps today's date (via `hook_node_presave`), and a "Mark as Reviewed" local task tab lets editors record a specific review date without otherwise editing the content. A "Stale Content" admin report at `/admin/content/stale-review` lists all published tracked nodes that are past their threshold or have never been reviewed. All review logic lives in the unit-testable `ReviewedDateManager` service; two permissions gate the editor action and the admin settings.

---

- Track when each page, article, or other node was last reviewed by an editor.
- Add a "Last Reviewed" date and "Reviewed By" user field to node types without writing custom fields.
- Choose exactly which content types participate in review tracking on a settings form.
- Define a site-wide staleness threshold (e.g. content older than 365 days is overdue).
- Give high-churn content types a shorter review interval via per-content-type threshold overrides.
- Auto-record a review date whenever an editor saves a tracked node — no separate step.
- Let editors record a review without changing the content, using the "Mark as Reviewed" tab.
- Record a past review date (e.g. a review done last week) through the mark-as-reviewed form.
- Surface every overdue node in one admin report for editorial triage.
- Treat never-reviewed published content as stale so nothing slips through unreviewed.
- Show who last reviewed each node and when, on the node display.
- Build an editorial content-governance / freshness workflow on top of core nodes.
- Restrict the "mark reviewed" action to trusted editor roles via a dedicated permission.
- Restrict configuration and the stale report to administrators via a separate permission.
- Query staleness programmatically through `ReviewedDateManager::isStale()`.
- Read the effective per-bundle threshold in code via `getThresholdDaysForBundle()`.
- Populate review fields on a node from custom code with `markAsReviewed()`.
- Page through large stale-content lists (50 rows per page) in the report.
- Keep review data out of anonymous/CLI saves (cron, migrations skip auto-stamping).
- Cleanly drop the review columns on uninstall, leaving the entity schema consistent.
- Audit content freshness across a multi-editor site from a single dashboard.
- Prioritise which aging pages need attention before content becomes inaccurate.
