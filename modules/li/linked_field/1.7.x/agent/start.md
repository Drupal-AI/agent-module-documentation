# linked_field — agent start

Adds a "Link this field" checkbox to any field formatter (except `link`-type fields) on
**Manage display**, wrapping the field's rendered output in an `<a>` to a chosen destination.
Settings are stored as formatter **third-party settings**; the link is applied at render by
`hook_entity_display_build_alter()` via the `linked_field.manager` service. Depends on core
`field` and (soft) `token` for token replacement.

- Set up "Link this field" per formatter + the available-attributes config form → [configure/linked_field.md](configure/linked_field.md)
- How the link is applied on render, the manager service, and theming behavior → [api/linked_field.md](api/linked_field.md)
