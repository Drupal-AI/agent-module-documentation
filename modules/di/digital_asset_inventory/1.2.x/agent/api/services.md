# Services & entities

## Entities
- `digital_asset_item` — one discovered asset (file/media/external), with `display_title`,
  `title_source`, `anchor_title`, `image_alt`, `file_path`, `media_id`, `title_resolved_at`, etc.
- `digital_asset_usage` — a place an asset is used (entity/field/menu/config reference).
- `digital_asset_orphan_reference` — dangling paragraph/reference pointers.
- `digital_asset_archive` — an archive record (status: `queued`, `archived_public`,
  `archived_admin`, `archived_deleted`, `exemption_void`; visibility methods `isArchivedPublic()`,
  `isArchivedDeleted()`, `isExemptionVoid()`).
- `digital_asset_archive_note` — internal audit notes on an archive.

## Services (`digital_asset_inventory.services.yml`)
- `digital_asset_inventory.scanner` (`DigitalAssetScanner`) — the batchable scan engine:
  `acquireScanLock()`, `isScanLockStale()`, `breakStaleLock()`, `getCheckpoint()`,
  `clearCheckpoint()`, `suspendCron()`, `resetScanStats()`, `clearTemporaryItems()`. Phases are
  driven via `ScanAssetsForm::buildBatch($start_phase)`.
- `digital_asset_inventory.archive` (`ArchiveService`) — queue/execute/unarchive/visibility logic,
  file moves, queue integration.
- `digital_asset_inventory.title_resolver` (`TitleResolverService`) — two-phase title resolution.
  Phase 1 resolves from local site data (media name, anchor text, alt); Phase 2 fetches external
  URLs (`resolveExternalTitles()` / queue worker) via oEmbed then HTTP GET, reading up to
  `MAX_BODY_BYTES` (16 KB) of the `<title>`. **SSRF-guarded:** `isSafeUrl()` resolves the host and
  rejects private/reserved IPs (`FILTER_FLAG_NO_PRIV_RANGE|NO_RES_RANGE`); redirects are disabled
  and each redirect target is re-checked (explicitly blocking cloud metadata like
  169.254.169.254); a title blocklist filters auth-gate/error pages. Fires
  `hook_digital_asset_inventory_title_resolve_alter()` before storing (see
  [../hooks/hooks.md](../hooks/hooks.md)).
- `digital_asset_inventory.dashboard_data` (`DashboardDataService`) — aggregates for the dashboard.
- `digital_asset_inventory.alt_text_evaluator` (`AltTextEvaluator`) — per-usage alt-text status.
- `digital_asset_inventory.media_signal_detector` (`MediaAccessibilitySignalDetector`) —
  audio/video controls/captions/subtitles signals.
- `digital_asset_inventory.uninstall_validator` (`DaiUninstallValidator`) — blocks uninstall while
  archives/data exist.
- Event subscribers: `ArchiveLinkResponseSubscriber` (rewrites links to archived assets),
  `CsvExportFilenameSubscriber` (names CSV export files).
- Queue worker: `dai_resolve_external_title` (`ResolveExternalTitleQueueWorker`).
- Twig extension: `ArchiveAwareTwigExtension`.

## Views plugins
The module ships Views field/filter/area/access plugins (e.g. `ArchiveStatusField`,
`AssetTypeFilter`, `DigitalAssetIsUsedFilter`, `ArchiveViewAccess`) used by the bundled views —
they are plugin implementations, not new plugin types.
