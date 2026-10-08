Multiple Fields Remove Button adds a per-item "Remove" button to multi-value field widgets, letting editors delete an individual value from an unlimited- or fixed-cardinality field, which Drupal core does not provide out of the box.

---

Drupal core's multi-value ("Add another item") field widgets let you add rows and reorder them, but there is no button to remove a single value inline — you must blank it out and save. This module fills that gap. On enabling it (its only dependency is core `field`), it implements `hook_field_widget_single_element_form_alter()` to inject a `Remove` submit button (weight 1000, class `multiple-fields-remove-button`) into each widget row of any field whose cardinality is not 1. The button is AJAX-driven: for **unlimited** (`CARDINALITY_UNLIMITED`) fields it uses `multiple_fields_remove_button_submit_handler()` plus the `multiple_fields_remove_button_js()` callback to delete the item, renumber the remaining deltas, and re-weight the rows; for **fixed** multi-value fields it uses `multiple_fields_remove_button_fixed_submit_handler()` plus `multiple_fields_remove_button_clear_value_js()` to clear that row's value and shift the rest up. It ships with a curated allow-list of supported field types (string, text, email, link, integer, decimal, float, number, telephone, datetime, daterange, timestamp, entity_reference, dynamic_entity_reference, address, video_embed_field, smartdate, and more) and skip-lists for widgets/types that manage their own removal (e.g. `media_library_widget`, `inline_entity_form_complex`, `entity_browser_entity_reference`, `checkboxes`). There is no admin settings form; behavior is tuned entirely through four `hook_*_alter()` hooks documented in `multiple_fields_remove_button.api.php` — to add field types, skip types, skip widgets, or restrict to an explicit list of field names. A small CSS library styles the button with a trash-can icon next to each row.

---

- Give content editors a one-click way to remove a single value from an unlimited multi-value field.
- Remove an individual row from a multi-value text or string field without blanking and saving.
- Delete one item from an unlimited entity-reference field's widget inline.
- Remove a single link from a multi-value Link field on a node form.
- Drop one email address from a multi-value Email field row.
- Remove an individual value from a multi-value integer, decimal, float, or number field.
- Delete one date/datetime/daterange/timestamp entry from a multi-value date field.
- Remove a single telephone value from a multi-value phone field.
- Clear one row of a fixed-cardinality (e.g. limited to 5) multi-value field, shifting the rest up.
- Provide remove buttons for Address, Smart Date, or Video Embed Field multi-value widgets (when those field types are installed).
- Improve the editorial UX of long multi-value fields where core only offers "Add another item".
- Let editors prune reference lists (dynamic_entity_reference, entity_reference_autocomplete) item by item.
- Avoid accidental deletion by keeping removal explicit and per-row rather than clearing the whole field.
- Extend support to a custom field type via `hook_multiple_field_remove_button_field_types_alter()`.
- Exclude a specific field type from getting a remove button via `hook_multiple_field_remove_button_skip_types_alter()`.
- Exclude a specific widget (e.g. a custom autocomplete) via `hook_multiple_field_remove_button_skip_widgets_alter()`.
- Limit remove buttons to only named fields via `hook_multiple_field_remove_button_included_fields_alter()`.
- Keep remove buttons off widgets that already handle removal (media library, inline entity form, entity browser).
- Preserve correct delta ordering and weights automatically after an AJAX removal.
- Add per-row removal to any newly created unlimited field without writing custom form-alter code.
- Standardize multi-value removal UX across an entire site by enabling one module.
- Use the AJAX fade effect on unlimited-field removals for a smoother editing experience.
- Style the remove control consistently with the shipped trash-can icon CSS library.
- Reduce editor confusion on fields that previously required manual reordering to "remove" a value.
