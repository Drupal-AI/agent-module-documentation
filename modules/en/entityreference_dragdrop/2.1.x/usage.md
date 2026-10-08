Entity Reference Drag & Drop provides a "Drag&Drop" field widget for entity reference fields that shows two side-by-side lists — available and selected entities — letting editors drag items between them and reorder the selected list (which sets the field delta order).

---

The module is a single field widget (`src/Plugin/Field/FieldWidget/EntityReferenceDragDropWidget.php`,
id `entityreference_dragdrop`) for `entity_reference` fields, chosen on an entity's **Manage form
display** tab. It extends core `OptionsWidgetBase` (so it works off the field's allowed-values option
list) and is a `multiple_values` widget: all deltas are edited in one control. It renders an
"available" list and a "selected" list; a small JS library (`entityreference_dragdrop/init`, built on
`core/sortable`) moves items between them and writes the selected IDs into a hidden `target_id`
field as a comma-separated string, which `massageFormValues()` explodes back into field values.
Selected order is preserved as the field's delta order. Per-widget settings let you label each list,
render entities either as their title or in any view mode, enforce field cardinality (a message shows
when the limit is reached), and optionally show a client-side text filter over the items. There is no
global config, no permissions, no schema, and no dependencies beyond Drupal core. Output uses the
`entityreference_dragdrop_options_list` theme hook
(`templates/entityreference-dragdrop-options-list.html.twig`).

---

- Replace the default entity-reference autocomplete/select with a two-list drag & drop picker.
- Let editors pick multiple referenced entities by dragging them from an "available" to a "selected" list.
- Manually order the selected references (stored as field delta order) by dragging within the selected list.
- Curate a list of related articles/products with a visual selector.
- Build a "featured items" field where order matters and is set by dragging.
- Render each option as a full teaser/card (any view mode) instead of just the title while selecting.
- Show just entity titles for a compact picker (default view mode `title`).
- Relabel the two columns (e.g. "All tags" / "Chosen tags") via the available/selected label settings.
- Enforce a field's cardinality with an on-screen "cannot hold more than N values" message.
- Add a live text filter to quickly find an entity in a long available list.
- Assign taxonomy terms to content with a drag & drop dual-list instead of checkboxes.
- Manage menu/section ordering modeled as an ordered entity-reference field.
- Let users build an ordered playlist/gallery from referenced media entities.
- Provide a friendlier multi-select for reference fields with many allowed values.
- Reorder team members, sponsors, or logos shown in a specific sequence.
- Use view-mode rendering to preview images/thumbnails of referenced entities during selection.
- Improve editorial UX on paragraphs/layout fields that reference reusable components.
- Give content editors a clear visual distinction between chosen and unchosen options.
- Support single-value reference fields too (the widget respects cardinality of 1).
- Swap in as a drop-in widget on any existing entity_reference field without schema changes.
