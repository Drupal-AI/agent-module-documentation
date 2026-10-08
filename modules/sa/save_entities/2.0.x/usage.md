<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Save Entities provides a form to save (re-save) nodes and media of certain types, triggering their save hooks.

---

Save Entities provides an administrative form to save (re-save) nodes and media of selected types in
bulk — re-saving entities triggers their save hooks/pipelines (useful for re-generating derived data,
re-running processors, or applying a change that takes effect on save across many entities). It is
configured at `save_entities.node_form` and provides its own permissions.

Use it as a maintenance tool to re-save entities (e.g. after adding a field or a processor that runs on
save). It is an administration/maintenance feature that acts on content in bulk; because re-saving runs the
full save pipeline and can create revisions, restrict it to trusted administrators and use it deliberately
(bulk re-saving many entities has performance impact and side effects). It acts with the operator's
privileges and has no access-control role. Configure which types to re-save.

---

- Bulk-save nodes and media.
- Re-save entities of certain types.
- Trigger save hooks in bulk.
- Re-generate derived data.
- Re-run processors on save.
- Configure at save_entities.node_form.
- Provide its own permissions.
- Use as a maintenance tool.
- Restrict to trusted admins.
- Use deliberately (side effects).
- Mind performance of bulk re-save.
- Act with the operator's privileges.
- Have no access-control role.
- Create revisions on re-save.
- Apply save-time changes.
- Re-save after adding a field.
- Configure which types to save.
- Run the full save pipeline.
- Bulk re-process entities.
- Re-save content.
