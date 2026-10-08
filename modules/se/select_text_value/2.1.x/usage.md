<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Select Text Value adds four field widgets for core text fields that let a site builder define a fixed list of allowed values which editors pick from a select list, radio buttons, or checkboxes, with an optional "Other" option that reveals the normal text input for a free-form value.

---

The module ships four `FieldWidget` plugins — `select_string_textfield` (for `string`), `select_string_textarea` (`string_long`), `select_text_textfield` (formatted `text`), and `select_text_textarea` (`text_long`) — each subclassing the matching core text widget and delegating shared logic to `Drupal\select_text_value\WidgetHelper`. You choose one of these widgets on the field's *Manage form display* page and configure it: a `select_type` (Select, Radio Buttons, or, for multi-value fields, Checkboxes), an `allowed_values` textarea (one value per line; a plain line is stored and displayed verbatim, though `key|label` pairs are also parsed), and an optional `custom_value_label` (default "Other") plus a title and description for the free-text field. When a custom label is set, the widget appends a `_custom_value` option; picking it uses Drupal `#states` to reveal the original text field so the editor can type any value. Values are massaged back into the field's normal storage format on save, so the data is stored exactly as core would store it — no key mapping, no extra tables. Setting `select_type` to `checkboxes` flips `handlesMultipleValues()` to TRUE so one checkboxes element captures every delta of a multi-value field at once. Clearing `custom_value_label` locks editors to the allowed list only. The module has no settings page, no permissions, no services beyond a hook helper, and no dependencies outside core.

---

- Turn a plain-text "Department" field into a select list of predefined departments without converting it to a list_string field.
- Offer radio buttons of preset "Priority" values (Low/Medium/High) on a text field.
- Present multi-value tag-like checkboxes on an unlimited-cardinality string field.
- Let editors pick from common values but still type a custom one via the "Other" option.
- Constrain a "Region" text field to a curated list while keeping the data as free text.
- Provide a dropdown of canned response snippets for a formatted text (`text`) field.
- Add preset options to a long-text (`string_long`) field such as standard disclaimer blocks.
- Give a formatted long-text (`text_long`) field a menu of reusable rich-text templates.
- Migrate an existing free-text field to a guided select UI without changing its storage or existing data.
- Rename the "Other" option (e.g. to "Custom", "Something else") via `custom_value_label`.
- Lock a field to allowed values only by leaving `custom_value_label` empty (no free entry).
- Add help text specifically for the custom-value input via `custom_value_field_description`.
- Give the custom-value input its own title separate from the field label.
- Standardise editor input for a field that must stay a string type for downstream integrations.
- Replace the contrib `select_or_other` module with a core-widget-based alternative.
- Provide checkboxes for a multi-value "Amenities" string field where each checked value is stored as its own delta.
- Pre-populate the widget so an existing stored value that matches the list is selected, and a non-matching value falls back to "Other".
- Keep a required field required by moving `#required` onto the select element automatically.
- Configure the whole widget through exported form-display config for deployment.
- Offer a select of predefined URLs or codes on a plain string field.
- Let content authors choose from a controlled vocabulary of phrases without a taxonomy.
- Apply different allowed-value lists per form mode (default vs a custom form display).
- Provide a quick single-select of statuses on a workflow-adjacent text field.
- Give editors radio buttons for a small fixed set of formatted text options.
- Reduce data-entry typos by constraining a text field to a vetted list.
