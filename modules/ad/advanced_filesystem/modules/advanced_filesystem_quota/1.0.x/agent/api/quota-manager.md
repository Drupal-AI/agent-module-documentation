<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rules, enforcement & the QuotaManager API

## Rule model (`advanced_filesystem_quota_rules` table)
Columns (`.install` `hook_schema`): `id` (PK), `quota_type` (`uid`|`role`|`bundle`), `identifier`
(numeric uid string or role machine name; empty for bundle), `limit_bytes` (big int), `weight`
(small int), `exceed_action` (`block`|`warn`|`''`=global default), `entity_type`, `bundle`,
`created`. Index on (`quota_type`,`identifier`). Updates 10001/10002 added `exceed_action` then the
bundle columns.

CRUD via `QuotaManager`: `getAllRules()`, `getRule(int)`, `saveRule(array)` (insert or update when
`id` present), `deleteRule(int)`. All queries use the DB API with bound conditions (no SQLi).

## Resolving the effective limit
`getRulesForUser(AccountInterface, ?entityType, ?bundle)`:
- Collects `uid` rules where `identifier == user->id()`, `role` rules where `identifier` is one of the user's roles, and (only if context given) `bundle` rules matching entity_type+bundle.
- **Priority:** returns uid rules if any, else role rules, else bundle rules.
`getEffectiveLimit(...)` = `min(limit_bytes)` across the returned tier (most restrictive wins), or
`NULL` when no rule applies (= unlimited).

## Usage measurement
`getUserStorageUsed(int $uid)` = `SUM(filesize)` from `file_managed WHERE uid=? AND status=1`
(permanent files only). `getStorageForUids()` / `getStorageForBundle()` back the dashboard; the
bundle sum joins `file_usage` to `node_field_data`/`media_field_data` (bound `:bundle` param), with a
generic type-only fallback.

## Upload enforcement
`EventSubscriber\QuotaFileValidator::onFileValidate(FileValidationEvent)`:
1. Return if `QuotaManager::isEnabled()` is false.
2. Skip files that are not new and already permanent (avoids false violations during entity re-validation).
3. `checkUploadWithAction($file, currentUser())`.
4. If `exceeded` and action `block`: add a `ConstraintViolation` (propertyPath `'0'`) → upload rejected.
   If action `warn`: `messenger->addWarning()`. Always logs a notice.

`checkUploadWithAction(FileInterface, AccountInterface)` returns
`{exceeded, action, message}`:
- uid 0 (anonymous) → never exceeded.
- uid 1 with `uid1_bypass` → never exceeded.
- No applicable rule → not exceeded.
- Else effective `limit = min(limit_bytes)`; `used = getUserStorageUsed(uid)`; if `used + file.size > limit`, `exceeded=true` with `action` = the rule's `exceed_action` or global `exceed_action` (default `block`).

The measured `used` and the file's `size` are server-side values (DB + the stored file); no
client-supplied quota input is trusted. Legacy `checkUpload()` wraps `checkUploadWithAction()` and is
marked deprecated. Enforcement runs only through the modern `FileValidationEvent` path
(`hook_file_validate` was removed — see the module file comment).

## Near-limit alerts
`sendNearLimitAlerts(thresholdPct=80, intervalSeconds=86400, dryRun=false)` builds a uid→limit map
(uid rules win), computes usage %, skips users below threshold or notified within the interval
(State key `advanced_filesystem_quota.near_limit_notified.<uid>`), and sends the `near_limit_alert`
mail (`hook_mail`). Driven by `hook_cron` when `near_limit_alerts.enabled` config is set.
