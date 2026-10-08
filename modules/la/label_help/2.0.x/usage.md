Label Help lets you add a line of help text that appears directly **below a field's label** (above the input) on entity edit forms, configured per field from the field settings form or set in code via a `#label_help` Form API property.

---

The module has no admin settings page of its own. For configured fields it adds a "Label help message" textarea to the core **field settings/edit form** (`hook_form_field_config_edit_form_alter`) and stores the value as a third-party setting on the `field_config` entity: `third_party_settings.label_help.label_help_description`. At form-build time, `hook_form_alter()` registers a process callback (`label_help_process_form`) that walks the form's children, reads either the `#label_help` render-array property (code path) or the field's stored `label_help_description` (UI path), and injects the text next to the label. Because Drupal widgets vary wildly, the module contains a large cascade of ~18 "use cases" that pick the correct insertion point per widget type — `#label_suffix`, `#field_prefix`, `#description`, or the element `#title` — for containers, multi-value fields, fieldsets/checkboxes/radios, details widgets, datetime, link fields, autocomplete, select lists, and custom elements, with a label-suffix fallback. It ships a themeable `label_help` render element with theme-specific templates/CSS for Seven, Claro and Gin (attached automatically based on the active theme stack). Two `settings.php` flags aid debugging: `label_help_debug` (annotates each placement with its use-case number) and `label_help_debug_dump` (dumps element arrays). The bundled `label_help_test` submodule provides a demo content type exercising many field types.

---

- Add a short instruction under a field's label, e.g. "Enter the event's public title" on an Article field.
- Give editors inline guidance without cluttering the field's normal description area.
- Configure help text per field from that field's settings form (no separate admin page).
- Store the help text as config (`third_party_settings.label_help.label_help_description`) for deployment.
- Set label help in custom code with the `#label_help` Form API property on a form element.
- Provide guidance on a checkbox/radios fieldset where a normal description reads awkwardly.
- Add help under a datetime field's label where core placement options do not work well.
- Annotate a link field's URL input with usage notes.
- Guide users on a select list by placing help right after its label.
- Add hints to an entity-reference autocomplete field.
- Show help on a multi-value field in the table header rather than inside each draggable row.
- Provide contextual help on media, address or other details-based widgets.
- Keep help text visually tied to the label using theme-specific styling (Seven/Claro/Gin).
- Standardise editorial guidance across many fields on a content type.
- Add help to a custom form element that has no widget wrapper.
- Debug placement problems with `label_help_debug` to see which use case fired.
- Inspect element render arrays during development with `label_help_debug_dump`.
- Provide translated help text via the field config third-party setting per language config override.
- Improve accessibility/clarity by putting the explanation next to the label, before the input.
- Replace ad-hoc "#description" hacks with a consistent label-help placement across widgets.
- Onboard new editors by explaining unusual fields directly in the form.
- Add compliance notes (e.g. "Do not enter personal data") beneath sensitive fields.
- Demonstrate/verify placements across field types using the label_help_test demo content type.
- Remove the help text again by clearing the "Label help message" textarea (it unsets the setting).
