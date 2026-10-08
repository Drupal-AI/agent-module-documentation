# Attach a browser to a reference field

Entity Browser ships two field widgets (in `src/Plugin/Field/FieldWidget/`) that you
select on **Manage form display** for an entity reference or file/image field:

- **Entity browser** (`entity_reference_browser`) — for `entity_reference` fields.
- **File browser** (`entity_browser_file`) — for `file`/`image` fields.

Widget settings include:

- `entity_browser` — which browser config entity to open.
- `field_widget_display` — how selected items render in the widget:
  `label`, `rendered_entity`, or `thumbnail` (FieldWidgetDisplay plugins).
- `field_widget_display_settings` — options for that display (e.g. image style).
- `field_widget_edit` / `field_widget_remove` — show edit/remove buttons per item.
- `open` — open the browser immediately.
- `selection_mode` — append to or replace the current selection.

The stored value is a set of entity ids; `EntityBrowserElement::processEntityIds()`
converts the widget's `type:id` string back into entities. Cardinality from the field
is passed to the browser and enforced by the Cardinality validation plugin.
