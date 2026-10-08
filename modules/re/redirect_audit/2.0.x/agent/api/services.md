<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, detection & fix logic

All services are defined in `redirect_audit.services.yml`. Detection is entirely
entity/DB-based (path-alias + language resolution); **no HTTP client is used** and no
remote status is checked.

## `redirect_audit.analyzer` — `Service\RedirectAuditAnalyzer`

Args: chain_resolver, entity_type.manager, storage, logger.factory, config.factory,
path_alias.manager, language_manager, `@lock`, `@queue`, `@state`, `@datetime.time`.
Uses `RedirectPathResolverTrait`.

- `analyzeRedirect(Redirect $r): ?array` — the core detector. Returns NULL for a
  standalone redirect, else `['source_rid','target_rid','path','is_loop','chain']`.
  `path` is a dot-joined list of intermediate redirect IDs (empty for self-loops);
  `is_loop` is TRUE when the walk returns to the start redirect. It first checks
  `detectSelfLoop()` (source path == canonical alias of target, or an external URL whose
  path equals the source), then follows the chain up to `max_chain_depth` hops via
  `extractTargetInfo()` + `findRedirectByPath()` (trait), skipping parallel-language and
  same-target false positives.
- `detectChains(): array` — convenience full-run wrapper (used by drush): acquires the
  scan lock (`SCAN_LOCK_NAME = 'redirect_audit_scan'`, TTL 1800s), `detectChainsInit()`
  (truncates audit tables + deletes the queue), iterates in chunks of
  `DETECT_CHAINS_BATCH_SIZE (100)` via `detectChainsChunk()`, then `detectChainsFinish()`
  (records `LAST_SCAN_STATE_KEY`). Returns `redirects_analyzed / chains_found / loops_found`
  (or `lock_failed`).
- Chunked API for the batch driver: `acquireScanLock()`, `detectChainsInit()`,
  `countTotalRedirects()`, `createDetectionState()`, `detectChainsChunk($offset,$size,&$state)`,
  `detectChainsFinish()`, `releaseScanLock()`. `persistChain()` collapses sub-chains
  (only the longest variant of a→b→c→d is stored, evicting shorter ones);
  `persistLoop()` dedupes by a normalized loop signature.
- State helpers: `getLastScanTime()`, `getLastClearedTime()`, `recordCleared()` (the two
  timestamps are mutually exclusive — a clear drops the last-scan time).
- Dedup helpers: `loopAlreadyExists()`, `isIntermediateRedirect()`,
  `findAndAnalyzeRedirectsToSource()`, `calculatePath()`.

## `redirect_audit.fixer` — `Service\RedirectAuditFixer`

Args: chain_resolver, storage, entity_type.manager, logger.factory, `@lock`, config.factory.
Shares the same lock name (`FIX_LOCK_NAME = 'redirect_audit_scan'`) so scans and fixes are
mutually exclusive.

- `fixChain(int $audit_id): bool` — loads the source redirect + intermediates and calls
  `RedirectChainResolver::checkAndResolveChain()` on each (honouring `max_chain_depth`);
  on success removes now-stale audit rows via `cleanupAuditRecords()` →
  `storage->deleteBySourceRids()`.
- `fixAll(): array` — locks, then `fixChainsChunk(getAllChainIds(), $resolved)`.
  **Loops (`source_rid == target_rid`) are skipped** (`skipped_loops`) — they need manual
  correction. Returns `fixed_chains / errors / skipped_loops / total` (or `lock_failed`).
- Chunked API for the batch driver: `acquireFixLock()`, `getFixableChainIds()`,
  `fixChainsChunk($ids,&$resolved_source_rids)`, `releaseFixLock()`.

## `redirect_audit.chain_resolver` — `RedirectChainResolver` (`RedirectChainResolverInterface`)

Args: entity_type.manager, logger.factory, `@database`, datetime.time, path_alias.manager,
language_manager. Uses `RedirectPathResolverTrait`.

- `checkAndResolveChain(Redirect $r, int $max_depth = 10): bool` — `followChain()` walks
  the redirect to the end (throwing `RedirectLoopException` on a cycle); if the chain is
  longer than one and the final target differs, it sets `redirect_redirect` to the final
  destination and saves. Returns TRUE only when the entity actually changed.
- Processed-table bookkeeping: `markAsProcessed()`, `markRedirectsAsUnprocessed()`,
  `markAllAsUnprocessed()`, `findAndMarkRedirectsTo()/ToSource()`,
  `getUnprocessedRedirects()`, `countUnprocessedRedirects()`, `processRedirect()`,
  `processRedirects()`, `processBatch()`.

## `redirect_audit.storage` — `Service\RedirectAuditStorage`

Arg: `@database`. Thin data layer over the two tables (all queries parameterized / built
with the DB API).

- Writes: `saveChain($source,$target,$path)` (dedup + race-safe against the
  `chain_signature` UNIQUE index; returns existing id on `IntegrityConstraintViolationException`),
  `deleteChain()`, `deleteByRedirectId()` (also removes rows whose `path` references the
  rid, via anchored LIKE in `deleteWherePathContainsRid()`), `deleteBySourceRids()`,
  `clearProcessed()` (empties both tables).
- Reads: `getChains($limit,$offset,$header)` (tablesort-aware), `getChainById()`,
  `getStats()` (`total/chains/loops`), `countChains()`, `getAllChainIds()` (newest-first),
  `selfLoopExists()`, `loopWithSignatureExists()`.

## `Hook\RedirectAuditHooks`

Registered as a service (args: `@database`, storage, config.factory, `@queue`,
logger.factory) so its `#[Hook]` methods run OOP. See [../hooks/hooks.md](../hooks/hooks.md).

## `RedirectPathResolverTrait`

Shared by the analyzer and chain resolver: `extractTargetInfo()`,
`detectLanguageFromPath()`, `findRedirectByPath()` (language- and alias-aware next-hop
lookup using `Redirect::generateHash()`).

## Batch driver `RedirectAuditBatch`

Static Batch API callbacks used by the dashboard: `processAudit()`/`finishedAudit()`
(step size `AUDIT_STEP_SIZE = 100`) and `processFix()`/`finishedFix()`
(step size `FIX_STEP_SIZE = 25`). Each step re-acquires the scan lock to refresh its TTL;
the finished callbacks release it and print result messages.
