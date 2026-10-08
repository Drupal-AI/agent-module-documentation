# Configuration

Fast Permissions Administration works the moment it is enabled — it takes over the
permissions page and adds the filter UI with no setup. The only configuration is
*turning off* parts of that UI if you don't want them, plus one permission that
controls who can reach the settings form.

## Open the settings form

1. Log in as a user with the **Manage fast permissions administration settings**
   permission.
2. Go to **Configuration → People → Fast permissions administration settings**, or
   navigate directly to `/admin/config/people/fpa-settings`.

## Disabled sections

The form has a single **Disabled sections** set of checkboxes. Each box you tick
*removes* that piece of the enhanced permissions page:

- **Help** — the on‑page help text explaining the `permission@module` filter
  syntax.
- **Modules** — the module listing / sidebar you use to jump to a module's
  permissions.
- **Roles** — the role filter.
- **Status** — the permission status (checked / not‑checked) filter.

Leave a box unchecked to keep that section visible. By default nothing is
disabled, so all sections show. Save the form and your choices take effect on the
next load of `/admin/people/permissions`.

Behind the scenes this is stored in the single config object `fpa.settings` under
the `disabled_sections` key. You can inspect or set it from Drush:

```bash
drush config:get fpa.settings disabled_sections
```

## The permission

FPA defines exactly one permission:

- **Manage fast permissions administration settings** — grants access to the
  settings form above. It is not marked security‑restricted, and it *only*
  controls that small form.

Note an important distinction: this permission does **not** grant access to the
permissions page itself. The enhanced page at `/admin/people/permissions` is still
the core route, gated by core's own **Administer permissions** requirement. So a
user needs *administer permissions* to view and edit role permissions, and
*manage fast permissions administration settings* only to tune which FPA sections
appear.

Grant the FPA permission from Drush, for example:

```bash
drush role:perm:add administrator 'manage fast permissions administration settings'
```
