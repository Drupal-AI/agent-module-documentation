# Draggable Dashboard — agent index

Build multi-column dashboards from arbitrary block plugins, then place each dashboard as a
single block via core Block layout. Config UI at `admin/structure/draggable-dashboard`
(`configure` = `entity.dashboard_entity.collection`). Depends on core `block`. One permission,
config schema, no Drush, no submodules.

- **Create/manage dashboards, the `dashboard_entity` config entity shape, add/configure/order
  blocks, how the placeable block deriver + render works** → [configure/dashboards.md](configure/dashboards.md)
- **The single permission and what it gates (incl. a hardening note)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config entity `dashboard_entity` (`config_prefix: dashboard_entity`), keys: `title`,
  `description`, `columns` (int), `blocks` (map keyed by machine name → `{column, settings, weight}`).
- Placeable block: `draggable_dashboard_block:draggable_dashboard_<dashboard_id>` (via
  `DraggableBlockDeriver`); `blockAccess` = `access content`; inner blocks are access-checked at render.
- All admin routes require permission `administer_draggable_dashboard`.
