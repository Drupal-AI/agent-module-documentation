# Alter hooks

Defined in `multiple_fields_remove_button.api.php`. These are the only extension points —
there is no config UI. Implement them in your `MYMODULE.module`.

## `hook_multiple_field_remove_button_field_types_alter(array &$fieldTypes): void`

Add (or remove) field types eligible for a remove button. Runs on the built-in allow-list.

```php
function mymodule_multiple_field_remove_button_field_types_alter(array &$fieldTypes): void {
  $fieldTypes[] = 'custom_field_type';
}
```

## `hook_multiple_field_remove_button_skip_types_alter(array &$skipTypes): void`

Add element types that should **not** get a remove button (default list: `checkboxes`).

```php
function mymodule_multiple_field_remove_button_skip_types_alter(array &$skipTypes): void {
  $skipTypes[] = 'custom_field_type';
}
```

## `hook_multiple_field_remove_button_skip_widgets_alter(array &$skipWidgets): void`

Add widget plugin ids to exclude (e.g. widgets that already handle their own item removal).

```php
function mymodule_multiple_field_remove_button_skip_widgets_alter(array &$skipWidgets): void {
  $skipWidgets[] = 'custom_field_widget';
}
```

## `hook_multiple_field_remove_button_included_fields_alter(array &$includedFields): void`

Restrict remove buttons to an explicit list of field machine names. If non-empty, only the
listed fields get a button. Empty (default) means all supported fields.

```php
function mymodule_multiple_field_remove_button_included_fields_alter(array &$includedFields): void {
  $includedFields = ['field_tags', 'field_links'];
}
```

All four are invoked via `\Drupal::moduleHandler()->alter(...)` inside
`hook_field_widget_single_element_form_alter()` before the button is added.
