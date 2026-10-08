<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Annotations Workflows attaches a content-moderation workflow to annotations so they move through editorial states.

---

Annotations Workflows adds editorial moderation to the annotation entity. It ships a `workflows.workflow.annotations` config entity and attaches it to the `annotation` entity type per annotation type (bundle): on install it adds every existing annotation type to the workflow, and `AnnotationsWorkflowHooks` keeps that in sync — `hook_annotation_type_insert` adds a new type, `hook_annotation_type_delete` removes one. With the workflow attached, an annotation's published status follows its moderation state (published states set status = 1), so consumer contexts (overlay, context assembly, reports, exports) surface only published annotations while editors keep working on drafts via the latest-revision editing paths. Requires `annotations`, `annotations_ui`, `content_moderation`, and `workflows`.

---

- Attach a content-moderation workflow to annotations.
- Move annotations through editorial states (e.g. draft/published).
- Ship a ready-made `annotations` workflow config.
- Add every annotation type to the workflow on install.
- Add new annotation types to the workflow automatically (hook_insert).
- Remove annotation types from the workflow on deletion (hook_delete).
- Drive annotation publish status from the moderation state.
- Show only published annotations to consumers (overlay/context/reports).
- Let editors keep unpublished drafts while a published version is live.
- Track per-revision editors and revision log messages.
- Integrate with core content_moderation state transitions.
- Use annotation revisions as the moderation history.
- Keep the workflow attachment config-managed.
- Support moderated editorial review of site documentation.
- Complement annotations_ui's revision history/diff.
- Require no custom code to moderate annotations.
