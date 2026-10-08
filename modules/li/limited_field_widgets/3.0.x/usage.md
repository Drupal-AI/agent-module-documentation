Limited Widgets For Unlimited Fields adds a per-widget "Limit values" setting to fields whose cardinality is unlimited, capping how many values an editor can add on the entity form and enforcing that cap with a validation constraint.

---

The module targets fields whose storage cardinality is `CARDINALITY_UNLIMITED` (-1). Via `hook_field_widget_third_party_settings_form()` it adds a required "Limit values" number setting (0 = unlimited) to the widget on any *Manage form display* page. The chosen value is persisted as a third-party setting `limited_field_widgets.limit_values` — both on the form-display widget component and (through a custom `#value_callback`) on the field's `FieldConfig`. At runtime two things enforce the limit: `hook_entity_bundle_field_info_alter()` adds an `ItemCount` validation constraint (max = limit) to the field so saving too many values fails validation, and `hook_field_widget_complete_form_alter()` rewrites the widget so the UI itself prevents exceeding the limit — hiding the "Add another"/"Add more" button, removing extra deltas, turning a limit of 1 into single-value `radios`/`select`, and handling special widgets (Paragraphs, Media library, Inline entity form, File, Select2). It ships no admin page, no permissions, and no plugin type of its own beyond the `ItemCount` constraint plugin. The result is a hard limit on an otherwise-unlimited field, configured entirely per widget in the form display.

---

- Cap an unlimited "tags" reference field at 3 values per node.
- Allow only one value on an unlimited field, automatically turning checkboxes into radios or a select into a single-select.
- Limit how many Paragraphs an editor can add to an unlimited paragraph field.
- Restrict a Media library widget to a fixed number of selected media items.
- Cap an Inline Entity Form (complex) field so only N child entities can be created.
- Limit the number of files on an unlimited file-upload field.
- Enforce a maximum on an unlimited entity-autocomplete (tags) field.
- Prevent editors from clicking "Add another" beyond a configured maximum.
- Add a hard, validated ceiling to an unlimited field without changing its storage cardinality.
- Reuse a single unlimited field across bundles but give each bundle a different maximum via its own form display.
- Keep storage flexible (unlimited) while constraining data entry per content type.
- Stop over-population of a "related links" field by capping it at a handful of items.
- Apply different limits on different form modes (e.g. stricter on a simplified form).
- Ensure a "featured items" field never exceeds the number of slots the theme renders.
- Enforce a maximum number of authors on an unlimited author reference field.
- Limit Select2 / Select2 entity-reference widgets by setting their cardinality dynamically.
- Guarantee data integrity with the `ItemCount` constraint so even programmatic saves respect the cap.
- Give content teams a clear "up to N values" UX on unlimited fields.
- Restrict an unlimited address or phone field to a small, fixed count.
- Cap gallery images placed through a paragraph or media field.
- Provide a per-field maximum without writing a custom field widget.
- Set 0 to explicitly mean "no limit" while documenting intent in the widget settings.
- Convert a many-valued taxonomy widget into a single-choice control by setting the limit to 1.
- Prevent editors from adding more repeating components than a downstream integration supports.
