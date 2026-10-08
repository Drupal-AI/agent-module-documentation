# Element markup alter hooks (`webform_migrate.api.php`)

When a legacy webform component is converted to Webform `elements` YAML, the module lets
other modules rewrite the generated markup per element **type**. Two variable hooks:

## `hook_webform_migrate_d7_webform_element_ELEMENT_TYPE_alter(&$markup, $indent, array $element)`

Replace `ELEMENT_TYPE` with the D7 component/element type you want to handle (e.g.
`...element_email_alter`, `...element_select_alter`). Called from
`D7Webform::buildFormElements()` while assembling each element's YAML.

- `&$markup` (string) — the element's YAML markup string; append to it or rewrite it.
- `$indent` (string) — the current indentation string; prefix nested lines with it.
- `$element` (array) — the prepared source element array, keyed by machine name.

```php
function mymodule_webform_migrate_d7_webform_element_myfield_alter(&$markup, $indent, array $element) {
  // Map a custom/contrib D7 component onto a Webform element type.
  $markup .= "$indent  '#type': my_custom_webform_element\n";
  // Or fix up already-generated markup:
  $markup = str_replace('[from]', '[to]', $markup);
}
```

## `hook_webform_migrate_d6_webform_element_ELEMENT_TYPE_alter(&$markup, $indent, array $element)`

Identical contract for the Drupal 6 path, invoked from `D6Webform::buildFormElements()`.

Use these to add support for element types the module doesn't map out of the box, or to
correct the emitted YAML (default values, `#type`, options) for a specific element type.
These are the only hooks the module invites; there is no other API surface.
