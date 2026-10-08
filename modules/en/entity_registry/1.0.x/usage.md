Entity Registry is a developer framework that automatically tracks every insert/update/delete on content entities (per translation) and dispatches those changes to your **consumer plugins**, so you write only the processing logic (index, sync, audit) while the module handles tracking, status lifecycle, retries, queueing, batching, and locking.

---

You define a consumer as a PHP class with the `#[EntityRegistryConsumer(id, label)]` attribute extending `EntityRegistryConsumerBase`, implementing `processItem()` and `deleteItem()` (and optionally `shouldProcessItem()`, `getTrackedEntityTypes()`, `clearData()`, `getStoredItemCount()`, `getTotalItems()`). Entity lifecycle OOP hooks in `Hook\EntityRegistryHooks` capture changes and the `Tracker` service records a row per (consumer, entity_type, entity_id, langcode) in the `entity_registry` table with a status of PENDING → PROCESSED or FAILED (with `retry_count`). The `IndexProcessor` service runs items in three phases — `save` (synchronous on entity save), `cron` (via `hook_cron` and a queue worker), and `batch` (admin bulk op or Drush) — using atomic claim queries plus the core `lock` service for concurrency safety. An admin dashboard at `/admin/config/system/entity-registry` (permission `administer entity registry`, `restrict access: true`) lists consumers with live pending/processed/failed counts and per-consumer detail pages to configure tracked bundles, process/queue/retry/clear/rebuild, and inspect failed items; every operation has a matching Drush command (`entity-registry:status|process|queue|retry|clear|rebuild`). Global settings (`entity_registry.settings`: `cron_enabled`, `batch_size`, `chunk_size`) plus optional per-consumer `entity_registry.consumer.<id>.batch_size` tune throughput. `processItem()` may return TRUE (PROCESSED), FALSE (FAILED + retry), or NULL (defer, leave PENDING for cron). It requires Drupal 11 and PHP 8.1+ (attribute discovery); no contrib dependencies.

---

- Keep an external search engine (Elasticsearch/Algolia/etc.) in sync with Drupal content changes.
- Push entity create/update/delete events to an external API or CRM.
- Build a content audit or change-tracking pipeline over entity lifecycle events.
- Warm caches or pre-render pages when content changes.
- Feed analytics/reporting systems with entity change streams.
- Re-index all existing content of a type on demand (populate/queue operation).
- Process expensive indexing work asynchronously on cron instead of blocking entity saves.
- Retry only the items that previously failed, with an automatic retry-count cap.
- Restrict a consumer to specific entity types/bundles without editing plugin code (admin form).
- Filter at runtime which entities a consumer handles via `shouldProcessItem()`.
- Track each translation of a multilingual entity independently.
- Defer per-item processing (return NULL) so cron picks it up when work is too costly inline.
- Push bundle filtering into SQL via `getTrackedEntityTypes()` to avoid full-scanning all entity types.
- Report how many items a consumer has stored vs. how many are eligible on the admin detail page.
- Clear a consumer's derived data and re-mark everything PENDING to rebuild from scratch.
- Rebuild the tracking table by re-discovering all matching entities (e.g. after adding a consumer).
- Run any bulk operation from the CLI with Drush for cron/CI automation.
- Tune per-consumer batch size independently of the global default.
- Automatically drop tracking rows when a consumer's provider module is uninstalled.
- Use core-only infrastructure (no contrib deps) to standardize "on content change, do X" logic.
