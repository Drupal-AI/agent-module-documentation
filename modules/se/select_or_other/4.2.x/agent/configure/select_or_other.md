# Use the Select (or other) field widget

No global settings and no config route — everything is configured per field on the entity's
**Manage form display** tab. Two widgets, both labeled **"Select or Other"**:

| Widget id | Field types | Notes |
|---|---|---|
| `select_or_other_list` | `list_integer`, `list_float`, `list_string` | can grow the field's allowed values |
| `select_or_other_reference` | `entity_reference` (incl. taxonomy terms) | can auto-create referenced entities |

Choosing "Other" adds an `- Other -` choice to the options and reveals a textfield for a
custom value.

## Widget settings (both widgets)

Set via the gear icon on Manage form display; stored in the widget config (schema:
`field.widget.settings.select_or_other_list` / `...select_or_other_reference`).

| Setting | Default | Meaning |
|---|---|---|
| `select_element_type` | `select_or_other_select` | Underlying element: `select_or_other_select` (Select list) or `select_or_other_buttons` (Check boxes/radio buttons) |
| `sort_options` | `''` | Sort options by value: `''` (no sorting), `ASC`, `DESC` |
| `other_placeholder` | `''` | Placeholder text inside the "Other" textfield |
| `other_option` | `''` | Label of the "Other" choice (empty → `- Other -`) |
| `other_field_label` | `''` | Visible label for the "Other" textfield |

## List widget only

| Setting | Default | Meaning |
|---|---|---|
| `add_other_value_to_allowed_values` | `true` | On submit, add values typed in "Other" to the field storage's `allowed_values`. If off, the typed value is stored for this item but the allowed-values list is left unchanged. |

Enter the field's allowed values on the field settings as usual — do **not** add an "other"
entry yourself. See README "List widget".

## Reference widget only

The "Other" option is only offered when the field's **entity-reference selection handler has
`auto_create` enabled** *and* the current user has create access to the target bundle
(`ReferenceWidget::isApplicable()` requires a `SelectionWithAutocreateInterface` handler with
`auto_create` = true). When allowed, submitting an "Other" value auto-creates the referenced
entity (e.g. a new taxonomy term) in the auto-create bundle. If create access is denied, the
widget sets `#other_allowed = FALSE` and hides the "Other" textfield. Set up: add an
entity-reference/taxonomy field, enable "Create referenced entities if they don't already
exist", then pick "Select or Other" as the widget.
