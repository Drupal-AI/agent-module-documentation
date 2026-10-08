# Permissions

Defined in `draggable_dashboard.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer_draggable_dashboard` | All dashboard admin routes (list, add/edit/delete dashboards; place/configure/delete blocks within a dashboard). Also the entity's `admin_permission`. |

The placeable dashboard block is separately visible to anyone with **`access content`**
(`DraggableBlock::blockAccess()`), but each block *inside* a dashboard is re-checked with its
own `access()` at render, so the dashboard cannot expose block content a viewer couldn't
otherwise see.

## Hardening note (not a vulnerability)

`administer_draggable_dashboard` is **not** declared with `restrict access: true`, yet it lets
its holder add and configure arbitrary block plugins (with the plugins' own config forms) into
dashboard config entities. On its own that is bounded: to actually surface a dashboard on the
site you still need `administer blocks` (core, restricted) to place the derived block via Block
layout, and inner-block access is enforced at render. Still, treat this permission as
trusted/administrative and grant it only to roles you would also trust with block configuration.
