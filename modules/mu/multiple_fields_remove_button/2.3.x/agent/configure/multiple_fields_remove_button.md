# Enable & behavior — the per-item Remove button

## There is no configuration UI

This module has **no admin settings form, no config entity, no config schema, and no
third-party widget setting** on Manage form display. Enabling the module is the entire
setup:

```
drush en multiple_fields_remove_button -y
```

Once enabled, a **Remove** button is added automatically to every widget row of any field
whose storage **cardinality is not 1** (both unlimited and fixed multi-value fields), as
long as the field type and widget are supported (see lists below). No per-field toggle
exists in the UI — scoping is done with alter hooks (see
[../hooks/multiple_fields_remove_button.md](../hooks/multiple_fields_remove_button.md)).

Where it acts: `hook_field_widget_single_element_form_alter()` in
`multiple_fields_remove_button.module`. Single-value fields (`cardinality == 1`) are skipped.

## The button

Injected as `$element['remove_button']`:

- `#type` => `submit`, `#value` => `t('Remove')`
- `#attributes` class `multiple-fields-remove-button`, `#weight` => `1000`
- `#validate` => `[]`, `#limit_validation_errors` => `[]` (removal bypasses field validation)
- Styled by the CSS library `multiple_fields_remove_button/multiple_fields_remove_button.widget`
  (trash-can icon), attached via `hook_preprocess_field_multiple_value_form()`.

## AJAX remove — two paths by cardinality

The submit + AJAX callback differ depending on whether the field is unlimited or fixed:

| Cardinality | `#submit` handler | `#ajax` callback | Effect |
|---|---|---|---|
| Unlimited (`CARDINALITY_UNLIMITED`) | `multiple_fields_remove_button_submit_handler` | `multiple_fields_remove_button_js` | deletes the item, renumbers deltas down, decrements `items_count`, re-weights rows, `fade` effect |
| Fixed (e.g. limited to 5) | `multiple_fields_remove_button_fixed_submit_handler` | `multiple_fields_remove_button_clear_value_js` | clears that row's value, shifts following values up, blanks the last row, re-weights |

The AJAX wrapper id is wired up in `multiple_fields_remove_button_process_container()`
(added to the `container` element via `hook_element_info_alter()`), reusing the field's
existing "Add another item" (`add_more`) AJAX wrapper so the whole widget re-renders.

## Supported field types (allow-list)

The button is only added when the field type is in this list (extendable via
`hook_multiple_field_remove_button_field_types_alter`):

`addressfield_standard`, `address`, `date_popup`, `date_text`, `daterange`, `datetime`,
`decimal`, `dynamic_entity_reference`, `email`, `entity_reference`,
`entity_reference_autocomplete`, `float`, `integer`, `link`, `location`,
`multiple_selects`, `number`, `property_reference`, `string`, `string_long`, `smartdate`,
`telephone`, `text`, `text_long`, `text_with_summary`, `timestamp`, `video_embed_field`.

## Skipped types & widgets

Skipped element types: `checkboxes` (extendable via
`hook_multiple_field_remove_button_skip_types_alter`).

Skipped widgets — these manage their own removal, so no button is added (extendable via
`hook_multiple_field_remove_button_skip_widgets_alter`):
`entity_reference_autocomplete_tags`, `entity_browser_entity_reference`,
`inline_entity_form_complex`, `readonly_field_widget`, `autocomplete_deluxe`,
`media_library_widget`, `entity_reference_tree`, `entityqueue_dragtable`,
`select_or_other_reference`, `term_reference_tree`.

## Restrict to specific fields

To only add remove buttons to named fields, implement
`hook_multiple_field_remove_button_included_fields_alter()` and return the field machine
names — any field not listed is skipped. Empty list (default) means all supported fields.
