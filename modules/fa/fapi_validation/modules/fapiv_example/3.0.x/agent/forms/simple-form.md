<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The example form and custom validator

## Route & form

- Route `fapiv_example.simple_form` at `/fapi-example`, permission `fapiv access example page`, form
  `\Drupal\fapiv_example\Form\SimpleForm` (`getFormId()` → `fapiv_example_simple_form`, extends `FormBase`).
- `submitForm()` just prints the submitted title via `messenger()`; the point of the module is the field
  declarations, not the submit logic.

## Fields (each shows a rule form from the parent module)

| field | rule / filter declaration | demonstrates |
|-------|---------------------------|--------------|
| `title` | `#validators => ['rule' => 'length[5, *]']`, `#filters => ['uppercase', 'trim']` | minimum-only length + filters running before validation. |
| `name` | `#validators => [['rule' => 'length[7]', 'error' => 'Wrong name size of field %field.'], 'custom_validator']` | array rule with a custom `error` message, combined with a custom plugin. |
| `mail` | `#validators => ['email']` | plain-id validator. |
| `range` | `#validators => ['rule' => 'range[0, 100]']` | bracketed two-param rule. |
| `ip` | `#validators => ['ipv4']` | IPv4 validator. |
| `url` | `#validators => ['url[absolute]']` | parameterised URL (absolute) validator. |

All fields are `#required`. See the full rule syntax in the parent
[api/rules-and-engine.md](../../../3.0.x/agent/api/rules-and-engine.md).

## Custom validator: `custom_validator`

`\Drupal\fapiv_example\Plugin\FapiValidationValidator\MyCustomValidator` implements
`FapiValidationValidatorsInterface`:

```php
#[FapiValidationValidator(
  id: 'custom_validator',
  label: new TranslatableMarkup('Custom Validator'),
  description: new TranslatableMarkup('Field must have JohnDoe as value.'),
  error_callback: 'processError',
)]
class MyCustomValidator implements FapiValidationValidatorsInterface {
  public function validate(Validator $validator, array $element, FormStateInterface $form_state) {
    return $validator->getValue() == 'JohnDoe';
  }
  public static function processError(Validator $validator, array $element) {
    return \t("You must enter 'JohnDoe' as value and not '%value' at field %field", [
      '%value' => $validator->getValue(),
      '%field' => $element['#title'],
    ]);
  }
}
```

It shows the two authoring essentials: a boolean `validate()` and an `error_callback` naming a **public static**
method that returns the message. Because it lives under `Plugin/FapiValidationValidator`, the parent module's
manager discovers it automatically and it becomes usable by id in any form's `#validators`.
