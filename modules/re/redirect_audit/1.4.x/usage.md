<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Redirect Audit inspects a site's `redirect` entities for structural problems — multi-hop chains (A→B→C) and loops (A→B→A, or a redirect that resolves back to its own source) — reports them on an admin dashboard, and can rewrite chains to point straight at their final destination with one click.

---

Redirects are written once and rarely revisited, so a site built over years accumulates chains three hops long that cost every visitor extra round trips and loops that break navigation outright — problems invisible from Redirect's own list, which shows each source and destination in isolation without seeing how they connect. This module adds that connection analysis. It walks the redirect graph entirely in the database: for each redirect it resolves the stored target through path aliases and language prefixes and checks whether another redirect entity matches, following up to `max_chain_depth` hops. Detection is pure entity/DB work — it makes no HTTP requests and does not test whether a target returns 200, so it finds chains and loops, not dead links. Findings land in two custom tables and on a dashboard at `/admin/config/search/redirect/audit`; a `Fix` action rewrites each chain's source to the final destination (loops are flagged for manual review, never auto-fixed) and a `Clear` action empties the records. It runs three ways: an on-demand batch from the dashboard, three drush commands (`ras`/`raf`/`rai`), and a cron queue that re-checks each redirect as it is created or edited when `scan_on_change` is on. Both routes and all operations sit behind the module's own `administer redirect audit` permission. Depends on `redirect ^1.0`; core `^10 || ^11`. Results are a point-in-time snapshot, so scheduling re-scans matters more than trusting one clean run.

---

- Detect redirect chains costing visitors extra round trips.
- Identify redirect loops that break navigation.
- Find self-loops where a redirect resolves back to its own source.
- One-click fix chains to point at their final destination.
- Audit a redirect table accumulated over years.
- Clean up redirect structure before a site migration.
- Verify redirects created by a migration for hidden chains.
- Flatten chains after a bulk redirect import.
- Auto-fix chains as redirects are created (autofix + scan-on-change).
- Batch-scan a very large redirect table without timeouts.
- Run a redirect health check from the CLI (`drush ras`).
- Review findings and stats from the CLI (`drush rai`).
- Fix all detected chains from the CLI (`drush raf`).
- Surface unresolved chains/loops on the Status Report page.
- Prioritise which redirects to untangle first.
- Delegate redirect auditing to an SEO role without granting redirect editing.
- Reduce unnecessary redirect hops to improve crawl efficiency.
- Re-check redirects automatically after each edit via cron.
- Tune scan depth and results paging to fit the site.
- Schedule periodic re-audits to catch newly introduced chains.
- Support an SEO audit of redirect structure.
- Evidence redirect-chain cleanup for a stakeholder.
