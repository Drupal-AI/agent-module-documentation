<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# config_guardian — services (call in code)

All autowired; class-name service ids plus short aliases (see
`config_guardian.services.yml`). No public hook/plugin API — extend by calling these.

## config_guardian.snapshot_manager — SnapshotManagerService
- `createSnapshot(string $name, string $type='manual', array $options=[]): array`
  — captures active + sync storage into a v2 blob. `$options`: `description`,
  `exclude_patterns`. Types used in-module: `manual`, `auto`, `pre_import`,
  `pre_rollback`. Returns `['id','uuid','name','type','config_count','active_count','sync_count']`.
- `loadSnapshot(int $id): ?array` — one DB row.
- `getSnapshotList(array $filters=[], int $limit=20, int $offset=0): array` — `filters['type']`.
- `getSnapshotCount(array $filters=[]): int`
- `deleteSnapshot(int $id): bool`
- `compareSnapshots(int $id1, int $id2): SnapshotDiff` — `added`/`removed`/`modified`.
- `getSnapshotConfigData/ActiveData/SyncData(int $id): array`; `isSnapshotV2(int $id): bool`
- `exportSnapshot(int $id): ?array` (meta + decompressed config); `importSnapshot(array $data): array`
- `compressData(array): string` (JSON + gzip/bzip2); `decompressData(string): array`
  (JSON first, else `unserialize` with `allowed_classes=>FALSE`).
- `verifySnapshotIntegrity(int $id): bool` (SHA-256); `cleanupOldSnapshots(int $cutoff, int $max)`.

## config_guardian.rollback_engine — RollbackEngineService
- `rollbackToSnapshot(int $id, array $options=[]): RollbackResult` — restores active
  + sync via `StorageComparer`, then `configFactory->reset()` + `drupal_flush_all_caches()`.
  `$options`: `create_backup` (default TRUE → makes a `pre_rollback` snapshot),
  `delete_new_configs` (default FALSE → does NOT delete configs absent from snapshot).
- `simulateRollback(int $id): RollbackSimulation` — dry-run: `toCreate/toUpdate/toDelete/toRename`,
  `syncToCreate/Update/Delete`, `riskAssessment`, `totalChanges`.
- `rollbackConfigs(array $names, int $id): RollbackResult` — selective active-config restore.
- `prepareRollbackBatch(int $id, array $options=[]): array` — changelists for batch UI.
- Deprecated (removed in 2.0.0): `simulateSyncRestore()`, `restoreSyncFromSnapshot()`.

## config_guardian.config_analyzer — ConfigAnalyzerService
- `getPendingChanges(): array` → `['create'=>[],'update'=>[],'delete'=>[]]`.
- `calculateRiskScore(array $names): RiskAssessment` (score 0–100, level, riskFactors).
- `analyzeConfig(string $name): ConfigAnalysis` (dependencies, dependents, impactScore, configType).
- `findConflicts(array $names): array`; `buildDependencyGraph(array $names=[]): array` (nodes/links).

## config_guardian.config_sync — ConfigSyncService
- `getExportPreview()/getImportPreview()`; `exportConfig(string)/exportAllConfigs()`;
  `createConfigImporter(): ConfigImporter`; `validateImport(): array`;
  `createBackupSnapshot(): ?int`; `logExportActivity()/logImportActivity()`.

## config_guardian.activity_logger — ActivityLoggerService
- `log(string $action, array $details=[], array $config_names=[], ?int $snapshot_id=null, string $status='success')`
  — records user id + client IP.
- `getActivities(array $filters=[], int $limit=50, int $offset=0)`; `getRecentActivities(int)`;
  `getActivityCount()`; `cleanup(int $days)`; `getActionLabel(string): TranslatableMarkup`.

## config_guardian.event_subscriber — ConfigEventSubscriber
- `ConfigEvents::IMPORT_VALIDATE` (prio 100) → creates a `pre_import` snapshot (once
  per import; guarded by static flag; only if `auto_snapshot_before_import`).
- `ConfigEvents::IMPORT` (prio 100) → logs the import's processed changes.
