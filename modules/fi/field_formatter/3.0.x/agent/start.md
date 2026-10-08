# Field formatter — agent index

Three `@FieldFormatter` plugins that render a **single field** of a referenced entity, or
wrap any field's output in a link to the host entity. No configure route, no services, no
Drush. Settings live in the entity **view display** config (`core.entity_view_display.*`).

- **The three formatters — ids, target field types, settings keys, how to set them on a
  view display (UI + config)** → [configure/formatters.md](configure/formatters.md)
- **Reuse the base classes to build your own single-field / wrapping formatter** →
  [extend/base-classes.md](extend/base-classes.md)

Formatters at a glance:
- `field_formatter_with_inline_settings` — entity_reference / entity_reference_revisions;
  pick a referenced field + configure its formatter inline. Keys: `field_name`, `type`,
  `settings`, `label`, `link_to_entity`.
- `field_formatter_from_view_display` — same field types; render a referenced field using a
  chosen `view_mode`. Keys: `view_mode`, `field_name`, `link_to_entity`.
- `field_link` ("Field linker") — **all** field types; wrap output in a link to the host
  entity. Keys: `type`, `settings`.
