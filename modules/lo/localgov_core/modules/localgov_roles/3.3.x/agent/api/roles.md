# LocalGov Roles — roles & `hook_localgov_roles_default()`

## Default roles (config/install)

| Machine name | `RolesHelper` constant |
|---|---|
| `localgov_author` | `RolesHelper::AUTHOR_ROLE` |
| `localgov_contributor` | `RolesHelper::CONTRIBUTOR_ROLE` |
| `localgov_editor` | `RolesHelper::EDITOR_ROLE` |
| `localgov_user_manager` | `RolesHelper::USER_MANAGER_ROLE` |
| `localgov_admin` (created by the `localgov_admin_role` submodule) | `RolesHelper::ADMIN_ROLE` |

## Granting permissions to these roles

Implement `hook_localgov_roles_default()` in your module, returning role→permissions:

```php
use Drupal\localgov_roles\RolesHelper;

function mymodule_localgov_roles_default() {
  return [
    RolesHelper::EDITOR_ROLE => ['access content overview', 'edit any page content'],
    RolesHelper::AUTHOR_ROLE => ['create page content'],
  ];
}
```

## How/when it is applied

- `localgov_roles_install()` invokes `hook_localgov_roles_default()` across all modules and grants the
  permissions (skipped during config sync).
- `hook_modules_installed()` calls `RolesHelper::assignModuleRoles($module)` for each newly installed
  module, which reads that module's `hook_localgov_roles_default()` and calls
  `user_role_grant_permissions($role, $permissions)`.
- `RolesHelper::getModuleRoles($module)` returns a module's declared defaults (or void).

Note: this only *grants* (adds) permissions; it never revokes. Depends on `role_delegation` for
delegated role assignment.
