<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations — storage API & permissions

## `AnnotationStorageService` (`annotations.annotation_storage`)

`src/AnnotationStorageService.php`. The sanctioned read/write layer for annotation rows — use it instead of raw entity queries because of the empty-string sentinel.

**Sentinel:** `target_id = ''` (site-wide) and `field_name = ''` (bundle/overview level) are stored as NULL. `applySentinelCondition($query, $field, $value)` (static) translates `''` → `IS NULL`, else adds an equality condition. Every method uses it.

Read methods (all `accessCheck(FALSE)` — callers gate access themselves):
- `getForTarget($target_id, $published_only = FALSE, $langcode = NULL)` → `[field_name => [type_id => value]]` from the **default** (published) revision. Per-request cached by `target|published|langcode`. Pass `$published_only = TRUE` in consumer contexts.
- `getLatestForTarget($target_id, $langcode = NULL)` → same shape from the **latest** revision (use in editing UIs so drafts show).
- `getEntitiesForTarget($target_id)` → latest-revision `Annotation` entities keyed `field_name|type_id` (used by annotations_workflows for moderation state).
- `getEntityMapForTarget($target_id, $published_only = FALSE, $langcode = NULL)` → default-revision entities `[field_name => [type_id => Annotation]]` (used by annotations_overlay to render full field content).
- `hasAnnotationData($target_id)` → bool (gates delete confirmation).

Write/maintenance:
- `deleteForTarget($target_id)`, `deleteForType($type_id)`, `countForType($type_id)`. The two delete methods are called from `AnnotationsHooks` on target/type deletion (idempotent; skipped during module uninstall — schema already dropped).

## Access — `AnnotationAccessControlHandler` (`src/Access/`)

`administer annotations` → allow all ops. Otherwise:
- **update** → `edit any annotation` OR `edit {bundle} annotations`.
- **delete** → `delete any annotation` OR `delete {bundle} annotations`.
- **view** → any of the edit/delete (any or per-type) permissions.
- **create** → `administer annotations` OR `edit any annotation` OR `edit {bundle} annotations`.
All `cachePerPermissions()`. Revision-specific operations (revert/delete-revision/view-revision) are handled by `annotations_ui`'s `AnnotationsUiHooks` via `hook_entity_access`, since `checkAccess()` only receives the four CRUD ops.

## Permissions — `AnnotationsPermissions` + `annotations.permissions.yml`

Static: `administer annotations`, `administer annotation targets`, `administer annotation types` (all `restrict access: true`), `access annotation collection`, `edit any annotation`, `delete any annotation`.
Dynamic (`permission_callbacks` → `AnnotationsPermissions::permissions`, using `BundlePermissionHandlerTrait`): per annotation type `consume {id} annotations` (not restricted), `edit {id} annotations`, `delete {id} annotations`. Each is registered with the type as a config dependency, so deleting the type removes the grant automatically. Returns `[]` before `annotation_type` is registered (initial install).

## Drush (`src/Drush/Commands/AnnotationsCommands.php`)

`annotations:targets` (ann:targets) — list targets; `annotations:types` (ann:types) — list types; `annotations:show` (ann:show) — show annotation content for a target; `annotations:stats` (ann:stats) — annotation counts/coverage stats.
