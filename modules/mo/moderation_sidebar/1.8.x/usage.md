Moderation Sidebar adds a "Tasks" button to the Drupal toolbar that opens an off-canvas sidebar with quick Content Moderation actions (publish, create draft, view the latest/live version) for the entity you are viewing. It depends on core Content Moderation.

---

When viewing any moderated, revisionable entity on the front end, Moderation Sidebar's `hook_toolbar()` adds a "Tasks" toolbar tab whose label reflects the current moderation state (e.g. Published, Draft, "Draft available"). Clicking it AJAX-loads an off-canvas dialog (`core/drupal.dialog.off_canvas`) built by `ModerationSidebarController::sideBar()`, showing the entity's state, last revision author and time, and a set of action buttons. The primary actions include quick state-transition buttons rendered by `QuickTransitionForm` (only valid transitions for the current user, excluding self-transitions and any disabled in settings), a "Discard draft" button on pending revisions, plus contextual links to view the existing draft, view live content, edit, or delete. Secondary actions surface the node's recent revisions ("Show revisions"), a translate overview when Content Translation is enabled, and de-duplicated local task tabs for the entity. Each transition creates a new revision with an auto-generated (or custom) revision log message. Access is gated by the `use moderation sidebar` permission plus each entity's own access checks. A limited settings form (`/admin/config/user-interface/moderation-sidebar`, permission `administer moderation sidebar`) lets admins disable specific transitions per workflow. Developers can reshape the sidebar contents with `hook_moderation_sidebar_alter()`.

---

- Publish a draft node from the front end without opening the full edit form.
- Move content through a workflow (Draft → Needs Review → Published) with one-click transition buttons.
- See an entity's current moderation state at a glance from the toolbar tab label.
- View the latest pending draft of an entity that has a newer unpublished revision ("View existing draft").
- Jump from a pending draft back to the live/default published version ("View live content").
- Discard the current draft and revert to the live revision from the sidebar.
- Add a custom revision log message when performing a quick transition (toggle the log checkbox).
- Edit or delete the current entity via sidebar buttons that respect entity access.
- Show the last five recent revisions of a node inline in the off-canvas dialog.
- Open the translation overview and create/edit translations when Content Translation is enabled.
- Give editors a lightweight moderation UI on the canonical page instead of the admin content list.
- Restrict which users see moderation actions with the `use moderation sidebar` permission.
- Disable specific workflow transitions from appearing in the sidebar per workflow (settings form).
- Reopen the sidebar automatically after a Quick Edit save so state stays current.
- Provide moderation controls for any moderated content entity type, not just nodes.
- Surface de-duplicated local task tabs (entity operations) inside the sidebar.
- Let reviewers approve or reject content quickly while browsing the site front end.
- Show "Draft available" on published pages that have a newer pending revision.
- Add custom buttons or markup to the sidebar via `hook_moderation_sidebar_alter()`.
- Keep the moderation workflow accessible from the toolbar on every eligible page.
- Route quick transitions through core's state transition validation so only valid moves are offered.
- Display the revision author and a human-friendly "time ago" for the current revision.
- Give translators per-language "Create translation" / "View existing draft" buttons.
- Gate access to the settings form separately with `administer moderation sidebar`.
