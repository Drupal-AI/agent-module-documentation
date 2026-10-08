<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Recursive Delete (err_delete) adds an alternative "recursive delete" button to node edit forms that lets you delete a node together with the entities it references.

---

Entity Reference Recursive Delete adds a new operation for nodes that have `entity_reference` or `entity_reference_revisions` fields. When such a node is edited, the module places a "Recursive Delete" link at the bottom of the edit form (and can optionally hide core's normal Delete button). Following the link opens a form that walks the node's reference fields and lists every referenced entity, nesting into their own references, with a checkbox beside each item. Ticking a box marks that referenced entity for permanent deletion alongside the parent node; leaving it unticked keeps the referenced entity in place. Circular references are detected and shown but not offered for deletion. On submit the checked referenced entities are deleted and then the node itself is deleted, redirecting to `/admin/content`. It depends only on core Node, provides one permission (`err delete entities`), and has a small settings form for the button label and whether to hide the standard delete button.

---

- Delete a node and its Paragraphs (entity_reference_revisions) items in one flow.
- Clean up composite content that references other entities on deletion.
- Recursively remove nested referenced entities several levels deep.
- Selectively choose, per referenced item, whether it is deleted or kept.
- Keep shared referenced entities that are used elsewhere while deleting the node.
- Purge an entire content tree (node plus all its unique references) at once.
- Detect and skip circular references so a shared item is not double-deleted.
- Add a "Recursive Delete" action only to nodes that actually have reference fields.
- Replace core's standard node Delete button with the recursive delete flow.
- Rename the recursive delete button to match your site's wording.
- Translate the delete button label through the configuration form.
- Restrict who can perform recursive deletes with the `err delete entities` permission.
- Delete referenced media, taxonomy terms, or other nodes referenced by a node.
- Review a node's full reference graph before deciding what to remove.
- Reduce orphaned referenced content left behind after deleting a parent node.
- Give editors a one-step cleanup for large Paragraph-based landing pages.
- Remove a campaign/landing node and all its bespoke referenced components together.
- Avoid manually visiting and deleting each referenced entity by hand.
- Keep referenced user entities safe (the form never offers user references for deletion).
- Configure the module at Configuration -> Content authoring -> ERR Delete settings.
- Confirm exactly which referenced items will be permanently removed before submitting.
- Offer both the normal delete and the recursive delete side by side when the standard button is left visible.
