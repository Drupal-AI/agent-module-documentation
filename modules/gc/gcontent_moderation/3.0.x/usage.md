<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Content Moderation bridges core Content Moderation with the Group module so that a group member's **group permissions** decide which moderation-state transitions they may perform and whether they can view pending (latest) revisions of group content.

---

Out of the box, core Content Moderation checks a user's *global* permissions to decide which workflow transitions they can apply and whether they can see the latest unpublished revision. This module makes those checks **group-aware** by decorating two core services in a `ServiceProvider` (decorating optional services can't be done with a normal service declaration): `content_moderation.state_transition_validation` is replaced by `GroupStateTransitionValidation`, and the `access_check.latest_revision` route access check is replaced by `LatestRevisionCheck`. The decorated transition validator additionally consults the current group (from the route, incl. the group-content wizard for new entities) and the member's group permissions of the form `use <workflow_id> transition <transition_id>`; these permissions are generated dynamically for **every** content_moderation workflow/transition by `GroupContentModerationPermissions` (declared via `permission_callbacks` in `gcontent_moderation.group.permissions.yml`), alongside a static **"view latest version"** group permission. The decorated latest-revision check ORs the core result with group access so a member can reach `/…/latest-version` for content in their group. The module also ships an optional View, **"Moderated group content"** (`moderated_group_content`), providing a per-group moderation queue at `group/%group/moderated` gated by the "view latest version" group permission, plus a Views filter `group_content_respect_unpublished` that respects own/any unpublished permissions for group node revisions. There is no settings form (`configure: null`); you set it up by configuring your content-moderation workflow and granting the new group permissions to group roles.

---

- Let group editors transition their group's content through a moderation workflow (Draft → Published) based on group role, not global permissions.
- Grant a specific group role permission to use only certain workflow transitions (e.g. "Publish") within their group.
- Allow group members to view pending/draft (latest) revisions of content in their own group.
- Provide each group with its own moderation queue at `group/%group/moderated`.
- Keep site-wide moderators and per-group moderators cleanly separated.
- Enforce that a group member can only publish content belonging to their group.
- Use the "view latest version" group permission to expose the latest-version tab to members.
- Filter a group's node revisions to respect own/any unpublished permissions via the provided Views filter.
- Delegate editorial control of a multi-tenant site to group-level roles.
- Support the group-content creation wizard so transitions work on brand-new group entities.
- Build a departmental publishing workflow where each department is a Group.
- Give community moderators transition rights scoped to their community group.
- Combine core Editorial workflow with Group memberships without custom access code.
- Show a "Moderated content" tab in the group menu for reviewing drafts.
- Restrict who can move content to "Archived" per group via transition permissions.
- Let organic-team leads approve their team's content only.
- Generate transition permissions automatically for any custom content-moderation workflow.
- Avoid granting site-wide "use editorial transition publish" by scoping it to groups.
- Provide granular, per-transition, per-workflow group permissions for reviewers.
- Integrate group-based access grants with content moderation's latest-revision routing.
