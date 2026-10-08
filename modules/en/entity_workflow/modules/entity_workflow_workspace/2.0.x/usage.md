Entity Workflow Workspace gives the whole workspace its own Draft → Review → Approved → Published workflow, where publishing the workspace and reverting it are workflow transitions.

---

This submodule of Entity Workflow provides the `entity_workflow_workspace` WorkflowType plugin and installs a `workspace` workflow config entity with four states (Draft, Ready for Review, Approved, Published). Each state carries a `locked` flag and an open/closed `status`; approved and published states are locked so their content can no longer be edited, and the published state closes the workspace. The "Publish" transition triggers the WSE workspace publish, "Unpublish" reverts the last-published workspace, and the workspace's state is driven automatically to the lowest state of its content. Per-transition permissions are enforced through the workspace entity access handler (`hook_ENTITY_TYPE_access`), which also blocks publishing until every tracked entity is approved, blocks transitions on empty workspaces, and restricts unpublish to the most recently published workspace. A validation constraint prevents editing content in a locked workspace, and the workspace view/list is customised to show the state and switcher.

---

- Give an entire workspace a Draft → Review → Approved → Published lifecycle.
- Publish a workspace to the live site by running its "Publish" workflow transition.
- Revert (unpublish) the most recently published workspace through the "Unpublish" transition.
- Automatically move a workspace to the lowest workflow state of the content it contains.
- Lock a workspace's content from further edits once it reaches Approved or Published.
- Mark a workspace open or closed automatically based on its workflow state.
- Only allow publishing once every tracked entity in the workspace is in the Approved state.
- Restrict which roles may Submit for Review, Approve, Publish or Unpublish a workspace.
- Grant a trusted role every workspace transition at once, or the "Can always publish workspaces" override.
- Prevent transitions (other than new draft/unpublish) on an empty workspace.
- Restrict unpublish to the workspace that published last, matching WSE's revert rules.
- Embed the WSE workspace publish form into the workflow form when running the Publish transition.
- Show the current workspace state on the workspace page and in the workspace list.
- Configure each state's locked flag and open/closed status through the core Workflows state form.
- Keep the workspace status field in sync when transitions run outside the workflow (cron, deploy).
