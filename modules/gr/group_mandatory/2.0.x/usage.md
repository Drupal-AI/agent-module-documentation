<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Mandatory lets you mark a Group relationship (content) type as "mandatory", so that entities of that bundle can only be created through a group and not as standalone content.

On a group relationship type's config form it adds a **Mandatory** third-party setting (`group_mandatory:mandatory`). When set, the module (via the `route_override` service, tag `route_override`) overrides the standard entity create-form route for that bundle: instead of the normal add form, `GroupMandatoryRouteOverrideController` runs. Its `boolAccess()` grants access only if the current user has entity-create access in at least one relevant group (checked with Group's per-plugin access control handler and the `user.group_permissions` cache context), and `build()` renders a list of links to create the content inside each group the user is allowed to, or the message "You must be member of a group to do this." when none qualify.

Because the gate is implemented as a route access/override check evaluated server-side (not just a hidden UI element), a user who is not a member of a suitable group cannot reach the standalone create form for a mandatory bundle. It relies entirely on Group's own access handlers for the per-group create decision. It adds no permissions or config forms of its own beyond the third-party checkbox; requires Group and Route Override. A bundled `group_mandatory_test` submodule exists only for tests.
---
Force content of configured bundles to be created inside a Group by overriding the create-form route with an access-checked group picker.
---
- Require a content type to always belong to a group
- Mark a group relationship type as mandatory
- Block standalone creation of group-only content
- Redirect the create form to a group-scoped picker
- Show only groups where the user may create the content
- Deny the create form to users in no eligible group
- Display "you must be a member of a group" when blocked
- Enforce group membership server-side via route access
- Reuse Group's per-plugin entity-create access checks
- Vary access by the user's group permissions
- Configure mandatory via a per-type third-party setting
- Support Group 2.x and 3.x relationship entity names
- Keep content out of the site-wide unaffiliated pool
- Combine with Group roles and permissions
- List create links across all eligible groups
- Apply to any entity type plugged into Group as content
