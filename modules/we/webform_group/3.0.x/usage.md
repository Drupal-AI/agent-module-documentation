Webform Group integrates the Webform and Group modules so that access to a webform (attached to a group node) and its submissions can be granted by **group role** rather than only by global site role, and so email handlers can send to group members by role via tokens.

---

The module layers group-role-based access on top of Webform's existing access-rules system for webforms that are placed on group content (a `webform_node` related to a group via `gnode`). It adds a `webform_group_roles` form element and injects a "Group roles" selector into every permission row of the webform *Settings → Access* form (view/update/delete/purge any/own submissions, plus an "Administer submissions (Groups only)" section) and into per-element create/update/view access on the Webform UI element form. At runtime it implements `hook_webform_access()`, `hook_webform_submission_access()`, `hook_webform_element_access()` and `hook_webform_submission_query_access_alter()` to allow access when the current user's group roles (resolved from the group relationship of the webform's source entity, including implied outsider/insider/member roles) intersect the roles configured on the matching access rule. It also provides `webform_group` **tokens** (`[webform_group:role:*]`, `[webform_group:owner:mail]`) that resolve to the email addresses of group members holding a given role, usable only in a Webform email handler's To/CC/BCC — gated by a site-wide allowlist configured on the Webform email-handler settings form (`webform_group.settings`). The `WebformGroupManager` service centralizes group-relationship and group-role lookups. There are no module permissions of its own; it composes Webform's and Group's permission systems. A `webform_demo_group` submodule ships example group types and a demo webform.

---

- Let only members with a specific group role view a group webform's submissions.
- Restrict who can update or delete submissions on a group-attached webform by group role.
- Give a "manager" group role administer-submissions access without a global site permission.
- Separate "view any" vs "view own" submission access per group role.
- Add group-role access rules to individual webform elements (create/update/view).
- Warn editors when an element's user-role access (anonymous/authenticated) would bypass group roles.
- Email a webform submission's notification to all members of a group role via a token.
- Send webform emails to the group owner using `[webform_group:owner:mail]`.
- Use `[webform_group:role:editor]` to email everyone with the "editor" role in the current group.
- Restrict which group roles are offered as email recipients site-wide (email-handler settings).
- Build per-group questionnaires where each group's members answer independently.
- Scope submission list queries so users only see submissions for their group (query access alter).
- Combine group membership with Webform's own access rules for layered access control.
- Support membership-implied roles (outsider/insider/member) in access decisions.
- Provide contact/registration forms on group nodes answerable only by members.
- Let group admins receive email copies of every submission to their group's webform.
- Reuse one webform across many groups while keeping submissions and access group-scoped.
- Prototype the integration quickly with the bundled `webform_demo_group` example.
