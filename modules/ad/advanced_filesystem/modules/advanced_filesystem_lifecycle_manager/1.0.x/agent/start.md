<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lifecycle Manager (advanced_filesystem_lifecycle_manager) — agent index

Sub-module of **Advanced Filesystem**. Retention / archive / delete policies for file & media
entities, evaluated on cron and applied through a queue. Depends on core `file`, `user` and
`advanced_filesystem`. Package `Advanced Filesystem`. Core `^10 || ^11 || ^12`.
License GPL-2.0-or-later. Version 1.0.27 (dir 1.0.x).

- **Policies, conditions, actions, cron scheduling, settings, Drush** → [config/policies.md](config/policies.md)
- **Evaluation service, action plugin type, queue, audit log, legal hold, webhook** → [api/lifecycle.md](api/lifecycle.md)

## What it provides

- **Config entity** `lifecycle_policy` (`src/Entity/LifecyclePolicy.php`, `admin_permission =
  administer lifecycle_policies`, config_export id/label/status/priority/description/conditions/actions).
  List builder + add/edit/delete forms.
- **Plugin type** `LifecycleAction` — annotation `src/Annotation/LifecycleAction.php`, manager
  `LifecycleActionPluginManager`, base `Plugin/LifecycleAction/LifecycleActionBase`. Built-in ids:
  `archive_to_storage`, `delete_file`, `restore_file`, `notify_user`, `strip_metadata`.
- **Core Action** `adfs_lifecycle_set_status` (`Plugin/Action/SetLifecycleStatusAction`, `type = file`)
  for Views Bulk Operations.
- **QueueWorker** `lifecycle_manager` (`Plugin/QueueWorker/LifecycleQueueWorker`, `cron = {"time"=30}`).
- **Services**: `…manager` (`LifecycleManagerService`), `…evaluator` (`PolicyEvaluator`),
  `…conflict_detector` (`PolicyConflictDetector`), `…audit_logger` (`LifecycleAuditLogger`),
  `…webhook_subscriber` (`EventSubscriber\WebhookEventSubscriber`), the action plugin manager.
- **Base fields on `file`** (from `.install`): `adfs_lifecycle_status` (active/archived/deleted/
  legal_hold), `adfs_last_accessed` (int), `adfs_original_uri` (string).
- **Table** `lifecycle_audit_log` (from `.install`).
- **Config object** `advanced_filesystem_lifecycle_manager.settings` (dry_run_mode, cron_limit,
  log_level, track_last_accessed).
- **Drush** (`drush.services.yml`, `LifecycleCommands`): `lifecycle:run`, `lifecycle:status`,
  `lifecycle:queue-size`, `lifecycle:reset-stats`.

## Routes / permissions

Permissions: `administer lifecycle_policies` (restrict access), `view lifecycle reports`,
`view lifecycle audit log`.

- `entity.lifecycle_policy.*` (collection/add/edit/delete) + `.settings`, `.run`, `.audit_log_clear`,
  `.legal_hold_list` — all `_permission: administer lifecycle_policies`.
- `.audit_log` — `administer lifecycle_policies+view lifecycle audit log`.
- `.legal_hold_set` / `.legal_hold_release` at `/admin/content/files/{file}/legal-hold/(set|release)`
  — `administer lifecycle_policies` **plus `_csrf_token: 'TRUE'`**.

## Mechanism (from source)

- `hook_cron` loads enabled policies, applies optional per-policy `schedule_days`/`schedule_hour`
  throttling (once/day per policy), then `LifecycleManagerService::evaluateOne(policyId, dry_run)`.
- `evaluateAll()/evaluateOne()` load policies (priority desc), call `evaluatePolicy()` which builds an
  entity query (`accessCheck(FALSE)`, permanent files, size/bundle pushed to DB), then
  `PolicyEvaluator::evaluate($entity, $policy)` decides the action and the entity is enqueued
  (deduped per run). `LifecycleQueueWorker` maps the action name to a `LifecycleAction` plugin and
  applies it, logging via `LifecycleAuditLogger` and dispatching `LifecycleActionAppliedEvent`.
- `hook_file_download` bumps `adfs_last_accessed` (returns NULL — never affects access).

## Notes / caveats

- The per-policy webhook URL is **admin-set on the policy** (`actions.webhook_url`); the POST uses the
  core `http_client` with default TLS verification (no verify-off).
- Deletion runs only from policy evaluation (cron / Run form / Drush) — all `administer
  lifecycle_policies`-gated; legal-hold set/release are CSRF-protected GET handlers.
