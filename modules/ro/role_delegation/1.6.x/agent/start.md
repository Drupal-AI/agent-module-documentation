# role_delegation — agent start

Grants fine-grained "assign {role} role" permissions so non-admins can manage a limited set of
user roles without `administer permissions`. Adds a **Roles** form per user
(`/user/{user}/roles`, route `role_delegation.edit_form`) and injects assignable-role
checkboxes into the user add/edit form. Depends on core `user`. No admin config page.

- Permissions (`assign all roles` + per-role) → [permissions/permissions.md](permissions/permissions.md)
- Filter assignable roles in code (alter hook) → [hooks/hooks.md](hooks/hooks.md)
- `delegatable_roles` service + access check → [api/services.md](api/services.md)
