Entity Workflow Content ships a ready-made Draft → Ready for Review → Approved workflow for content entities (nodes and other workspace-supported types) editing inside a Drupal workspace.

---

This submodule of Entity Workflow provides the `entity_workflow_content` WorkflowType plugin and installs a `content` workflow config entity with three states (Draft, Ready for Review, Approved) and the transitions between them (New draft, Submit for Review, Approve, Back to Draft, Approve immediately). It generates per-transition permissions (for example "Use Submit for Review transition" and "Use all content transitions"), enforces them through the `entity_workflow_content_transition_access` access callback, and multiplexes optional extra access callbacks such as "Approve immediately" only showing when the normal "Approve" step is unavailable. When content transitions it cascades related entities (path aliases, node menu links) and drives the workspace's own workflow to the lowest state of its contents. It requires an active workspace for content operations (via a route enhancer and workspace switcher), with an optional exclusion list to let some entity types/bundles keep working on the live site.

---

- Install a working editorial workflow for nodes with one module enable, no manual state/transition setup.
- Move a node through Draft, Ready for Review and Approved inside a workspace.
- Let reviewers Approve or send content Back to Draft with an action link on the node page.
- Require a log message when using the "Approve immediately" shortcut.
- Show "Approve immediately" only to users for whom the normal "Approve" transition is not available.
- Restrict who can perform each transition using generated per-transition permissions.
- Grant a trusted role every content transition at once with "Use all content transitions".
- Automatically roll the workspace's state up to the lowest state of the content it tracks.
- Cascade a content transition to the node's path alias and menu link so they move together.
- Apply the content workflow to any entity type that Workspaces supports, not just nodes.
- Force editors into a workspace before creating or editing content, via the workspace switcher screen.
- Exclude specific entity types or bundles from the workspace requirement so they stay editable on Live.
- Hide Views bulk operations on entity lists when no workspace is active.
- Bulk-transition many tracked content items in a workspace at once.
- Record every content state change in the transition history log with author and timestamp.
