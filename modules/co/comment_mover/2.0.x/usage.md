<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Comment Mover lets administrators relocate comments (and their reply threads) from one node to another using a clipboard metaphor, and convert between nodes and comments.

---

A `CommentMoverController` exposes `/comment_mover/cut/{entity_type}/{entity_id}` and `/comment_mover/paste/{entity_type}/{entity_id}`, both requiring the core `administer comments` permission. "Cut" stores the selected entity on the private tempstore clipboard (`comment_mover.clipboard`), "paste" re-parents the clipboard's comments under the target entity via the `comment_mover.mover` service, invalidating cache tags. A `CommentMoverBlock` provides the clipboard UI/form. The module can also convert a node into a comment and vice-versa (`CutEntity`, `CommentMover`).

---
- Move a comment from one node to another
- Move a whole reply thread between nodes
- Cut a comment to the clipboard
- Paste clipboard comments under a target node
- Convert a node into a comment
- Convert a comment into a node
- Place the clipboard block for editors
- Re-parent misfiled forum replies
- Consolidate duplicate discussion threads
- Split a thread onto a new node
- Reassign comments after merging content
- Invalidate caches automatically after a move
- Restrict the tool to users with `administer comments`
- Tidy up a forum by relocating off-topic comments
- Use the clipboard block to stage a move
- Invalidate the affected nodes' caches after pasting
- Move a comment and keep its child replies together
- Preserve comment authorship when re-parenting
- Return to a chosen destination after cut/paste