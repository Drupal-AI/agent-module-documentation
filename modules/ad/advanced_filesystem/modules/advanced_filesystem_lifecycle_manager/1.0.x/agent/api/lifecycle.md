<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lifecycle Manager — services, action plugin type, queue, events

## Services

- `advanced_filesystem_lifecycle_manager.manager` = `LifecycleManagerService`
  (`@entity_type.manager`, `@queue`, logger, `@config.factory`,
  `@plugin.manager.lifecycle_action`, `@…evaluator`, `@state`).
- `advanced_filesystem_lifecycle_manager.evaluator` = `PolicyEvaluator` (`@entity_type.manager`,
  logger, `@database`).
- `advanced_filesystem_lifecycle_manager.conflict_detector` = `PolicyConflictDetector`.
- `advanced_filesystem_lifecycle_manager.audit_logger` = `LifecycleAuditLogger` (`@database`,
  `@current_user`).
- `advanced_filesystem_lifecycle_manager.webhook_subscriber` = `EventSubscriber\WebhookEventSubscriber`
  (`@http_client`, `@config.factory`, logger) — tagged `event_subscriber`.
- `plugin.manager.lifecycle_action` = `LifecycleActionPluginManager`.

## Evaluation

`LifecycleManagerService::evaluateAll(bool $dry_run=FALSE, ?int $limit=NULL): int` loads enabled
policies, sorts by `getPriority()` desc, and calls `evaluatePolicy()` until `cron_limit` items are
queued. `evaluateOne(string $policy_id, bool $dry_run=FALSE, ?int $limit=NULL)` does one policy
(throws `InvalidArgumentException` if missing/disabled). `evaluatePolicy()`:

1. Builds `$storage->getQuery()->accessCheck(FALSE)` — for files, `status=1` plus `min_size`/
   `max_size`/`bundles` pushed to the DB; fetches `max($remaining*4, 100)` ids.
2. Per entity, `PolicyEvaluator::evaluate($entity, $policy)` returns an action name or NULL.
3. Dedupes `entity_type:id:policy_id` within the run, then `queue->createItem([...])`.
4. Records `state('lifecycle_manager.last_evaluation')`.

## LifecycleAction plugin type

Annotation `@LifecycleAction` (`src/Annotation/LifecycleAction.php`), manager
`LifecycleActionPluginManager` (namespace `Plugin/LifecycleAction`), interface
`LifecycleActionInterface::apply(EntityInterface $entity, array $context): array`, base
`LifecycleActionBase`. Built-in plugins:

| id | Class | Effect |
|---|---|---|
| `archive_to_storage` | `ArchiveToStorageAction` | Move file to another stream wrapper/subdir; may strip metadata; records `adfs_original_uri`. |
| `delete_file` | `DeleteFileAction` | Soft (status) or hard delete; optionally delete referencing Media. |
| `restore_file` | `RestoreFileAction` | Move back to `adfs_original_uri`. |
| `notify_user` | `NotifyUserAction` | Mail the configured `notify_roles`. |
| `strip_metadata` | `StripMetadataAction` | Clear `adfs_*` metadata fields. |

Add a custom action by placing a `@LifecycleAction`-annotated class in
`Plugin/LifecycleAction/` implementing `apply()`.

## Queue worker

`Plugin/QueueWorker/LifecycleQueueWorker` (id `lifecycle_manager`, `cron = {"time"=30}`) reads a
queue item (`entity_type`, `entity_id`, `action`, `policy_id`, `dry_run`), maps the action name to a
`LifecycleAction` plugin via `ACTION_PLUGIN_MAP`, calls `apply()`, writes a row through
`LifecycleAuditLogger::log()` and dispatches `LifecycleActionAppliedEvent`.

## Audit log

`LifecycleAuditLogger` writes one row per action to `lifecycle_audit_log`
(`insert('lifecycle_audit_log')`). Read via `getEntries(?fid, ?policy_id, limit=200)` /
`countEntries(...)` (parameterised query builder), trimmed via `prune(int $days)`.

## Webhook event

`LifecycleActionAppliedEvent` (`EVENT_NAME`) carries `policyId`, `action`, `entity`, `fileUri`,
`originalUri`, `result`. `WebhookEventSubscriber::onActionApplied()` loads the policy, reads
`actions.webhook_url` (admin-configured), and if non-empty POSTs a JSON payload
(`$this->httpClient->post($webhook_url, ['json'=>…, 'timeout'=>10, 'headers'=>[UA]])`) using the
core client's default TLS verification. Failures are logged, never thrown.
