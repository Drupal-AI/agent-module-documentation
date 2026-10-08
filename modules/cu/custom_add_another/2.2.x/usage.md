<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom add another lets you replace the generic **"Add another item"** and **"Remove"** button labels on unlimited-cardinality (multi-value) fields with your own wording, per field instance.

---

The module is a small set of form alterations with no UI page of its own. On the *field instance edit* form (`field_config_edit_form`) it adds two text fields — **Custom add another item button** and **Custom remove button** — but only when the field's *Number of values* is set to **Unlimited** (`CARDINALITY_UNLIMITED`) and the field storage is not locked. Whatever you type is saved as a **third-party setting** on that field's `FieldConfig` entity under the `custom_add_another` namespace (`custom_add_another` and `custom_remove` keys); an empty value is unset so the core default label is used. At form-render time (`hook_field_widget_complete_form_alter` + `hook_preprocess_field_multiple_value_form`) the module swaps the `add_more` button's `#value` and the remove button's value for your custom text. It also special-cases multiple **managed_file** widgets, adding a `#process` callback so the upload/remove buttons on file and image fields pick up the custom labels too. Settings are stored per field instance (per bundle), so the same field reused on two bundles can have different button text. A config schema (`field.field.*.*.*.third_party.custom_add_another`) validates the two stored strings.

---

- Change an image field's "Add another item" button to read "Add another image".
- Relabel a "Highlights" field's button to "Add another highlight".
- Rename the "Remove" button on a multi-value field to "Remove this item".
- Give a "Team members" field a friendlier "Add another team member" button.
- Customise a "FAQ" paragraph-style field's add button to "Add another question".
- Set distinct button text for the same field reused on two different content types.
- Make a documents field read "Add another document" and "Delete document".
- Improve editorial UX by using domain language instead of the generic default label.
- Relabel the upload/remove buttons on a multiple managed_file field (files or images).
- Rename a gallery image field's add button to "Add another photo".
- Provide clearer calls to action on long multi-value forms.
- Localise button wording per bundle without writing a custom widget.
- Set "Add another link" on an unlimited link field.
- Only expose the customisation on fields that are actually unlimited (option is hidden otherwise).
- Configure the labels through exported config (field third_party_settings) for deployment.
- Leave the value empty to fall back to Drupal's default button text.
- Rename "Add another item" to "Add row" on a tabular multi-value field.
- Give a contacts field "Add another contact" / "Remove contact" labels.
- Apply custom labels on a taxonomy-term or user entity's multi-value field.
- Keep a consistent verb ("Add another …") across many fields on a site.
- Rename buttons on a repeating "Award" or "Certification" field.
- Set an action-oriented "Add another attachment" on a file field.
- Adjust wording to match a client's tone of voice on content-entry forms.
- Store per-instance labels that travel with the field configuration.
