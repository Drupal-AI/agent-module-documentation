<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lifecycle Manager — policies, conditions, actions, settings

## Install / enable

```bash
drush pm:install advanced_filesystem_lifecycle_manager
drush cr
```

`hook_install` (`.install`) installs three base fields on the `file` entity
(`adfs_lifecycle_status`, `adfs_last_accessed`, `adfs_original_uri`) and `hook_schema` creates the
`lifecycle_audit_log` table.

## The `lifecycle_policy` config entity

Defined in `src/Entity/LifecyclePolicy.php` (`@ConfigEntityType id = lifecycle_policy`,
`config_prefix = lifecycle_policy`, `admin_permission = administer lifecycle_policies`). Managed at
`/admin/config/media/advanced_filesystem/lifecycle` (collection → add/edit/delete forms
`LifecyclePolicyForm` / `LifecyclePolicyDeleteForm`). Exported keys: `id`, `label`, `status`,
`priority`, `description`, `conditions`, `actions`.

### Conditions (schema: `config/schema/…schema.yml`)

`entity_type`, `bundles[]`, `mime_types[]`, `min_size`/`max_size` (bytes), `age_field`,
`min_age`+`min_age_unit` (minutes|hours|days) (legacy `min_age_days`), `has_exif_metadata`,
`lifecycle_status[]`, `referencing_entity_type`, `referencing_bundle`, `referencing_field_name`.
`PolicyEvaluator::evaluate()` applies these; size/bundle are pushed into the entity query,
age / MIME wildcards / EXIF presence / status are filtered in PHP.

### Actions

`archive_after`+`archive_after_unit` (+ `archive_stream_wrapper`, `archive_subdirectory`,
`strip_metadata_on_archive`), `delete_after`+`delete_after_unit` (`delete_mode` soft|hard,
`delete_referenced`, `legal_hold` = respect legal hold), `notify_on_archive`/`notify_on_delete`
with `notify_roles[]`, and the per-policy `webhook_url`. Legacy `*_after_days` keys are kept for
back-compat (0 when the value+unit form is used).

## Module settings

Config object **`advanced_filesystem_lifecycle_manager.settings`** — form
`LifecycleSettingsForm` at `…/lifecycle/settings`:

| Key | Default | Meaning |
|---|---|---|
| `dry_run_mode` | `false` | Global simulate — evaluate/queue but apply no changes. |
| `cron_limit` | `500` | Max entities evaluated/enqueued per cron run. |
| `log_level` | `info` | Audit/log verbosity. |
| `track_last_accessed` | `true` | Update `adfs_last_accessed` on private-file download. |

## Cron scheduling

`hook_cron` iterates enabled policies. With no `schedule_days`, a policy runs every cron. With
`schedule_days` set (weekday numbers 1–7), it runs only on matching days, throttled to once per day
per policy via `state('lifecycle_manager.cron_last.<id>')`, and only in `schedule_hour` if set. Each
eligible policy is passed to `LifecycleManagerService::evaluateOne($id, $dry_run)`.

## Run form & Drush

- Route `.run` → `LifecycleRunForm` at `…/lifecycle/run` triggers an on-demand evaluation.
- `LifecycleCommands` (`@command`): `lifecycle:run` (evaluate now, `--policy`/`--dry-run` options),
  `lifecycle:status`, `lifecycle:queue-size`, `lifecycle:reset-stats`.

## Legal hold & audit log

- `LegalHoldController` (`.legal_hold_list/set/release`) sets `adfs_lifecycle_status = legal_hold`
  so `PolicyEvaluator` skips the file. Set/release require `_csrf_token`.
- `AuditLogController` (`.audit_log`) renders `lifecycle_audit_log` (filter by `fid`/`policy_id`);
  `ClearAuditLogForm` (`.audit_log_clear`) empties it; `LifecycleAuditLogger::prune($days)` trims it.
