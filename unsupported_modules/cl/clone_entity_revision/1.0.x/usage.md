<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Clone Entity Revision lets editors duplicate a chosen node revision into a brand-new node.

---

Clone Entity Revision allows you to clone a specific node revision into a new node — so instead of only duplicating a node's current state, an editor can pick any historical revision and create a fresh node from it, useful for reverting-by-copy, branching content, or recovering an older version as a new page.

The clone deep-copies referenced paragraphs and makes independent copies of file/image fields. It declares core `node` and `content_moderation` as dependencies (both must be enabled), though the module itself contains no moderation-specific code — the new node simply carries over the revision's field values. Supports Drupal 10 and 11.

---

- Clone a specific node revision.
- Create a new node from any revision.
- Support revert-by-copy.
- Branch content from history.
- Recover an older version as a new node.
- Integrate with Content Moderation.
- Start the clone in a moderation state.
- Depend on core `node` and `content_moderation`.
- Support Drupal 10 and 11.
- Pick a historical revision.
- Duplicate content.
- Aid editors.
- Clone revisions
- Handle node copies
- Support workflows.
- Copy a revision.
- Create new nodes.
- Manage revisions
