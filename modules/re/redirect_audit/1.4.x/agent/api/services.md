# API — services

Four public services (all defined in `redirect_audit.services.yml`, each also aliased to
its class/interface for autowiring). All operate on `redirect` entities and the two audit
tables; none perform HTTP.

## `redirect_audit.analyzer` — `RedirectAuditAnalyzer`

Detects chains/loops. Key methods:

- `analyzeRedirect(Redirect $redirect): ?array` — analyze one redirect. Returns `NULL`
  when standalone, else `['source_rid','target_rid','path','is_loop','chain']`. `path` is a
  dot-separated list of intermediate redirect IDs; for a loop `source_rid == target_rid`.
- `detectChains(): array` — full scan (acquires the `redirect_audit_scan` lock, truncates
  and rebuilds audit tables). Returns `['redirects_analyzed','chains_found','loops_found']`
  (plus `lock_failed` when another scan holds the lock).
- Chunked scan API used by the batch driver: `detectChainsInit()`,
  `createDetectionState()`, `countTotalRedirects()`,
  `detectChainsChunk(int $offset, int $batch_size, array &$state): array`,
  `detectChainsFinish()`, `acquireScanLock()`/`releaseScanLock()`.
- Constants: `SCAN_LOCK_NAME = 'redirect_audit_scan'`, `SCAN_LOCK_TTL = 1800.0`.

```php
$analyzer = \Drupal::service('redirect_audit.analyzer');
$stats = $analyzer->detectChains();          // ['chains_found' => n, 'loops_found' => m, ...]
$chain = $analyzer->analyzeRedirect($redirect); // NULL or chain-data array
```

## `redirect_audit.fixer` — `RedirectAuditFixer`

Resolves detected chains by rewriting redirects.

- `fixChain(int $audit_id): bool` — fix one stored chain record (loads source, follows the
  chain, points it at the final destination, cleans up now-stale audit rows).
- `fixAll(): array` — fix every stored chain in one pass. Returns
  `['fixed_chains','errors','skipped_loops','total']` (+ `lock_failed`). **Loops are
  skipped** (`source_rid == target_rid` cannot be auto-resolved).
- Shares the same lock as the analyzer: `FIX_LOCK_NAME = 'redirect_audit_scan'`.

## `redirect_audit.storage` — `RedirectAuditStorage`

Thin DB layer over `redirect_audit_chains` / `redirect_audit_processed`.

- `saveChain(int $source, int $target, string $path): int` (race-safe against the
  `chain_signature` unique key), `getChains(?limit,?offset,?header)`, `getChainById(int)`,
  `getStats(): ['total','chains','loops']`, `countChains()`, `getAllChainIds()`.
- Deletion: `deleteChain(int)`, `deleteByRedirectId(int)` (source/target/path matches),
  `deleteBySourceRids(array)`, `clearProcessed()` (truncates both tables).
- Loop dedupe: `selfLoopExists(int)`, `loopWithSignatureExists(int, array $signature)`.

## `redirect_audit.chain_resolver` — `RedirectChainResolverInterface`

Lower-level resolver (`RedirectChainResolver`) used by the fixer and the
processed-tracking flow.

- `checkAndResolveChain(Redirect $redirect, int $max_depth = 10): bool` — follow and, if a
  multi-hop chain exists whose final target differs, rewrite `redirect_redirect` and save;
  throws `RedirectLoopException` on a cycle.
- Processed-table helpers: `markAsProcessed()`, `markRedirectsAsUnprocessed(array)`,
  `markAllAsUnprocessed()`, `findAndMarkRedirectsTo(string $path)`,
  `getUnprocessedRedirects()`, `countUnprocessedRedirects()`, `processBatch()`.

## Batch driver — `Drupal\redirect_audit\RedirectAuditBatch`

Static callbacks for Batch API used by the dashboard: `processAudit()`/`finishedAudit()`
(scan) and `processFix()`/`finishedFix()` (fix). Step sizes are fixed constants
(scan 100, fix 25); the lock TTL is refreshed on every step.
