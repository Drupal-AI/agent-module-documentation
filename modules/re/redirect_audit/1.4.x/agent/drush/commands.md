# Drush commands

Registered in `drush.services.yml` as service `redirect_audit.commands`
(`Drupal\redirect_audit\Commands\RedirectAuditCommands`, extends `DrushCommands`).

| Command | Aliases | Does |
|---------|---------|------|
| `redirect-audit:scan` | `ras` | Deletes any pending `redirect_audit_queue` items, then runs a full synchronous scan via `RedirectAuditAnalyzer::detectChains()`. Reports chains/loops found; suggests `raf`/`rai`. |
| `redirect-audit:fix` | `raf` | Runs `RedirectAuditFixer::fixAll()` over all stored chain records. Rewrites each chain's source redirect to its final destination; **loops are skipped** (require manual review). No-op with a warning if nothing was scanned. |
| `redirect-audit:info` | `rai` | Prints stats (total / chains / loops), current config (autofix, scan_on_change, max_chain_depth, batch_size), and a detailed table (first 100 records) of source → intermediate flow → target. |

All three return `DrushCommands::EXIT_SUCCESS` / `EXIT_FAILURE`.

## Typical flow

```bash
drush ras     # scan all redirects for chains and loops
drush rai     # review what was found (statistics + per-record flow)
drush raf     # auto-fix the chains (loops still need manual editing)
```

## Behavior notes

- `detectChains()` and `fixAll()` both acquire the shared lock `redirect_audit_scan`
  (TTL 1800s). If a dashboard batch scan/fix is already running, the operation reports a
  lock failure rather than corrupting the audit tables.
- `scan` truncates the `redirect_audit_chains` / `redirect_audit_processed` tables at the
  start of a run (via `detectChainsInit()`) and rebuilds them — it is a full re-scan, not
  incremental.
- Detection and fixing are entirely database/entity operations; no command issues an HTTP
  request to any redirect target.
