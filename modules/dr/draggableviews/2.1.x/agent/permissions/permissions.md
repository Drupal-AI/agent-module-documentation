# Permissions

Defined in `draggableviews.permissions.yml`:

- **`access draggableviews`** — "Access Draggableviews". Controls whether a user sees the
  **Save order** button on a draggable view and may persist a new row order. Users without it
  can view the (already ordered) table but cannot reorder. Not restricted (grant carefully to
  trusted editors/moderators). There is no separate "administer" permission — this single
  permission gates all saving.
