# multiple_fields_remove_button — agent start

Adds a per-row **Remove** submit button to multi-value field widgets (cardinality != 1),
which Drupal core lacks. Works automatically once enabled — **no admin UI, no settings form,
no per-widget third-party setting**. Only dependency: core `field`. Implemented in
`multiple_fields_remove_button.module` via `hook_field_widget_single_element_form_alter()`.

- How it works, supported field types, AJAX remove callbacks, opt-in/out →
  [configure/multiple_fields_remove_button.md](configure/multiple_fields_remove_button.md)
- Alter hooks (field types, skip types, skip widgets, included fields) →
  [hooks/multiple_fields_remove_button.md](hooks/multiple_fields_remove_button.md)
