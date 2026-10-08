Editable Fields provides an "Editable field" display formatter that renders a field's edit widget (inline or in a modal popup) right on the entity's display, so users can change and save that field's value without opening the full entity edit form.

---

The module adds a single field formatter, `editablefields_formatter` ("Editable field"), and makes it available for **every** field type by implementing `hook_field_formatter_info_alter()` (its `EditableFieldsHelper::formatterInfoAlter()` fills the formatter's `field_types` with all registered field types). On a bundle's *Manage display*, you switch a field to the "Editable field" formatter and pick which **form mode** supplies the widget. At render time the formatter builds that field's widget as an embedded `EditableFieldsForm` (an ajax form) and submits changes back to the entity. Two behaviours are supported: **inline** (the widget shows directly in the display) and **popup** (an "Edit" link opens the widget in a modal dialog via `core/drupal.dialog.ajax`, using the `editablefields.get_from` route). Access is gated by the `use editablefields` permission combined with the user's `update` access to the entity; a **Bypass access check** option and per-case **fallback formatters** (for no-access and pre-edit states) tune this. An **autosave** mode submits via ajax when named fields change (`fields_ajax_trigger` + `fields_ajax_trigger_event`, e.g. `change`/`blur`), hiding the update button. Settings live in the display component's formatter settings (schema `field.formatter.settings.editablefields_formatter`); there is no global settings page.

---

- Let editors change a node's title or a text field straight from the rendered page.
- Build a lightweight front-end editing experience without the full node edit form.
- Provide an inline-editable "status" or select field on a dashboard/listing view mode.
- Offer a modal "Edit" popup for a field so editors stay on the current page.
- Autosave a select field the moment it changes (ajax on `change`) with no Save button.
- Autosave a text field on `blur` for quick note-taking style editing.
- Make a specific field editable only in a custom view mode (e.g. an admin "manage" mode).
- Use a dedicated form mode's widget (e.g. a simplified widget) for the editable display.
- Let a user update their own profile field from their user page without the account form.
- Expose a moderation/state field for quick inline changes by editors.
- Show a read-only fallback formatter to users who lack edit access, and the widget to those who do.
- Bypass the entity update-access check for a field that should always be editable inline.
- Provide inline editing of a Commerce or custom entity field on its canonical page.
- Turn a taxonomy term field into an inline-editable control on the term page.
- Add quick "edit in place" to a field within a Views row using a per-field view mode.
- Combine inline editing with a popup fallback before the widget is requested (popup behaviour).
- Let content teams correct typos in a field without navigating to the edit form.
- Give a curated set of fields inline editing while leaving the rest display-only.
- Reduce clicks for repetitive single-field updates across many entities.
- Provide editors an autosaving inline widget for a rating or priority field.
- Restrict who can use inline editing site-wide via the `use editablefields` permission.
- Present different fallback display modes for no-access vs pre-edit states.
- Enable inline editing of a reference field using its form-mode widget (e.g. autocomplete).
- Let editors flip a boolean (e.g. "Featured") directly on the display with autosave.
