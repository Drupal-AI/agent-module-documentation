<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations Type UI (annotations_type_ui) — agent index

Admin CRUD UI for `annotation_type` config entities (the bundles of `annotation`). Depends on `annotations`. Optional/uninstallable once types exist. `configure: entity.annotation_type.collection`.

## Provides

- **Hooks** `annotations_type_ui.hooks` (`AnnotationsTypeUiHooks::entityTypeAlter`) — registers `annotation_type` form handlers (`add`/`edit`/`delete`), the list builder, route provider, and link templates.
- **Forms** (`src/Form/`): `AnnotationTypeForm` (add/edit), `AnnotationTypeDeleteForm` (confirm; deleting a type deletes all its annotations).
- **List builder** `AnnotationTypeListBuilder` — draggable, weight-ordered collection.
- **Links**: action (`add_form`), menu, and task links for the type collection.

## Notes for agents

- All routes use the base module's `administer annotation types` permission (declared via the `annotation_type` entity's `admin_permission`). No new permissions/config/schema.
- The add/edit form is where other submodules attach per-type third-party settings (e.g. annotations_context `in_ai_context`, annotations_audit `affects_coverage`).
