<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, dashboard, My Files, table & alerts

## Install / enable
`drush en advanced_filesystem_quota` (pulls in `advanced_filesystem`, `file`, `user`). Enforcement is
OFF until you set `enabled` and add at least one rule.

## Settings — `advanced_filesystem_quota.settings`
Form `Form\QuotaSettingsForm` at `/admin/config/media/advanced_filesystem_quota`
(`administer advanced_filesystem` — parent permission). Config keys with schema:
- `enabled` (bool, default `false`) — master switch for upload enforcement.
- `uid1_bypass` (bool, default `true`) — let the super-admin bypass quotas.
- `exceed_action` (string, read at runtime; default `block`) — global default action when no per-rule action is set.
- `near_limit_alerts.enabled` / `.threshold_pct` (default 80) / `.interval_seconds` (default 86400) — read by `hook_cron` for email alerts.

## Rule management
- `advanced_filesystem_quota.rule_add` / `.rule_edit` — `Form\QuotaRuleForm` (pick type uid/role/bundle, identifier, limit, weight, action).
- `advanced_filesystem_quota.rule_delete` — `Form\QuotaRuleDeleteForm` (confirm).
All gated by `administer advanced_filesystem`.

## Dashboard
`Controller\QuotaDashboardController::dashboard()` at `/admin/reports/advanced_filesystem/quota`.
Renders `QuotaManager::getDashboardData()` — every rule with label, user count, used/limit bytes and a
usage-percent bar (blue / orange ≥70% / red ≥90%). Warns when enforcement is disabled. Escapes cell
values with `Html::escape()`.

## Per-user "My Files"
- `advanced_filesystem_quota.my_files` `/user/{user}/my-files` → `UserMediaController::myFiles()`.
  `_custom_access: UserMediaController::myFilesAccess` — allowed for `administer advanced_filesystem` OR when `account->id() === user->id()` (self-only otherwise). Shows a quota banner + paginated list of the user's permanent files with View / Dependencies (admin) / Delete links.
- `advanced_filesystem_quota.my_files_delete` `/user/{user}/my-files/delete/{fid}` → `Form\MyFileDeleteForm`.
  Same custom access; additionally the form re-checks `file->getOwnerId() === currentUser` (unless admin) in **both** `buildForm()` and `submitForm()` before deleting, so a non-admin cannot delete a file they do not own even by changing `{fid}`. Deletes the file even if still referenced (user chose to free space; a warning is shown when references exist).

## Table & cron
- Table `advanced_filesystem_quota_rules` (see api doc); dropped and config deleted on uninstall.
- `hook_cron` calls `QuotaManager::sendNearLimitAlerts()` when `near_limit_alerts.enabled`.
- `hook_mail` defines the `near_limit_alert` message (subject + plain-text body via ByteSizeMarkup).

## Permissions
No permission is declared by this submodule. Every admin/report/rule route requires the parent
module's `administer advanced_filesystem`. The My Files routes use the self-or-admin custom check.
