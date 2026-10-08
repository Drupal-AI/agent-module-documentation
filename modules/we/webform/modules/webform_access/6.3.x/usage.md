Webform Access adds group-based access control to webform nodes, letting you grant specific users or roles rights to view, edit, or manage the submissions of particular webform-enabled content.

---

Core webform permissions are global (any/own), which is too coarse when many departments or clients each own their own forms. Webform Access solves this with two config-driven concepts: **access types** (categories such as "Region" or "Department") and **access groups** (`webform_access_group` config entities) that bundle together a set of users, a set of webform node "sources", and the permissions those users get over the matching submissions. When a webform node's submission is created, membership in an access group determines who may view/update/delete/administer it, independent of the global webform permissions. Administrators manage access types and groups under Structure → Webforms → Access, and a block is provided to surface access-group context. This is the standard pattern for multi-tenant webform setups where each team should only see its own responses. It requires the `webform_node` submodule since access is keyed to nodes.

---

- Give each regional office access to only its own contact-form submissions.
- Let a department's staff view and edit responses for their forms but no others.
- Model multi-tenant webforms where clients see only their own data.
- Create an "access type" taxonomy such as Region, Team, or Product line.
- Bundle a set of users into an access group with view-only rights.
- Grant a group edit/delete rights over the submissions it owns.
- Assign multiple webform nodes as the "sources" of one access group.
- Delegate submission administration without granting site-wide webform admin.
- Restrict who can export a given form's results by group membership.
- Separate staging/production form owners by access group.
- Provide franchisees access to their location's enquiry forms.
- Route submission review to the correct team automatically by node.
- Combine with core roles to layer group access on top of role permissions.
- Display an access-group context block on webform node pages.
- Manage access groups as exportable configuration for deployment.
- Give volunteers scoped access to event-registration submissions.
- Let a client edit their own leads while support keeps global oversight.
- Onboard a new team by adding them to an existing access group.
- Revoke a user's submission access by removing them from the group.
- Keep sensitive submissions visible only to a named group of staff.
