<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations UI — routes, forms, access

All routes live under `/admin/content/annotations` and are `_admin_route: TRUE`. `{annotation_target}` upcasts to an `annotation_target` config entity.

| Route | Path | Access | Handler |
|---|---|---|---|
| `annotations_ui.annotate.collection` | `/admin/content/annotations` | `access annotation collection` | `AnnotationController::page` |
| `annotations_ui.target.collection` | `/…/{annotation_target}` | `access annotation collection` | `AnnotationController::collectionPage` (embeds view `annotations_target:embed_1`) |
| `annotations_ui.target.add` | `/…/{annotation_target}/add` | `access annotation collection` | `AnnotationController::addPage` |
| `annotations_ui.target.create` | `/…/{annotation_target}/add/{field_name}/{type_id}` | `_custom_access: AnnotationController::createAccess` | `AnnotationController::createAnnotationForm` |
| `annotations_ui.target.delete_all` | `/…/{annotation_target}/delete-all` | `delete any annotation` | `AnnotationDeleteAllForm` |
| `entity.annotation.delete_multiple_form` | `/…/delete` | `delete any annotation` | core `DeleteMultipleForm` |

## Access details

- `createAccess(string $type_id)` → `edit any annotation` OR `edit {type_id} annotations` (`cachePerPermissions`). Mirrors `AnnotationAccessControlHandler::checkCreateAccess`.
- Landing/add pages filter the visible annotation types to those the user may edit (`loadAnnotationTypes()`; `edit any annotation` supersedes per-type). Operation links per row are additionally filtered with `$url->access()` since hand-built links aren't auto-access-checked.
- `createAnnotationForm()` throws `NotFoundHttpException` for an unknown type or a field not in the target's scope; if the (target,field,type) slot already has an annotation it redirects to that annotation's `edit-form` (prevents duplicate slots). `field_name` `_overview` → DB sentinel `''`.

## Forms (`src/Form/`)

- `AnnotationEditForm` — the annotation entity edit form; shows author/created/changed as `#markup` (escaped), a moderation state or Published checkbox, and the value + revision log textareas.
- `AnnotationDeleteForm` — single-entity delete confirm.
- `AnnotationDeleteAllForm` — deletes every annotation for one target (uses `AnnotationStorageService::getEntitiesForTarget`).

## Revision history & diff

`AnnotationsUiRouteSubscriber::alterRoutes()` repoints `entity.annotation.version_history` to `AnnotationVersionHistoryController::__invoke`. That controller preloads revision IDs in `revisionOverview()` and, when the `diff` module is enabled, adds a "Compare with previous" operation link to `entity.annotation.revisions_diff` (registered by `DiffRouteProvider` via `AnnotationsUiHooks::entityTypeAlter`). Gated by `view annotation revisions`.

## Hooks (`src/Hook/AnnotationsUiHooks.php`)

Registers annotation entity link templates and route/list-builder providers, handles revision-operation access via `hook_entity_access`, and purges non-current `content_moderation_state` records on annotation delete (core-bug workaround, matching `annotations.install`).

## Config

`annotations_ui.settings`: `show_target_details` (bool, TRUE) — the collapsible field-scope panel on the add page; `show_field_metadata` (bool, TRUE). `FullyValidatable`, schema in `config/schema/annotations_ui.schema.yml`.
