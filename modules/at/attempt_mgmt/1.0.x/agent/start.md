<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attempt Management (attempt_mgmt) — agent index

Provides an **attempt** content entity type plus a field you attach to any content entity, so a site can record per-user, per-entity attempts (quiz / SCORM / retryable submission) without building the data model each time. Building block, not a finished feature — `scorm_field` is the primary consumer. Version dir `1.0.x` (installed from a git dev checkout; `info.yml` has no `version:` line). Core `^10 || ^11`. No dependencies outside core.

## What it provides
- **Content entity** `attempt_mgmt_attempt` (`src/Entity/Attempt.php`), bundled by the **config entity** `attempt_mgmt_attempt_type` (`src/Entity/AttemptType.php`). `admin_permission = "administer attempt_mgmt_attempt types"`.
- **Field type** `attempt_mgmt_attempt_settings` (`src/Plugin/Field/FieldType/AttemptManagementItem.php`) with default widget + formatter `attempt_mgmt_settings_default`.
- **Service** `attempt_mgmt.factory` → `AttemptFactory` (`src/AttemptFactory.php`): create/update/count/close attempts for authed users (uid) or anon (session UUID).
- **Plugin type** `AttemptProcessing` (annotation `src/Annotation/AttemptProcessing.php`, manager `plugin.manager.attempt_processing.processor`, base `src/Plugin/AttemptProcessingBase.php`), dir `Plugin/AttemptProcessing`, alter hook `attempt_mgmt_attempt_processing_info`.
- **Config** `attempt_mgmt.settings` (confirm/limit strings) + settings form at `/admin/config/system/attempt-management/settings` (perm `administer site configuration`).
- **Hook** `hook_user_logout` → `AttemptFactory::setAttemptsToClosedForUser()` closes a user's open attempts at logout.
- Optional REST resource config (cookie auth) for the attempt entity; two entity actions (save/delete); a `confirm-form-design` CSS library.

## Permissions
- `administer attempt_mgmt_attempt types` — administer attempt types AND all attempt-entity CRUD (it is the entity `admin_permission`).
- `administer site configuration` — the settings form.

## Routes (all admin / permission-gated)
- `/admin/content/attempt` (collection), `/attempt/add`, `/attempt/{attempt_mgmt_attempt}` (edit; canonical is remapped to the edit form by `AttemptHtmlRouteProvider`).
- `/admin/structure/attempt_mgmt_attempt_types` (type collection/add/edit).
- `/admin/config/system/attempt-management/settings` (`attempt_mgmt.settings`).

## Solution docs
- [Attempt entity & types](entities/attempt.md) — base fields, bundle, preSave/preCreate, routes.
- [Attempt settings field](fields/settings-field.md) — field type properties, widget, formatter.
- [AttemptFactory API](api/factory.md) — the service methods to drive attempts.
- [AttemptProcessing plugins](plugins/attempt-processing.md) — the annotation plugin type.
- [Settings & configuration](config/settings.md) — config object, schema, install schema table.

See also `scorm_field`, which depends on this module to store SCORM attempt results.
