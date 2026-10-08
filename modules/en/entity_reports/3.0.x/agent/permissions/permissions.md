# Permissions

Declared in `entity_reports.permissions.yml`. Both are plain permissions (no `restrict access`).

| Permission | Title | Gates |
|---|---|---|
| `view entity reports` | Access the entity reports | The landing route `entity_reports.entity_types` and every generated route: the per-entity-type report pages, the per-entity-type exports, and the statistics exports. All of these are also `_admin_route`. |
| `administer entity reports` | Administer entity reports | The settings form route `entity_reports.settings_form` only. |

Grant example:

```bash
ddev drush role:perm:add anonymous 'view entity reports'   # example only; normally an authenticated/admin role
ddev drush role:perm:add content_editor 'administer entity reports'
```

There are no other access checks in the controller or route generator beyond these `_permission`
requirements, so role assignment fully governs who can see or export the structure data.
