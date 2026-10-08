# UUID Extra — agent index

Makes the core `uuid` base field **display-configurable** and adds a read-only UUID **widget**
and a UUID **formatter**, so an entity's UUID can be shown on its edit form and rendered output.
No settings form (`configure=null`), no permissions, no config schema, no Drush, no new plugin types.

- **Expose / show the UUID on an entity's form + display, the two plugins, and how it's stored** →
  [configure/uuid-display.md](configure/uuid-display.md)

Key facts:
- `hook_entity_base_field_info_alter()` calls `setDisplayConfigurable('view', TRUE)` and
  `setDisplayConfigurable('form', TRUE)` on each entity type's `uuid` key field.
- `hook_form_alter()` sets `$form['uuid']['#access'] = TRUE` when the form display has a `uuid` component.
- Widget plugin id `uuid` (`UuidFieldWidget`) — a **disabled** textfield (read-only, not editable).
- Formatter plugin id `uuid` (`UuidFieldFormatter`) — prints the raw UUID as `#markup`.
- State lives in the standard display config: a `uuid` component on
  `core.entity_form_display.<type>.<bundle>.<mode>` (widget) or `core.entity_view_display.…` (formatter).
