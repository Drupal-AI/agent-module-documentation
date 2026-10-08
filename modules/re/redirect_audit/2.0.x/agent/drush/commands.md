<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Registered in `drush.services.yml` as `redirect_audit.commands` →
`Commands\RedirectAuditCommands` (tagged `drush.command`).

| Command | Alias | Method | What it does |
|---|---|---|---|
| `redirect-audit:scan` | `ras` | `scan()` | Drains the `redirect_audit_queue`, then runs `RedirectAuditAnalyzer::detectChains()` (full synchronous scan). Reports chains/loops found. |
| `redirect-audit:fix` | `raf` | `fix()` | Runs `RedirectAuditFixer::fixAll()` — rewrites every chain's source to its final destination; loops are skipped. No-op with a warning if no records exist. |
| `redirect-audit:info` | `rai` | `info()` | Prints statistics (`RedirectAuditStorage::getStats()`), current config, and a table of up to 100 detected records with the full resolved redirect flow. |

Details:
- `scan()` first calls `queueFactory->get('redirect_audit_queue')->deleteQueue()` so
  pending scan-on-change items do not double-process, then `detectChains()`. On success it
  suggests `drush raf` (if chains) and `drush rai` (if any issue). Exit codes:
  `DrushCommands::EXIT_SUCCESS` / `EXIT_FAILURE`.
- Both `detectChains()` and `fixAll()` acquire the shared lock `redirect_audit_scan`; if
  another scan/fix/clear is running they return early with `lock_failed` and do nothing.
- `info()` reconstructs each record's readable flow (`source -> intermediate(s) -> target`)
  with language-aware alias resolution via `resolveRedirectTarget()`,
  `getRawTargetPath()`, `getEffectiveLanguage()`, `prefixWithLanguage()` and validates
  step connectivity (`normalizePath()`), showing `rid:N (deleted)` for missing hops. Type
  is `Chain` when `source_rid != target_rid`, else `Loop`.
- These commands share the analyzer/fixer/storage services with the dashboard, so results
  are identical whichever entry point is used.
