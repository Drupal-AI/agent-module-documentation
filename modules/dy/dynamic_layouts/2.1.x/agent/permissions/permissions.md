# Permissions

One permission, defined in `dynamic_layouts.permissions.yml`:

| Permission | Title | Grants |
|---|---|---|
| `admin dynamic layouts` | Administer Dynamic Layouts | Full access to every module route: the layout list, add/edit/delete layouts, the row/column add/delete/edit AJAX endpoints, and the global settings form. |

- It is the `admin_permission` on both config entity types (`dynamic_layout`, `dynamic_layout_settings`).
- Every route in `dynamic_layouts.routing.yml` requires it (`_permission: 'admin dynamic layouts'`).
- It is a broad admin permission — grant it only to trusted site builders. There is no finer split
  between "define layouts" and "change global settings".

Grant via Drush:

```bash
drush role:perm:add site_builder 'admin dynamic layouts'
```

Note: creating/editing a layout only defines the layout plugin. **Using** a layout in Layout Builder
is still gated by the relevant Layout Builder permissions on the host entity/display, not by this
permission.
