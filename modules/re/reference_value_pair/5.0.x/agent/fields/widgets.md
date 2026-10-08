# Widgets

Two form widgets, both `field_types = {reference_value_pair}`. Each renders TWO inputs per delta:
a reference input (`target_id`) and a plain textfield for the scalar (`value`).

## `reference_value_autocomplete_widget` (default)

`\Drupal\reference_value_pair\Plugin\Field\FieldWidget\ReferenceValueAutocompleteWidget`
(extends `WidgetBase`). Reference input is a core `entity_autocomplete` element; supports
autocreate when the selection handler allows it.

| Setting            | Default    | Meaning |
|--------------------|------------|---------|
| `size_er`          | `60`       | Size of the entity-reference textfield. |
| `placeholder_er`   | `''`       | Placeholder for the reference textfield. |
| `match_operator`   | `CONTAINS` | Autocomplete match; `STARTS_WITH` or `CONTAINS`. |
| `size_value`       | `60`       | Size of the value textfield. |
| `placeholder_value`| `''`       | Placeholder for the value textfield. |

- `formElement()`: reference element uses `#validate_reference => FALSE` (the field's
  `ValidReference` constraint validates instead), `#maxlength => 1024`; value textfield uses
  `#maxlength => max_length` (field setting). Autocreate `uid` = entity owner or current user.
- Adds an `#element_validate` callback `validateEntityReferenceRequired()`: if `value` is filled
  but `target_id` is empty, sets a form error *"An entity reference is required when a value is
  provided."* (a value cannot be stored without a reference).
- `massageFormValues()`: unwraps the autocomplete array and normalises an empty reference to `NULL`.

## `reference_value_select`

`\Drupal\reference_value_pair\Plugin\Field\FieldWidget\ReferenceValueSelectWidget`
(extends core `OptionsWidgetBase`). Reference input is a `select` list of referenceable entities;
the `value` textfield sits beside it.

| Setting            | Default | Meaning |
|--------------------|---------|---------|
| `size_value`       | `60`    | Size of the value textfield. |
| `placeholder_value`| `''`    | Placeholder for the value textfield. |

- Column bound to `target_id` (constructor picks `target_id` from the field's property names).
- Options built via `OptionsWidgetBase::getOptions()`; `supportsGroups()` TRUE (optgroups by bundle).
  `sanitizeLabel()` strips tags/decodes entities on option labels (core select behavior).
- `errorElement()` maps validation errors onto the `target_id` sub-element.

## Config schema

`field.widget.settings.reference_value_select` (`size_value`, `placeholder_value`) and
`field.widget.settings.reference_value_autocomplete_widget` (`size_value`, `placeholder_value`,
`size_er`, `placeholder_er`, `match_operator`).
