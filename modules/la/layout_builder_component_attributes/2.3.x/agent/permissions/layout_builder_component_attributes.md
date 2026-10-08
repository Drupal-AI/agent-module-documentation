# Permissions

Defined in `layout_builder_component_attributes.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer layout builder component attributes` | The global settings form (`layout_builder_component_attributes.settings`) — which attribute types (id/class/style/data) are allowed on each group. Trusted/administrative. |
| `manage layout builder component attributes` | The per-component **Manage attributes** form (`layout_builder_component_attributes.manage_attributes`) — lets editors add id/class/style/data-* attributes to Layout Builder components. Also requires Layout Builder `view` access on the layout. |

```
drush role:perm:add layout_editor 'manage layout builder component attributes'
```
