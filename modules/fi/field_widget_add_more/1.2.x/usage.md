Field Widget Add More adds an "Add another item" button (and per-row "Remove" buttons) to field widgets on fields with a fixed, limited cardinality greater than one — a UX core normally offers only for unlimited-cardinality fields.

---

Core renders every allowed delta of a limited-cardinality field at once (e.g. a cardinality-3
field always shows three widgets), and only unlimited fields get the AJAX "Add more" button. This
module restores that incremental UX for capped fields. It exposes a per-widget third-party
setting via `hook_field_widget_third_party_settings_form()` — a "Show add more button" checkbox
— but **only** on fields whose storage cardinality is a fixed number greater than 1 (it returns
nothing for cardinality 1 or unlimited). When that setting (`field_widget_add_more.add_more`) is
enabled on a form-display component, `hook_field_widget_complete_form_alter()` rewrites the
widget: it shows only the currently-used number of items (starting at one), adds an AJAX **Add
another item** submit that appends a delta up to the cardinality cap, and adds a **Remove** submit
to each row. When the item count reaches the cardinality, the Add button is hidden. The setting is
stored on the `entity_form_display` config entity under the component's
`third_party_settings.field_widget_add_more.add_more: true` (schema
`field.widget.third_party.field_widget_add_more`). No config page, permissions, services, or
Drush — it is enabled per field on Manage form display.

---

- Give a cardinality-3 "phone numbers" field an "Add another item" button instead of three fixed rows.
- Let editors add rows one at a time on a capped multi-value field, up to its limit.
- Add per-row "Remove" buttons to a limited-cardinality field's widget.
- Start a capped field with a single empty row rather than all N rows shown at once.
- Hide the "Add" button automatically once the field reaches its maximum allowed items.
- Enable the incremental add/remove UX on a "up to 5 links" field.
- Provide the unlimited-field editing experience for a fixed-cap field without changing storage.
- Turn the button on per form mode via Manage form display (default vs a custom form mode).
- Keep a field's stored cardinality cap while making the form feel unlimited-until-the-cap.
- Configure the behavior as exportable config on the entity_form_display component.
- Apply it to a capped entity-reference field's widget.
- Apply it to a capped text/string field's widget.
- Reduce visual clutter on forms with several capped multi-value fields.
- Let content authors add only as many items as they need, up to the limit.
- Toggle the button off to return to core's all-rows-shown behavior.
- Use AJAX add/remove so the page doesn't reload while editing items.
- Avoid a custom widget just to get an "Add more" button on a capped field.
- Standardize add/remove UX across capped fields on a content type.
- Focus the first field of a newly added row for faster data entry.
- Support any widget type on the field (the alter wraps the complete widget form).
- Prevent editors from being confronted with many empty rows on optional capped fields.
