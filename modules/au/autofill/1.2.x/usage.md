Autofill copies the value of one text (`string`) field into another as the user types, on entity edit forms. You enable it per target field from *Manage form display*, pick a source field, and a small JavaScript behavior mirrors the source into the target until the target is edited manually.

---

The module adds no plugins, entities, or config of its own — it works purely through core's
field-widget **third-party settings** and a JS behavior. `hook_field_widget_third_party_settings_form`
adds, to any widget of a `string` field, an "Enable Autofill from another field" checkbox plus a
"Autofill source field" select whose options are the other `string` fields on the same form
(built by `_autofill_get_available_source_fields_as_options`, which reads the entity's
`string`-typed field storage definitions and their bundle labels). The chosen `enabled` /
`source_field` values are stored as third-party settings under the `autofill` provider on the
form-display component (config schema `field.widget.third_party.autofill`).
`hook_field_widget_single_element_form_alter` attaches the `autofill/autofill` library and a
`drupalSettings.autofill.field_mapping[<target>] = <source>` entry whenever a widget has the
setting enabled. The behavior (`js/autofill.js`, using `core/once`) listens for `input` on the
source element and writes its value into the target (dispatching an `input` event so dependent
behaviors like the length counter update) — but **only while the target is untouched**: it
stops autofilling as soon as the user types into the target (`keypress`) or if the target
already differs from the source when the form loads. Only single-value `string` fields
(`[name="field[0][value]"]`) are wired. No admin page, no permissions, no Drush.

---

- Auto-populate a "Display title" field from a "Title" field as the editor types.
- Copy a product name into a SKU/slug helper field during entry.
- Pre-fill a "Meta title" from the main heading field, editable afterward.
- Mirror a "Full name" into a "Sort name" field until the editor overrides it.
- Suggest a short-name field value from a longer label field.
- Reduce duplicate typing across two related text fields on a content form.
- Copy a company name into a contact-form "Organisation" field.
- Seed a URL-friendly helper field from a plain-text title field.
- Keep a secondary label in sync with a primary one during initial creation.
- Enable autofill per field, per form mode, from Manage form display.
- Pick which source `string` field feeds each target field.
- Let editors freely edit the target after autofill (mirroring detaches on manual input).
- Avoid overwriting an already-populated target when editing existing content.
- Provide typing-time convenience without a custom widget or JavaScript of your own.
- Trigger dependent widget behaviors (e.g. maxlength counter) by dispatching an input event.
- Apply autofill only to plain text (`string`) single-value fields where it is safe.
- Show a form-display summary line ("Autofill from: <field>") when configured.
- Disable the checkbox automatically when no eligible source field exists on the form.
- Speed up data entry for content types with parallel title/label fields.
- Wire multiple target fields on the same form, each to its own source field.
