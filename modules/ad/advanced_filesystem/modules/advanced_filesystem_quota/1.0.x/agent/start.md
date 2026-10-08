<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Filesystem: Quota Manager (advanced_filesystem_quota) — agent index

Submodule of **Advanced Filesystem**. Enforces per-user / per-role / per-bundle file storage
quotas on upload; adds a usage dashboard, a per-user "My Files" page, and near-limit email alerts.

## What it is
- Depends on `drupal:file`, `drupal:user`, `advanced_filesystem:advanced_filesystem`.
- Config object `advanced_filesystem_quota.settings` (`enabled`, `uid1_bypass`; `near_limit_alerts.*` read at runtime).
- One DB table (`hook_schema`): `advanced_filesystem_quota_rules`.
- Ships **no permission of its own** — admin routes use the parent's `administer advanced_filesystem`.
- `configure` route: `advanced_filesystem_quota.settings`.

## Routes (`advanced_filesystem_quota.routing.yml`)
- `.settings` `/admin/config/media/advanced_filesystem_quota` — QuotaSettingsForm (admin).
- `.rule_add` / `.rule_edit` / `.rule_delete` — QuotaRuleForm / QuotaRuleDeleteForm (admin).
- `.dashboard` `/admin/reports/advanced_filesystem/quota` — QuotaDashboardController (admin).
- `.my_files` `/user/{user}/my-files` — UserMediaController; `_custom_access: UserMediaController::myFilesAccess` (self or admin).
- `.my_files_delete` `/user/{user}/my-files/delete/{fid}` — MyFileDeleteForm (self or admin; owner re-checked in build+submit).

## Services & code
- `QuotaManager` (`advanced_filesystem_quota.quota_manager`) — rule CRUD, `getRulesForUser()`, `getEffectiveLimit()`, `getUserStorageUsed()`, `checkUploadWithAction()`, `getDashboardData()`, `sendNearLimitAlerts()`, `getUserFiles()`.
- `EventSubscriber\QuotaFileValidator` — subscribes core `FileValidationEvent`; blocks (ConstraintViolation) or warns on over-quota new uploads; skips already-permanent files and uid 0.
- `Controller\QuotaDashboardController`, `Controller\UserMediaController` (My Files + admin userFiles).
- `Form\QuotaSettingsForm`, `QuotaRuleForm`, `QuotaRuleDeleteForm`, `MyFileDeleteForm`.
- `advanced_filesystem_quota.module` — `hook_cron` (near-limit alerts), `hook_mail` (`near_limit_alert`).

## Solution docs
- Rules, enforcement & the QuotaManager API: [agent/api/quota-manager.md](api/quota-manager.md)
- Settings, dashboard, My Files, table & alerts: [agent/config/settings.md](config/settings.md)
