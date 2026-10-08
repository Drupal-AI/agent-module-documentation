<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extra Field Description lets you add a second, extra description that renders **above** a field's input widget on entity edit forms (core places the normal description below), configured per field on *Manage form display*.

---

The module adds a per-widget third-party setting named `extra_description` via `hook_field_widget_third_party_settings_form`: an "Extra description" textarea appears in the widget settings (the cog) on the *Manage form display* tab of any non-base field, but only for users holding the `administer field prefix` permission. The value is stored in the widget's `third_party_settings.extra_field_description.extra_description.over_description` inside the `entity_form_display` config entity. On the actual entity add/edit form, `hook_field_widget_single_element_form_alter` injects that text as a `#field_prefix` (wrapped in a `<div class="extra-description">`) on the field's value element — with special handling for `datetime`/`datelist`, entity-reference (`target_id`), and generic widgets. A small CSS library (`extra_field_description/extra_field_description_css`, `css/efd.css`) styles the `.extra-description` block and is attached on every page. The stored value is emitted as raw markup (not run through a text filter), so the settings form documents the allowed HTML tags but does not itself sanitize. There is no global settings page (`configure` is null) and no config schema; everything lives in the form-display component.

---

- Show clarifying help text *above* a field's widget instead of only below it.
- Add a per-field instruction on a content-type's edit form (e.g. "Upload a square image").
- Provide extra guidance on complex fields like date ranges or entity references.
- Add contextual notes to a specific form mode without changing the field's stored description.
- Style helper text consistently across forms via the shipped `.extra-description` CSS.
- Prepend a formatted note (allowed HTML tags) to a text or textarea field widget.
- Add an above-field description to a datetime / datelist widget (special-cased placement).
- Add an above-field description to an entity-reference autocomplete widget.
- Give editors inline policy reminders on sensitive fields (e.g. "Do not include PII").
- Differentiate guidance per form display mode (default vs. a custom mode) for the same field.
- Supplement a field's built-in description with links to external documentation.
- Restrict who can author extra descriptions using the `administer field prefix` permission.
- Optimize helper-text presentation for the Rubik admin theme (per the README).
- Add a heading or emphasis above grouped fields on long content forms.
- Improve editorial UX on webform-like content entry without custom code.
- Keep the extra text in configuration (form display) so it ships with config export.
- Annotate migration or import forms' fields with reviewer notes.
- Add a warning banner above a legal/consent field on a registration or profile form.
