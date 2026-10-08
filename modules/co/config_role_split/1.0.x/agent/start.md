<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Role Split — agent index

A **Config Filter** plugin (requires `config_filter`) that manages selected **role permissions**
during config **import/export** only — it does nothing on a running site. Configuration is a
**`role_split` config entity** (`config_prefix: role_split` → config name
`config_role_split.role_split.<id>`). Depends on `drupal/config_filter`.

- **The `role_split` config entity: fields, the `roles` permission map, the collection UI, drush** →
  [configure/role-split.md](configure/role-split.md)
- **How the filter rewrites role config on import/export, and what `split` / `fork` / `exclude` do** →
  [api/how-it-works.md](api/how-it-works.md)

Key facts:
- Entity id `role_split`; exported keys: `id`, `label`, `weight`, `status`, `mode`, `roles`.
- `roles` is a map `role_id => [permission_string, ...]` (only the permissions the filter should touch).
- `mode` ∈ `split` (default) | `fork` | `exclude`.
- configure route `entity.role_split.collection` at
  `/admin/config/development/configuration/config-role-split`.
- One permission: **`administer config role split`** (`restrict access: true`; the entity's
  `admin_permission`).
- No services, no Drush commands of its own, no plugin *types* defined (it is a `config_filter`
  plugin instance via a deriver). Saving/deleting a split clears the config_filter plugin cache.
