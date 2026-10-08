Entity Workflow gives each content entity its own state-transition workflow while it lives inside a Drupal Workspace, so editorial changes move through Draft → Review → Approved before the whole workspace is published.

---

Entity Workflow builds on core Workflows and the Workspaces (WSE) module. Instead of one moderation state per entity, it lets a single Workspace carry many entities that each advance through a workflow independently; the workspace itself has its own workflow that rolls up to the "lowest" state of its contents and controls publishing. It ships two submodules that provide ready-made workflows: `entity_workflow_content` (a Draft/Review/Approved workflow for content entities such as nodes) and `entity_workflow_workspace` (a Draft/Review/Approved/Published workflow whose "Publish" transition publishes the workspace and whose "Unpublish" reverts it). The base module adds an `entity_workflow_state` base field per workflow, per-transition access callbacks and permissions, transition events (initiate/pre/post), a `workflow_transition_log` history entity with a Views display, workflow tabs, per-transition action links, and single-entity and bulk transition forms. Workflows are configured through the standard core Workflows admin UI; developers drive transitions programmatically with `entity_workflow_transition()` and the transition events.

---

- Give each node in a workspace its own editorial state (Draft, Ready for Review, Approved) instead of a single site-wide moderation state.
- Let multiple editors work in one workspace where each piece of content is at a different stage of review.
- Roll a workspace's own state up automatically to the lowest state of everything it contains.
- Publish an entire workspace to the live site through a "Publish" workflow transition once its content is approved.
- Unpublish/revert a previously published workspace through an "Unpublish" transition.
- Add a per-entity "Workflow" tab and inline action links (Submit for Review, Approve, Back to Draft) on entity canonical pages.
- Require a log message on selected transitions (for example "Approve immediately") and record it in the transition history.
- Show a per-entity transition history (who changed state, when, and the log message) via the bundled `workflow_transition_log` View.
- Bulk-transition many tracked entities in a workspace at once through the bulk workflow form.
- Restrict which roles may perform which transition using generated permissions such as "Use Submit for Review transition" or "Use all content transitions".
- Attach a workflow to specific entity types and bundles (nodes by default; any workspace-supported entity type is possible).
- Set an initial/default state for new entities entering a workflow, optionally via a default-state callback.
- React to state changes in custom code with the pre-transition and post-transition events (for example send a notification when content is approved).
- Cascade a transition to related entities such as a node's path alias and menu link so they move state together.
- Provide a custom access callback per transition to add business rules on top of the permission check.
- Prevent editing of a workspace's content while it is in a locked or closed state.
- Keep the workspace status (open/closed) in sync with its workflow state.
- Skip creating a new entity revision when only the workflow state changes.
- Add an "Approve immediately" shortcut transition that only appears when the normal "Approve" step is not available to the user.
- Enumerate or query the current workflow state of entities across a workspace from custom code or Views.
- Exclude selected entity types or bundles from the workspace requirement so they can still be edited on the live site.
- Build entirely custom workflows (states, transitions, access rules) for other entity types using the module's WorkflowType plugin base.
