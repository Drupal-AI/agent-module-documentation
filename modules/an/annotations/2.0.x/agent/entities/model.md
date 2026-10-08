<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations — entity model

Three entities, defined in `src/Entity/`.

## `annotation` (content entity) — `Entity/Annotation.php`

`EditorialContentEntityBase` + `EntityOwnerTrait`. Tables `annotation` / `annotation_field_data` (+ `_revision` / `_field_revision`). `bundle` key = `type_id` (bundle entity `annotation_type`), `admin_permission: administer annotations`, `permission_granularity: bundle`, translatable, revisions with UI. Handlers: `access` = `AnnotationAccessControlHandler`, `views_data` = core `EntityViewsData`.

Base fields (`baseFieldDefinitions()`):
- `target_id` (string, 255) — the `annotation_target` machine name. `''`/NULL = site-wide.
- `field_name` (string, 255) — field machine name; **`''`/NULL = bundle-level (overview) annotation**.
- `value` (string_long, revisionable, translatable) — the annotation text. Plain string field, not formatted text. Form widget `string_textarea` (8 rows).
- `status` (published) — hidden; managed by content_moderation when a workflow is attached, else defaults to 1.
- `uid` (owner, revisionable, non-translatable), `created`, `changed`, `revision_log_message`.

Key behaviour:
- **Empty-string sentinel:** Drupal's `StringItem::isEmpty()` stores `''` as NULL, so equality queries for site-wide/bundle-level rows must use `IS NULL`. Always go through `AnnotationStorageService` (see [../api/storage.md](../api/storage.md)).
- `label()` has no dedicated field — it computes `"{target_label} › {field_label} › {type_label}"` (field `''` → "Overview").
- `preSave()` refreshes revision user/timestamp on non-form (API/drush) new-revision saves so drafts don't carry the previous editor forward.

## `annotation_target` (config entity) — `Entity/AnnotationTarget.php`

`config_prefix: target` → `annotations.target.{id}.yml`, id = `{entity_type}__{bundle}` (e.g. `node__article`). `admin_permission: administer annotation targets`. Exported props: `id`, `label`, `entity_type`, `bundle`, `fields` (array of in-scope field machine names). Presence of the entity = the scope is opted in; `fields` = which fields are annotatable. Methods: `getTargetEntityTypeId()`, `getBundle()`, `getFields()`, `isFieldIncluded()`, `setFields()`. Deleting a target deletes its annotation rows (via `AnnotationsHooks::annotationTargetDelete`).

## `annotation_type` (config entity) — `Entity/AnnotationType.php`

`ConfigEntityBundleBase`, `bundle_of: annotation`, `config_prefix: annotation_type` → `annotations.annotation_type.{id}.yml`. `admin_permission: administer annotation types`. Exported props: `id`, `label`, `description`, `weight` (lower = shown first). Methods `getEditPermission()`/`getConsumePermission()`/`getDeletePermission()` return `edit {id} annotations` / `consume {id} annotations` / `delete {id} annotations` — the dynamic permission names produced by `AnnotationsPermissions`. Deleting a type deletes its annotation rows (`AnnotationsHooks::annotationTypeDelete`). Ships editorial/technical/rules via the `annotations_demo_types` recipe; sites create their own via annotations_type_ui.
