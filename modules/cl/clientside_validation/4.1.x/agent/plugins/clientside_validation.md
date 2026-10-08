# Plugin type — `CvValidator`

The module defines an annotated plugin type for validation rules.

- **Manager service:** `plugin.manager.clientside_validation.validators`
  (`Drupal\clientside_validation\ValidatorManager`, extends `DefaultPluginManager`).
- **Discovery namespace:** `Plugin/CvValidator` in any module.
- **Interface:** `Drupal\clientside_validation\CvValidatorInterface`
  (base class `CvValidatorBase`).
- **Annotation:** `Drupal\clientside_validation\Annotation\CvValidator`.
- **Alter hook:** `clientside_validation_validator_info` (see hooks doc).
- **Cache:** definitions cached under `clientside_validation_validators`.

## How matching works

`ValidatorManager::getDefinitionsForElement()` selects a plugin when the element's `#type` is in
`supports.types`, **or** a name in `supports.attributes` is present as `#<attr>` or
`#attributes[<attr>]`. Matching plugins are instantiated and their `addValidation()` runs.

## Annotation fields (`Annotation/CvValidator`)

| Field | Meaning |
|---|---|
| `id` | plugin id, e.g. `required` |
| `name` | `@Translation` label |
| `supports` | `{ "types" = {...}, "attributes" = {...} }` — what elements it applies to |
| `attachments` | `#attached` array merged onto the element (e.g. `{ "library" = {"mymodule/foo"} }`) |

## Implement a validator

Put this in `mymodule/src/Plugin/CvValidator/Phone.php`:

```php
namespace Drupal\mymodule\Plugin\CvValidator;

use Drupal\clientside_validation\CvValidatorBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * @CvValidator(
 *   id = "phone",
 *   name = @Translation("Phone"),
 *   supports = { "attributes" = {"data-phone"} },
 *   attachments = { "library" = {"mymodule/cv.phone.method"} }
 * )
 */
class Phone extends CvValidatorBase {
  protected function getRules($element, FormStateInterface $form_state) {
    return [
      'rules'    => ['phone' => TRUE],
      'messages' => ['phone' => $this->t('@t is not a valid phone number.', [
        '@t' => $this->getElementTitle($element),
      ])],
    ];
  }
}
```

`CvValidatorBase::addValidation()` turns each `getRules()` entry into `data-rule-phone` /
`data-msg-phone` attributes (array/object rule args are JSON-encoded) and merges the plugin's
`attachments` into the element's `#attached`. Helpers you get for free: `getAttributeValue()`,
`getElementTitle()`. The rule name must match a jQuery Validate method (register custom methods in
your attached JS via `$.validator.addMethod(...)`), which is why validators that need JS point
`attachments.library` at a library that depends on `clientside_validation_jquery/jquery.validate`.
