Actions Permissions is a VBO submodule that generates one Drupal permission per action (per entity type) so administrators can allow or deny each bulk operation on a per-role basis.

---

By default any VBO action offered on a View is available to whoever can use the View. This submodule closes that gap: for every discovered action it dynamically creates a permission named `execute <action_id> <entity_type>` (or `execute <action_id> all` for actions that apply to all entity types), listed on `/admin/people/permissions`. It subscribes to VBO's action-definitions event and, at low priority, strips any action from the available list when the current user lacks the matching permission. Actions that already declare their own `requirements` are left untouched, so custom access rules still win. This lets you, for example, let editors bulk-publish but only allow admins to bulk-delete. Enabling it is all that's required — the permissions appear automatically and update as actions are added or removed. It has no configuration UI or settings of its own.

---

- Grant "bulk delete nodes" to admins but hide it from regular editors.
- Allow a role to bulk-publish content while denying bulk unpublish.
- Restrict the "cancel user" bulk action to user-administrator roles.
- Give each custom VBO action its own role-gated permission automatically.
- Separate permissions per entity type (delete nodes vs delete users).
- Expose a single "all entity types" permission for type-agnostic actions.
- Prevent lower-trust roles from seeing dangerous actions in the dropdown.
- Enforce least-privilege on bulk operations across a multi-role editorial team.
- Let a moderator role run only approve/reject bulk actions.
- Audit which roles can perform which bulk operations via the permissions page.
- Keep an action visible to code/Drush while hiding it from the UI for some roles.
- Combine with content-moderation workflows to gate state-changing bulk actions.
- Defer to an action's own `requirements` when it defines custom access.
- Roll out a new custom action and immediately control it per role.
- Comply with governance rules requiring explicit grants for mass changes.
- Limit destructive operations on production to a single admin role.
