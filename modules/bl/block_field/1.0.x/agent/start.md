# block_field — agent start

Field type `block_field` that stores a chosen block plugin + its config per entity.
Widget `block_field_default`; formatters `block_field` (render block) and
`block_field_label`. No global config UI — configured per field on entity displays.

- Add & configure a Block field (selection method, widget, formatters) → [configure/field.md](configure/field.md)
- Define a block-selection strategy (BlockFieldSelection plugin) → [plugins/block-field-selection.md](plugins/block-field-selection.md)
- Read the configured block in code / block_field.manager service → [api/services.md](api/services.md)
- Alter available selection plugins → [hooks/hooks.md](hooks/hooks.md)
