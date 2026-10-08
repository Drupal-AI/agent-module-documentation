<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rule syntax, the engine, and custom plugins

## How rules attach to a form element

Add either or both keys to any input element in `buildForm()`:

```php
$form['myfield'] = [
  '#type' => 'textfield',
  '#title' => 'My Field',
  '#required' => TRUE,
  '#validators' => [
    'email',
    'length[10, 50]',
    ['rule' => 'alpha_numeric', 'error' => 'Please, use only alpha numeric characters at %field.'],
    ['rule' => 'match_field[otherfield]', 'error callback' => 'mymodule_validation_error_msg'],
  ],
  '#filters' => ['trim', 'uppercase'],
];
```

`hook_element_info_alter` (in `fapi_validation.module`) attaches
`FapiValidationService::process` to every `#input` element's `#process`. At build time `process()`
(`src/FapiValidationService.php`) wires the module's callbacks into `#element_validate`: `filter` is
`array_unshift`ed (runs first, so validators see the filtered value) and `validate` is appended. If the element
has neither `#filters` nor `#validators`, nothing is added.

## Rule string forms (parsed by `src/Validator.php`)

Each entry in `#validators` is one of:

- A **plain id**: `'email'`, `'alpha'`, `'ipv4'`.
- An **id with bracketed params**: `'length[10, 50]'`, `'range[0, 100]'`, `'chars[a, b, c]'`,
  `'regexp[/^\d+$/]'`. `Validator::parse()` matches `^(.*?)(\[(.*)\])?$`; the name is group 1, params are group 3.
- An **array** with a `'rule'` key plus optional `'error'` (a message string) and/or `'error callback'`
  (a callable name). Missing `'rule'` throws `\LogicException`.

Parameter splitting: for most rules params are `preg_split('/ *, */', ...)` (comma-separated). The **`regexp`**
rule is special-cased — its entire bracket body is taken as a single parameter so commas inside the pattern are
preserved. `#filters` entries are always plain string ids (no params, no array form).

`Validator` is a value object exposing `getName()`, `getValue()`, `getParams()`, `hasErrorMessageDefined()`,
`getErrorMessage()`, `hasErrorCallbackDefined()`, `getErrorCallback()`.

## The validator engine (`FapiValidationValidatorsManager::validate()`)

For an element:

1. Skips only when the site's `fapi_validation.settings:bypass` flag is TRUE **and** the current user holds the
   `bypass fapi validations` permission — otherwise every declared rule runs (see
   [../config/settings.md](../config/settings.md) for the bypass model, an intended admin/trusted capability).
2. If the element is not `#required` and its value is empty/whitespace, validation is skipped for it.
3. For each rule: builds a `Validator`, confirms the plugin id exists (`hasValidator()`; otherwise throws
   `ValidatorException`), instantiates the plugin, and calls `validate(Validator, $element, $form_state)`.
4. On a FALSE return, resolves the error message via `processErrorMessage()` and calls `$form_state->setError()`.

Error-message precedence in `processErrorMessage()`: per-rule `error callback` → per-rule `error` → plugin
attribute `error_callback` → plugin attribute `error_message` → a generic fallback. `%field` is replaced with the
element `#title`.

## The filter engine (`FapiValidationFiltersManager::filter()`)

For each id in `#filters`: confirms the filter exists (else `ValidatorException`), instantiates it, calls
`filter($value)` with the current `$form_state` value, then writes the result back to both `$element['#value']`
and `$form_state`. Filters therefore mutate the submitted value in place.

## Writing a custom validator

Drop a class in `<your_module>/src/Plugin/FapiValidationValidator/`:

```php
namespace Drupal\my_module\Plugin\FapiValidationValidator;

use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\fapi_validation\Attribute\FapiValidationValidator;
use Drupal\fapi_validation\FapiValidationValidatorsInterface;
use Drupal\fapi_validation\Validator;

#[FapiValidationValidator(
  id: 'custom_validator',
  label: new TranslatableMarkup('Custom Validator'),
  error_message: "Type 'custom value' at field %field.",
)]
class MyCustomValidator implements FapiValidationValidatorsInterface {
  public function validate(Validator $validator, array $element, FormStateInterface $form_state) {
    return $validator->getValue() == 'custom value';
  }
}
```

Use `error_callback: 'processError'` (a **public static** method `processError(Validator $v, array $element)`
returning a string) instead of `error_message` for computed messages. Then reference it by id:
`'#validators' => ['custom_validator']`. Plugins may implement `ContainerFactoryPluginInterface` for DI (see the
core `machine_name` filter). Both the PHP attribute and the legacy `@FapiValidationValidator` annotation are
accepted (the managers register both discovery mechanisms).

## Writing a custom filter

Drop a class in `<your_module>/src/Plugin/FapiValidationFilter/` with the `FapiValidationFilter` attribute and a
`filter($value): string` method (interface `FapiValidationFiltersInterface`), then reference the id in
`#filters`.
