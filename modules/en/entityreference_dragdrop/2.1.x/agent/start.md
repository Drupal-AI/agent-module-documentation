# Entity Reference Drag & Drop — agent index

A single field widget (`entityreference_dragdrop`) for `entity_reference` fields: a two-list drag & drop
picker (available ↔ selected) with reorderable selected items. Chosen per field on **Manage form
display**; no global config page (`configure` null), no permissions, no schema, no Drush, no module
dependencies beyond core.

- **The widget: settings, how values/order are stored, JS wiring, theming** →
  [configure/widget.md](configure/widget.md)

Key facts:
- `EntityReferenceDragDropWidget` extends core `OptionsWidgetBase`, `multiple_values = TRUE`, field type
  `entity_reference`.
- Selected IDs live in a hidden `target_id` comma-separated string; `massageFormValues()` explodes it;
  selected list order = field delta order.
- JS library `entityreference_dragdrop/init` (depends on `core/sortable`); cardinality passed via
  `drupalSettings.entityreference_dragdrop[<key>]`.
- Theme hook `entityreference_dragdrop_options_list` →
  `templates/entityreference-dragdrop-options-list.html.twig`.
