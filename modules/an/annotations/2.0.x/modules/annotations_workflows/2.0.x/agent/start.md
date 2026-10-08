<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations Workflows (annotations_workflows) — agent index

Attaches a content-moderation workflow to the `annotation` entity. Depends on `annotations`, `annotations_ui`, `content_moderation`, `workflows`.

## Provides

- **Config (install)** `workflows.workflow.annotations` — the moderation workflow applied to `annotation`.
- **Hooks** `annotations_workflows.hooks` (`AnnotationsWorkflowHooks`, arg `@entity_type.manager`):
  - `annotation_type_insert` → adds the new type (bundle) to the `annotations` workflow.
  - `annotation_type_delete` → removes the type from the workflow.
- **Install** `annotations_workflows_install()` — adds all existing annotation types to the `annotations` workflow (new types handled by the insert hook).

## Notes for agents

- With the workflow attached, core `ModerationHandler` sets `annotation.status` from the moderation state (no annotations-specific code). Consumers call `AnnotationStorageService::getForTarget($id, TRUE)` (published/default revision); editing UIs use `getLatestForTarget()` to show drafts.
- No routes/permissions of its own — moderation permissions come from content_moderation. `annotations.install` cleans up orphan `content_moderation_state` rows on annotation delete/uninstall.
