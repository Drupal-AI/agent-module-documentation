# Hooks — `clientside_validation.api.php`

## `hook_clientside_validation_should_validate($element, FormStateInterface &$form_state, $form_id)`

Return `FALSE` to skip client-side validation for a given element/form. Invoked from
`clientside_validation_should_validate()` for every element before validators are gathered — so
use it to opt specific forms or element types out.

```php
function mymodule_clientside_validation_should_validate($element, \Drupal\Core\Form\FormStateInterface &$form_state, $form_id) {
  if ($form_id === 'my_special_form') {
    return FALSE; // don't add client-side validation to this form
  }
}
```

## `hook_clientside_validation_validator_info_alter(array &$validators)`

Alter the discovered `CvValidator` plugin definitions (keyed by plugin id) — e.g. attach an extra
JS library to every validator. This is exactly how the jQuery submodule injects its engine:
`clientside_validation_jquery_clientside_validation_validator_info_alter()` appends
`clientside_validation_jquery/cv.jquery.validate` (plus CKEditor / Inline Form Errors libraries
when those modules are on) to every validator's `attachments.library`.

```php
function mymodule_clientside_validation_validator_info_alter(array &$validators) {
  foreach ($validators as &$validator) {
    $validator['attachments']['library'][] = 'mymodule/extra_methods';
  }
}
```

The alter hook name is `clientside_validation_validator_info` (registered by
`ValidatorManager::alterInfo()`).
