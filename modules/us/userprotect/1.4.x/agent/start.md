# userprotect — agent start

Protects user accounts and fields from being edited/cancelled/role-changed by other users.
A `userprotect_rule` config entity targets one user or a whole role and enables protections
(name, mail, pass, status, roles, edit, delete) drawn from the `user_protection` plugin type.
Enforced via user entity access + field access hooks. Depends on core `user`.
Config UI: **Admin → Config → People → User protect** (`/admin/config/people/userprotect`);
route `userprotect.rule_list`.

- Create/manage protection rules + settings → [configure/rules.md](configure/rules.md)
- The `user_protection` plugin type + how to add a protection → [plugins/plugins.md](plugins/plugins.md)
- Permissions (administer, bypass, self-edit) → [permissions/permissions.md](permissions/permissions.md)
