<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tax Number — add a country validator

Validators are `TaxNumberWidget` plugins under `src/Plugin/TaxNumber/Widget/`, managed by `TaxNumberWidgetManager`.

```php
namespace Drupal\my_module\Plugin\TaxNumber\Widget;

use Drupal\tax_number\Plugin\TaxNumberWidgetBase;

/**
 * @TaxNumberWidget(
 *   id = "fr_widget",
 *   label = @Translation("French"),
 *   weight = 0
 * )
 */
class FrenchWidget extends TaxNumberWidgetBase {

  public function validateTaxNumber(\$value) {
    // Return TRUE if valid, FALSE otherwise. Pure PHP — no network calls.
    return (bool) preg_match('/^FR[0-9A-Z]{2}[0-9]{9}\$/', trim(strtoupper(\$value)));
  }
}
```

## Using validators
- **Field:** on the entity's *Manage form display*, the `tax_number` widget settings let you pick the validation plugin (`default_widget`, `es_widget`, `pt_widget`, or your own).
- **Webform:** add the *Tax number* element; choose the validator in the element settings.

## Bundled plugins
- `default_widget` — accepts any value (no country check).
- `es_widget` — Spanish NIF/CIF letter + checksum validation.
- `pt_widget` — Portuguese NIF validation.

Validation runs on submit; an invalid value fails field/element validation. No routes or permissions are involved.
