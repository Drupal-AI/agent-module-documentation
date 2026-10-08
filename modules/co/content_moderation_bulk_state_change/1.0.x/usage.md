<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Moderation Bulk State Change provides a Views bulk action to update the content-moderation state of multiple entities in one operation.

---

Content Moderation Bulk State Change adds a bulk operation for updating the moderation state of many
entities at once, on top of core Content Moderation and Workflows. Instead of transitioning each item
through its editorial states individually, an editor can select multiple entities (for example in a
content admin View) and move them to a target moderation state in a single action — useful for
publishing or archiving batches of content.

Use it where editorial teams work with content-moderation workflows and need to process content in
bulk. It targets **nodes**: an editor selects nodes in the content admin View, runs the "Change
workflow stage" action, and confirms one target moderation state on a dedicated confirm form. The
target-state dropdown lists the transitions defined from the selected content's current state, and
the selected nodes must all share the same workflow and current state. The bulk operation is gated
by the module's own `update entity moderation states in bulk` permission and is offered per node
according to that node's update access; a settings form
(`content_moderation_bulk_state_change.settings`) toggles whether each change creates a new
revision. It depends on core `workflows` and `content_moderation`.

---

- Bulk-change moderation state of many entities.
- Publish a batch of content at once.
- Archive multiple items in one action.
- Add a bulk action for moderation states.
- Select entities and move them to a state.
- Work with content-moderation workflows in bulk.
- List transitions available from the current state.
- Require selected nodes to share workflow and state.
- Configure at content_moderation_bulk_state_change.settings.
- Provide permissions for the bulk action.
- Depend on workflows and content_moderation.
- Speed up editorial batch processing.
- Transition content admin View selections.
- Move drafts to published in bulk.
- Avoid per-item state changes.
- Govern the action via settings.
- Optionally create a new revision per change.
- Integrate with the content admin View.
- Update moderation state for selected nodes.
- Batch editorial state changes.
