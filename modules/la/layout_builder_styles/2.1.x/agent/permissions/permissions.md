# Permissions

Defined in `layout_builder_styles.permissions.yml`.

| Permission | Gates |
|---|---|
| `manage layout builder styles` | Create, edit, and delete layout builder **styles** (also the config entity's `admin_permission`). |
| `manage layout builder style groups` | Create, edit, and delete layout builder **style groups**. |

These gate the configuration UI only. Whether an editor can *choose* a style on a block or
section is governed by core Layout Builder's own permissions
(`configure any layout` / `configure all <bundle> layouts`).

```
drush role:perm:add site_builder 'manage layout builder styles'
```
