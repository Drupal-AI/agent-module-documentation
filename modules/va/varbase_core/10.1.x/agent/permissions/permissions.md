# Varbase Core — permissions

Defined in `varbase_core.permissions.yml`. The module declares exactly one permission of its own.

| Permission | Title | Grants |
|---|---|---|
| `access varbase settings` | Access Varbase settings | Access to the Varbase settings landing page (`/admin/config/varbase`) and the general settings form (`/admin/config/varbase/settings`). It is the `_permission` requirement on both `varbase_core` routes. |

Not marked `restrict access`, but both routes only expose a config landing page and a two-checkbox
`ConfigFormBase`, so it is effectively an administrative permission — grant it to trusted admin roles.

## Role permissions applied at install (not module-defined)

Beyond the permission above, `varbase_core` ships **role→permission grants** under
`config/permissions/` (`user.permissions.anonymous.yml`, `authenticated`, `editor`,
`content_admin`, `seo_admin`, `site_admin`). At install `hook_install` runs
`Vardot\Installer\ModuleInstallerFactory::addPermissions('varbase_core')`, which merges these
grants onto the matching roles. Additional grants under `config/managed/editoria11y/permissions/`
are applied only if the Editoria11y module is later enabled (see [hooks](../hooks/hooks.md)).
These files assign *existing* permissions from many modules to the Varbase role set — they do not
define new permission strings.
