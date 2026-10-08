<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redirect Audit (redirect_audit) — agent index

Add-on to the Redirect module that finds and fixes **redirect chains** (A→B→C) and
**loops** (A→B→A and self-loops) among the site's `redirect` entities. Detection is a
pure database / entity-graph analysis — it follows each redirect's stored target through
path-alias and language resolution to see whether another redirect entity matches; it
makes **no HTTP requests** and does not check remote status codes. Results are stored in
two custom tables and shown on an admin dashboard.

Depends on `redirect:redirect` (composer `drupal/redirect:^1.0`). Core `^10 || ^11`.
Configure route: **`redirect_audit.settings`** (`/admin/config/search/redirect/audit/settings`).
Dashboard: **`redirect_audit.dashboard`** (`/admin/config/search/redirect/audit`).
Both routes and all bulk operations are gated by the single permission
**`administer redirect audit`**. Provides its own permission, 3 drush commands, config
schema, a queue worker, a cron-driven scan-on-change flow, and a batch scan/fix engine.

- **Change scan depth, batch size, autofix, scan-on-change** → [configure/settings.md](configure/settings.md)
- **Who can audit/fix redirects** → [permissions/permissions.md](permissions/permissions.md)
- **Scan / fix / inspect from the CLI** → [drush/commands.md](drush/commands.md)
- **Call the analyzer / fixer / storage services from code** → [api/services.md](api/services.md)
- **Cron, scan-on-change, requirements, entity hooks, batch** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Config object `redirect_audit.settings`: `autofix_enabled` (bool, default FALSE),
  `scan_on_change` (bool, default TRUE), `batch_size` (int, 50), `max_chain_depth`
  (int, 10; UI range 5–50), `items_per_page` (int, 20).
- Services: `redirect_audit.analyzer` (`RedirectAuditAnalyzer`), `redirect_audit.fixer`
  (`RedirectAuditFixer`), `redirect_audit.storage` (`RedirectAuditStorage`),
  `redirect_audit.chain_resolver` (`RedirectChainResolverInterface`).
- Drush: `redirect-audit:scan` (`ras`), `redirect-audit:fix` (`raf`), `redirect-audit:info` (`rai`).
- Queue worker plugin `redirect_audit_queue` (cron time 60s). Batch driver
  `Drupal\redirect_audit\RedirectAuditBatch`.
- Tables `redirect_audit_chains` (id, source_rid, target_rid, path; unique key
  `chain_signature`) and `redirect_audit_processed` (rid, chain_processed).
- Scan / fix / clear are mutually exclusive via the lock named `redirect_audit_scan`.
- Chains are auto-fixable (source rewritten to the final destination); **loops are only
  flagged, never auto-fixed**. Results are a point-in-time snapshot.
