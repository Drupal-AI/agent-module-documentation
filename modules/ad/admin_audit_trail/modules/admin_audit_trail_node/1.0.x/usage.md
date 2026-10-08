Submodule of Admin Audit Trail that logs node (content) create, update, delete, and translation events into the audit trail under the `node` event type.

---

Part of `admin_audit_trail`. Enabling it registers the `node` event type via `hook_admin_audit_trail_handlers()` and implements `hook_node_insert/update/delete` plus translation insert/delete hooks, each calling `admin_audit_trail_insert()` with `type: node`, an `operation` (`insert`, `update`, `delete`, `translation insert`, `translation delete`), a description of `"%type: %title"`, and the node id in `ref_numeric` / title in `ref_char`. Because the base logger ignores CLI requests, rows are written for real web-form saves, not Drush node creation. View and filter these rows by the `Node` type at `/admin/reports/audit-trail`.

---

- Record every node created through the admin UI, with author, time, and title.
- Track content edits to see who last changed a given article or page.
- Log node deletions for accountability and recovery investigations.
- Capture translation add events on multilingual content.
- Capture translation delete events on multilingual content.
- Filter the audit report to the `node` type to review all content activity.
- Reference each entry back to its node via `ref_numeric` (node id).
- Provide a content-change trail for editorial compliance.
- Correlate node changes with the acting user recorded on each row.
- Correlate node changes with the client IP recorded on each row.
- See the content type and title inline in each log description.
- Answer "who deleted this article?" from the delete-operation rows.
- Audit high-value pages by keyword-searching the report descriptions.
- Feed a content-governance dashboard by querying the `node` type rows.
- Distinguish new content from edits using the `insert` vs `update` operations.
- Keep a lightweight change history without enabling full revision diffing.
- Combine with other submodules (user, taxonomy) for a full-site trail.
