<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Edit Action lets you edit multiple pieces of content at the same time.

---

Node Edit Action provides a **bulk action to edit multiple nodes at once** — applying field changes to
several selected nodes together (e.g. from a content view), for efficient batch editing. It depends on core Node,
in the Content package.

Use it to bulk-edit content. It is a content-editing feature and it is **access-correct**: the action checks
`$node->access('update', $account, TRUE)` on each node before editing it, so it only edits nodes the operator is
actually allowed to update (it doesn't bypass entity access). Use it from a content listing/VBO. It has no
access-control role of its own. Apply the bulk edit.

---

- Bulk-edit multiple nodes.
- Apply changes to several nodes.
- Batch-edit content efficiently.
- Depend on core Node.
- Serve content editing.
- Run from a content listing.
- CHECK $node->access('update') per node.
- Only edit nodes the operator may update.
- Not bypass entity access.
- Have no access-control role of its own.
- Apply the bulk edit.
- Handle bulk editing.
- Edit nodes.
- Configure the action.
- Batch-edit nodes.
- Handle the action.
- Edit content.
- Bulk-update nodes.
- Respect update access.
- Provide bulk node editing.
