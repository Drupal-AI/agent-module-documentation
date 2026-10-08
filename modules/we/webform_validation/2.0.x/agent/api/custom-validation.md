<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works / extending

All logic lives in `Drupal\webform_validation\Validate\WebformValidateConstraint` plus a few
hooks in `webform_validation.module`. There are no services and no plugin types.

## Wiring (hooks in `webform_validation.module`)

| Hook | Role |
|---|---|
| `hook_webform_element_default_properties_alter()` | Declares the default property keys on supported elements (`equal__*`, `compare__*`, `some_of_several__*`). |
| `hook_webform_element_configuration_form_alter()` | Builds the "Form extra validation" fieldset; populates the component `#options` from the webform's other elements. |
| `hook_form_webform_ui_element_form_alter()` | Adds `WebformValidateConstraint::validateBackendComponents` to the element-config form `#validate` (config-time checks). |
| `hook_webform_submission_form_alter()` | Appends `WebformValidateConstraint::validate` to the submission form `#validate`, and `formSubmitPrevious` to the wizard "Previous" button. |

Note the submission alter also force-hides `$form['elements']['page1']['mark1']` (`#access = FALSE`).

## Runtime validation

`WebformValidateConstraint::validate($form, $formState)` → `validateElements()` recurses over
every element and, per element, dispatches:

- `#equal__enabled` → `validateFrontEqualComponent()` (handles one-to-one / one-to-many /
  many-to-many multi-value comparisons; tracks a `visited` list in form storage).
- `#compare__enabled` → `validateFrontCompareComponent()` (operator switch on `> >= < <=`;
  uses `min()`/`max()` of each side; shows `#compare__custom_error` if set).
- `#some_of_several__enabled` → `validateFrontSomeSeveralComponent()` (parses the
  `>=N` / `=N` / `<=N` requirement via `parseSomeOfSeveralCompleted()`).

## Adding your own validator

There is no plugin API — extend it the same way the module does: implement the two element
hooks in your module (add your property + form widget), then add your own callback to
`$form['#validate']` in `hook_webform_submission_form_alter()` that reads your property off
each element (via `#webform_key` and your `#my__*` properties) and calls
`$formState->setError($element, ...)`. Reuse `WebformValidateConstraint::ALLOWED_TYPES` to
decide which element types your rule should apply to.

## Reading configured rules in code

```php
$webform = \Drupal\webform\Entity\Webform::load('contact');
$el = $webform->getElementDecoded('confirm_email'); // raw element array with # properties
$enabled = !empty($el['#equal__enabled']);
$against = $el['#equal__components'] ?? [];
```
