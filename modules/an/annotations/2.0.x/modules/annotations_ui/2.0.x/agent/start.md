<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations UI (annotations_ui) — agent index

Core management UI for the Annotations suite. Depends on `annotations` + core `views`; suggests `diff`. Provides the annotate/add/edit/delete pages and annotation revision history. See [routes.md](routes.md) for full route/permission/form detail.

## Provides

- **Routes** (`annotations_ui.routing.yml`, all under `/admin/content/annotations`, `_admin_route`):
  - `annotations_ui.annotate.collection` `/…` — landing list (`access annotation collection`).
  - `annotations_ui.target.collection` `/…/{annotation_target}` — embeds the `annotations_target` view (`access annotation collection`).
  - `annotations_ui.target.add` `/…/{annotation_target}/add` — empty-slot table (`access annotation collection`).
  - `annotations_ui.target.create` `/…/{annotation_target}/add/{field_name}/{type_id}` — prefilled `AnnotationEditForm` (`_custom_access: AnnotationController::createAccess`).
  - `annotations_ui.target.delete_all` `/…/{annotation_target}/delete-all` (`delete any annotation`).
  - `entity.annotation.delete_multiple_form` `/…/delete` (`delete any annotation`).
- **Controllers** (`src/Controller/`): `AnnotationController` (page/addPage/createAnnotationForm/createAccess); `AnnotationVersionHistoryController` extends core `VersionHistoryController` to add diff links.
- **Forms** (`src/Form/`): `AnnotationEditForm`, `AnnotationDeleteForm`, `AnnotationDeleteAllForm`.
- **Route subscriber** `AnnotationsUiRouteSubscriber` — swaps the controller on `entity.annotation.version_history`.
- **Hooks** `AnnotationsUiHooks` — registers entity link templates/route providers, revision `hook_entity_access`, and the moderation-state orphan cleanup on entity delete.
- **Permission**: `view annotation revisions`. **Config**: `annotations_ui.settings` (`show_target_details`, `show_field_metadata`; schema in `config/schema/`). **View**: `views.view.annotations_target`. **Action**: `system.action.annotation_delete_action`.

## Notes for agents

- Access is enforced by the base `AnnotationAccessControlHandler` + these route permissions; hand-built operation links are access-filtered per row (`$link['url']->access()`). Creating a slot that already exists redirects to the existing annotation's edit form.
- `field_name` route value `_overview` maps to the DB `''` sentinel (bundle-level annotation).
