# Node Weight — agent index

Adds a shared integer `field_node_weight` to chosen content types plus a drag-and-drop "Manage order"
screen; weight is usable as a Views sort. Depends on core `node`. Config object `node_weight.settings`;
`configure` route `node_weight.form`. Two permissions.

- **Enable per type, the settings keys, how the field is created, the order screen and the
  `weight_selector` widget** → [configure/settings.md](configure/settings.md)
- **The two permissions and the routes/menu they gate** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Settings form `NodeWeightForm` at `/admin/config/node-weight`; per-type order form `NodeOrderForm` at
  `/admin/structure/types/manage/{node_type}/order`. Enabling a type creates a `FieldConfig` on the
  locked shared storage `field.storage.node.field_node_weight` (integer, min/max from settings) and
  sets the `weight_selector` widget.
- `node_weight.settings`: `checked_node_types`, `min_weight` (-10), `max_weight` (10),
  `include_unpublished` (1).
- Saving the order runs a batch (25/run) that writes weight + status with `setNewRevision(FALSE)`.
- Sort content by adding `field_node_weight` as a Views sort criterion.
