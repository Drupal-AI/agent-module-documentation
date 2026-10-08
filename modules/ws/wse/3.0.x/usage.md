Workspaces Extra (wse) rounds out core Workspaces with the operations a real editorial-staging workflow needs: workspaces gain an open/closed status and close automatically on publish, a published workspace can be reverted as a unit, and individual content changes can be moved or discarded between workspaces. It adds clone-on-publish, revision squashing, a safe-forms allowlist so ordinary forms can submit inside a workspace, and a simplified toolbar switcher — plus submodules for deployment, scheduling, menus, Layout Builder, group access, task monitoring and pruning.

---

Core Workspaces lets a team stage a set of content changes and publish them together, but stops there. WSE supplies the surrounding machinery on the top-level module: a `status` base field marks each workspace open or closed (publishing closes it), `PublishedRevisionStorage` records what each publish changed so `WorkspaceReverter` can roll a closed workspace back through a UI form or `wse.workspace.pre_revert`/`post_revert` events, and per-entity "Move to another workspace" and "Discard changes" operations appear on the workspace change list. Publishing behaviour is configurable at `/admin/config/workflow/workspaces/settings` (`wse.settings`): squash intermediary revisions on publish (queued via the `wse_revision_cleaner` worker), clone the workspace into a fresh draft on publish, and choose whether all or only published revision IDs are stored. A safe-forms allowlist plus `WorkspaceSafeFormInterface` decides which forms may submit inside a workspace; everything else gets a "this will write to Live" confirmation. Optional integrations (diff, trash) enrich the change list and cron cleanup. It requires Drupal 11.3+/12 and, at 3.0.0-alpha5, has no stable release yet.

---

- Automatically close a workspace once its changes are published.
- Revert an entire already-published workspace back to its prior state.
- Move one entity's draft changes from one workspace to another.
- Discard a single entity's changes within a workspace.
- Clone a workspace's metadata into a new draft when it is published.
- Squash intermediary draft revisions when a workspace publishes to keep history lean.
- Delay revision squashing by a configurable number of hours.
- Store the exact revision IDs each publish changed for later rollback.
- Let editors choose per-publish whether to save all or only published revision IDs.
- Allow selected custom forms to submit inside a workspace without a Live warning.
- Warn editors before a non-workspace-safe form writes straight to Live.
- Show a read-only published/draft status badge on chosen entity types.
- Give reviewers a "View changes" diff link per tracked entity (with the diff module).
- Offer a "Switch to Live" block/link while browsing a workspace.
- Use a simplified, faster toolbar/navigation workspace switcher.
- Limit and age out the list of recently used workspaces.
- Disable confusing nested sub-workspaces site-wide.
- Block edits and publishing on a workspace that has already been published (closed).
- Append the active workspace to internal URLs for share/preview links.
- Deploy workspace content between environments (wse_deploy submodule).
- Schedule a workspace to publish at a chosen time (wse_scheduler submodule).
- Stage menu-link hierarchy changes inside a workspace (wse_menu submodule).
- Restrict which user groups may use a workspace (wse_group_access submodule).
- Monitor long-running workspace operations in real time (wse_task_monitor submodule).
- Prune and clean up old workspaces to control data growth (wse_prune submodule).
- Coordinate a multi-page seasonal content update and roll it out as one release.
- Reduce release-day risk by previewing and reverting a full change set.
