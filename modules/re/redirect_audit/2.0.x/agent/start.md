<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redirect Audit (redirect_audit) — agent index

Add-on to the Redirect module that finds and fixes **redirect chains** (A→B→C) and
**loops** (A→B→A and self-loops) among the site's `redirect` entities. Detection is a
pure database / entity-graph analysis: it follows each redirect's stored target through
path-alias and language resolution to see whether another redirect entity matches. It
makes **no HTTP requests** and does not check remote status codes, so it finds chains and
loops, not dead links. Findings are stored in two custom tables and shown on an admin
dashboard.

Depends on `redirect:redirect` (composer `drupal/redirect:^1.0`). Core `^11.3 || ^12`
(this 2.0.x major). Package `Redirect`.

- Dashboard route **`redirect_audit.dashboard`** — `/admin/config/search/redirect/audit`
  (form `RedirectAuditDashboardForm`; Audit/Fix/Clear buttons + paged results table).
- Settings route **`redirect_audit.settings`** — `/admin/config/search/redirect/audit/settings`
  (form `RedirectAuditSettingsForm`).
- Both routes and all bulk operations are gated by the single permission
  **`administer redirect audit`**.

Solution docs:
- **Config object, settings keys, schema, defaults** → [configure/settings.md](configure/settings.md)
- **The one permission and what it gates** → [permissions/permissions.md](permissions/permissions.md)
- **Scan / fix / inspect from the CLI** → [drush/commands.md](drush/commands.md)
- **Analyzer / fixer / storage / chain-resolver services, detection & fix logic, batch** → [api/services.md](api/services.md)
- **Entity hooks, scan-on-change, queue worker, cron, status-report requirements, theme** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Config object `redirect_audit.settings`: `autofix_enabled` (bool, default FALSE),
  `scan_on_change` (bool, default TRUE), `batch_size` (int, 50; UI 1–500),
  `max_chain_depth` (int, 10; UI 5–50), `items_per_page` (int, 20; UI 5–100).
- Services: `redirect_audit.analyzer` (`Service\RedirectAuditAnalyzer`),
  `redirect_audit.fixer` (`Service\RedirectAuditFixer`),
  `redirect_audit.storage` (`Service\RedirectAuditStorage`),
  `redirect_audit.chain_resolver` (`RedirectChainResolverInterface` →
  `RedirectChainResolver`). Shared path logic in `RedirectPathResolverTrait`.
- Drush (`Commands\RedirectAuditCommands`): `redirect-audit:scan` (`ras`),
  `redirect-audit:fix` (`raf`), `redirect-audit:info` (`rai`).
- Queue worker plugin `redirect_audit_queue` (`Plugin\QueueWorker\RedirectAuditQueueWorker`,
  cron time 60s). Batch driver `RedirectAuditBatch`.
- Hooks in `Hook\RedirectAuditHooks` (OOP `#[Hook]`): `theme`, `runtime_requirements`,
  `redirect_insert/update/delete`.
- Tables `redirect_audit_chains` (id, source_rid, target_rid, path; unique key
  `chain_signature` on the three) and `redirect_audit_processed` (rid, chain_processed).
  Install/update helpers in `redirect_audit.install`.
- Scan / fix / clear are mutually exclusive via the lock named `redirect_audit_scan`
  (TTL 1800s, refreshed per batch step); the queue worker throws `SuspendQueueException`
  while that lock is held.
- Chains are auto-fixable (source rewritten to the final destination); **loops are only
  flagged, never auto-fixed**. Last-scan / last-cleared timestamps live in State
  (`redirect_audit.last_scan`, `redirect_audit.last_cleared`).
- Results are a point-in-time snapshot — re-scan to refresh.
