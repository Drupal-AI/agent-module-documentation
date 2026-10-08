# field_permissions — agent start

Per-field create/edit/view access control. Set a **field permission type** (Public /
Private / Custom) on each field's settings form; Custom exposes a per-role permission grid.
Enforced via core `hook_entity_field_access`. Depends on core `field`.
Report: **Admin → Reports → Field list → Permissions** (`/admin/reports/fields/permissions`,
route `field_permissions.reports`).

- Set a field's permission type & the custom grid → [configure/field-permissions.md](configure/field-permissions.md)
- FieldPermissionType plugin type (add a strategy) → [plugins/field-permission-type.md](plugins/field-permission-type.md)
- Permissions this module provides → [permissions/permissions.md](permissions/permissions.md)
- Service API (check/compute field access) → [api/services.md](api/services.md)
- Alter discovered permission-type plugins → [hooks/hooks.md](hooks/hooks.md)
