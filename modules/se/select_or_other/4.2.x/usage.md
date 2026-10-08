Select (or other) adds an "Other" option to a select list, radios, or checkboxes; choosing it reveals a free-text field so users can enter a value that is not in the predefined options. It works both as a field widget and as a reusable Forms API (`#type`) element.

---

The module provides two Forms API render elements — `select_or_other_select` (renders a `<select>`) and `select_or_other_buttons` (renders radios for single-value or checkboxes for multi-value) — each of which appends an `- Other -` choice and a companion textfield that appears (via `#states`, or a JS hack for multi-selects) only when "Other" is chosen. On top of those elements it ships two field widgets, both labeled "Select or Other" on the Manage form display tab: `select_or_other_list` for `list_integer` / `list_float` / `list_string` fields, and `select_or_other_reference` for `entity_reference` fields (including taxonomy terms). Widget settings let you pick the underlying element (select list vs. check boxes/radio buttons), sort options ascending/descending, and customize the "Other" option label, the other-field label, and its placeholder. The list widget can optionally add values typed into "Other" to the field's allowed-values list (`add_other_value_to_allowed_values`, default on). The reference widget only offers "Other" when the field's entity-reference selection handler has auto-create enabled and the user has create access, in which case new referenced entities (e.g. taxonomy terms) are auto-created on submit. To make custom values validate, the module overrides core's `AllowedValues` constraint via `hook_validation_constraint_alter()`. It requires no modules outside Drupal core.

---

- Add an "Other" write-in choice to a List (text) field so editors can supply values beyond the predefined allowed values.
- Let content authors pick a taxonomy term from a select list or type a brand-new term that is auto-created on save.
- Render an entity-reference field as radio buttons plus an "Other" free-text option.
- Offer multi-select checkboxes where one choice reveals a textfield for a custom entry.
- Grow a List field's allowed-values list automatically from what users type in "Other".
- Keep a List field's allowed values fixed while still capturing occasional "other" free-text answers.
- Use `#type => 'select_or_other_select'` in a custom module form to get a select-with-other input.
- Use `#type => 'select_or_other_buttons'` for a radios/checkboxes-with-other input in any form.
- Present a "Country" (or similar) picker with a common shortlist plus "Other" for the long tail.
- Capture a "How did you hear about us?" field with preset options and an "Other" catch-all.
- Build a block configuration form that lets admins choose from options or enter a custom one.
- Sort a widget's options alphabetically (ascending or descending) via the widget settings.
- Rename the "- Other -" label to something domain-specific (e.g. "Something else").
- Add placeholder hint text inside the "Other" textfield to guide the expected format.
- Give the "Other" textfield its own visible label instead of relying on the parent title.
- Return select and other values merged into a single array with `#merged_values` for storage.
- Change the "Other" input from a textfield to another element type via `#input_type`.
- Suppress the empty/none option on the select with `#no_empty_option`.
- Attach an AJAX callback to the select part of the element via `#ajax`.
- Auto-create referenced entities in a chosen bundle when the selection handler allows it.
- Let taxonomy vocabularies drive the option list while permitting on-the-fly term creation.
- Disable the "Other" option automatically when the user lacks create access to referenced entities.
- Replace a plain core Options select widget with one that tolerates unforeseen values.
- Collect structured-but-extensible data (predefined choices that can still be extended by users).
- Provide a required select-or-other field that enforces a selection or a typed value.
- Reuse the element across multiple custom forms without depending on any contrib module.
