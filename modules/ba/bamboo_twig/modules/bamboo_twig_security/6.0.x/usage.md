<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bamboo Twig - Security adds Twig functions to check whether the current or a given user has a permission or role, individually or as an AND/OR collection.

---

This submodule of Bamboo Twig registers four functions on the service `bamboo_twig_security.twig.security` (constructed with the current user and entity type manager): `bamboo_has_permission(permission, user)`, `bamboo_has_permissions(permissions, conjunction, user)`, `bamboo_has_role(role, user)`, and `bamboo_has_roles(roles, conjunction, user)`. When the user argument is omitted the current user is used; for anonymous or non-existent users the functions return `null` (falsy). The collection variants accept an `'AND'` or `'OR'` conjunction (any other value throws). These enable per-user, permission- and role-aware rendering directly in templates.

---

- Show an admin link only to users with `access administration pages`.
- Hide an edit button unless the user has the right permission.
- Render editor-only markup for users in an `editor` role.
- Gate a call-to-action behind `bamboo_has_role('subscriber')`.
- Show content when a user has any of several roles (`'OR'` conjunction).
- Require all of several permissions before rendering a section (`'AND'`).
- Check a specific user by uid (e.g. an author) rather than the current user.
- Display a "you may moderate this" note based on a moderation permission.
- Conditionally include a debug panel for administrators only.
- Vary a template between authenticated and privileged users.
- Show premium content only to members with the appropriate role.
- Render a role badge when a user holds a given role.
- Combine role and permission checks in one `{% if %}`.
- Hide personalization widgets from anonymous users.
- Gate a form embed behind a create permission.
- Provide role-aware navigation entries in a menu template.
- Show a downgrade/upgrade prompt based on role membership.
- Keep authorization-aware presentation logic in the template layer.
