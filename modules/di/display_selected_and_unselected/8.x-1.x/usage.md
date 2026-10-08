Two field formatters that render the full allowed-values list of a List field, marking each option as selected or unselected using disabled radios or checkboxes.

---

Display Selected and Unselected is a small, presentational-only module in the "Fields" package. It adds two view-display field formatters for core List fields (`list_string`, `list_integer`, `list_float`) that, instead of printing only the values a user chose, render *every* option defined in the field's allowed-values list and mark which ones are selected. The "values" formatter renders each option's label (value), and the "keys" formatter renders each option's key. Output shape follows the field's cardinality: a single-value field (Allowed number of values = 1) renders as disabled `radio` inputs, any other cardinality renders as disabled `checkbox` inputs. Rendering is done through four `hook_theme()`-registered theme hooks with overridable Twig templates, so the HTML can be themed per site. The module has no settings form, no configuration objects, no routes, no permissions, no services, and no dependencies beyond Drupal core — you enable it and pick a formatter on Manage display.

---

- Show a "survey answer sheet" view where all possible answers appear and the respondent's picks are ticked.
- Display a multi-select "features" or "amenities" list on a node so viewers see both included and not-included items at a glance.
- Render a single-choice List field as a read-only radio group showing all options with the chosen one selected.
- Present a checklist of options (e.g. dietary tags, accessibility features) with unchosen items visibly greyed out rather than hidden.
- Output the machine keys of a list field (keys formatter) for debugging or integration displays where the stored key matters.
- Output the human labels of a list field (values formatter) for normal end-user display.
- Give editors a print-friendly "complete options with selection" view of a taxonomy-like list field.
- Show a product's option matrix (sizes, colors) with the selected variant marked and the rest shown as available-but-unselected.
- Display quiz/exam questions where all answer choices must remain visible alongside the marked answer.
- Render eligibility criteria where both met and unmet criteria should be shown.
- Present compliance/consent checkboxes as a read-only summary of what was and wasn't agreed to.
- Show a feature-comparison cell that lists every possible tier and highlights the active one.
- Customize the markup by overriding `display-selected-and-unselected-values-checkbox.html.twig` (and its radio/keys siblings) in your theme.
- Add CSS hooks via the wrapper classes (`display_selected_and_unselected_values_checkbox`, etc.) emitted by the templates.
- Use on `list_integer` fields (e.g. rating scales 1–5) to show the full scale with the selected number marked.
- Use on `list_float` fields where allowed values are decimal options.
- Provide a non-editable "form-like" preview of a list field on a node's default or teaser view mode.
- Combine both formatters across two view modes: keys for an admin/data view mode, values for the public view mode.
- Show unselected options deliberately (e.g. "not included") for transparency in service or plan descriptions.
- Replace a plain comma-separated list output with a structured, checkbox-style presentation.
