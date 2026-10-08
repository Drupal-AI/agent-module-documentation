<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reports dashboard & permissions

Route `audit_chain.dashboard` at **`/admin/reports/audit-chain`**, controller
`Drupal\audit_chain\Controller\AuditChainDashboardController::dashboard()`, gated by the module's own
permission **`view audit chain reports`** (`audit_chain.permissions.yml`, `restrict access: true`).
The settings route is gated by core `administer site configuration`; this is the only permission the
module defines.

![Audit Chain reports dashboard](../../../../../../../screenshots/audit_chain/1.9.x/reports-dashboard.png)

## What it shows (and never shows)

Integrity and the keyed-vs-unkeyed split only — **not** a volume/channel dashboard. Metadata, IP
addresses, user agents and entity labels are never rendered, and the chain is **not** re-walked on
page load. Per `audit_chain_help()`, the integrity card reads the last scheduled verification.

- **Integrity card** (`buildChain()`) — from `AuditChainMetrics::integrity()`, which classifies the
  stored scheduled-verification run via `ScheduledVerificationIntegrity`. States: Verified / Failed /
  Foreign seal / Overdue / Not scheduled / Pending, plus the total row count.
- **Status tiles** (`buildTiles()`) — Entries, Keyed (share + count), Unkeyed for the selected window.
- **Keyed-vs-unkeyed chart** (`buildCharts()`) — a donut from `AuditChainChartRenderer`.
- **Window toggle** — `24h` / `7d` / `30d`, read from the validated `?window=` query arg
  (`AuditChainMetrics::normalizeWindow()`, allowlisted; unknown → `24h`).
- **Quick actions** — a link to Settings (skipped if the route is missing).
- **Recovery** — successor status when a recovery segment exists (`recoveryStatus()`).

Render cache: contexts `user.permissions` + `url.query_args:window`, `max-age` 60, no cache tag (the
logger does not invalidate one on append). Each widget is wrapped so a failure logs and degrades to a
default rather than breaking the page (`AuditChainDashboardController::widget()`).

## Metrics service (`AuditChainMetrics`, service `audit_chain.metrics`)

Window-bounded queries on the indexed `timestamp` / `key_id` columns; **never** reads metadata, IP,
UA or label. A row is *keyed* when `key_id` is a non-empty string (NULL/`''` are unkeyed, including
pre-column history). `keyedSplit()` / `windowCounts()` give the split; `integrity()` adds the row
count to the classified verdict without re-walking; `guard()` static-caches per request and degrades
failed metrics to zero (logged).

## Chart renderer (`AuditChainChartRenderer`, service `audit_chain.chart_renderer`)

`render('donut', $series, ['title' => …])` returns a `#type => 'chart'` element when `drupal/charts`
**and** a library plugin (charts_chartjs/google/highcharts) are present
(`chartsLibraryAvailable()`), otherwise a self-contained inline-SVG donut (no JS), or an empty-state
for no data. All dynamic values are passed through `htmlspecialchars()` before the SVG is marked safe.
