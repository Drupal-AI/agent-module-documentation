<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Annotations UI is the core management interface for the Annotations suite: it turns the base module's entities into an annotate/edit workflow under Content.

---

Annotations UI adds the human-facing annotation management pages that the base `annotations` module deliberately omits. Under `/admin/content/annotations` it lists every opted-in `annotation_target` grouped by entity type, each with Add / Edit / Delete operations; the add page shows a table of empty annotation slots (overview + per-field) with inline "Add {type}" links; the edit page embeds the `annotations_target` view; and creating a slot opens `AnnotationEditForm` prefilled for that target/field/type. It also provides the annotation delete form, a per-target delete-all confirm form, core's delete-multiple form, and an annotation revision-history controller that adds a "Compare with previous" link when the diff module is present (registered by altering `entity.annotation.version_history`). Access follows the base permission model — `access annotation collection` to browse, `edit any annotation` / `edit {type} annotations` to create/edit, `delete any annotation` to delete, and `view annotation revisions` for history. Depends on `annotations` and core Views; suggests diff.

---

- Browse all opted-in annotation targets grouped by entity type.
- Add annotations for a target's overview or individual fields.
- See at a glance which annotation type slots are still empty for a target.
- Open a prefilled edit form to write a new annotation of a chosen type.
- Edit existing annotations via the embedded target view.
- Delete a single annotation with a confirm form.
- Bulk-delete every annotation for one target (delete-all confirm form).
- Delete multiple annotations via core's delete-multiple form.
- View the full revision history of an annotation.
- Compare an annotation revision with the previous one (with the diff module).
- Gate browsing behind `access annotation collection`.
- Gate creation/editing behind `edit any` or per-type `edit {type} annotations`.
- Gate deletion behind `delete any annotation`.
- Gate revision history behind `view annotation revisions`.
- Show an optional "target details" panel listing all fields and their scope status.
- Guide site builders with contextual empty-state messages (no types / no targets).
- Register the annotation edit-form link template used by overlay create links.
- Handle revision-specific access (revert/delete-revision) via `hook_entity_access`.
