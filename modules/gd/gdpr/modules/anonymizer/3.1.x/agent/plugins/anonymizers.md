<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Anonymizer plugin type

## Plugin type definition

| Piece | Value |
|---|---|
| Manager service | `plugin.manager.anonymizer` (`AnonymizerPluginManager`) |
| Plugin namespace | `Plugin/Anonymizer` |
| Annotation | `@Anonymizer` (`Drupal\anonymizer\Annotation\Anonymizer`: `id`, `label`, `description`) |
| Interface | `Drupal\anonymizer\Anonymizer\AnonymizerInterface` |
| Base class | `Drupal\anonymizer\Anonymizer\AnonymizerBase` (injects `anonymizer.faker`) |
| Alter hook | `anonymizer_info` (`hook_anonymizer_info_alter(&$definitions)`) |

`AnonymizerInterface::anonymize($input, ?FieldItemListInterface $field = NULL)` returns the
anonymized value.

## Built-in anonymizers (10)

| id | Returns |
|---|---|
| `email_anonymizer` | `faker->unique()->safeEmail` |
| `username_anonymizer` | `faker->unique()->userName` |
| `text_anonymizer` | fake short text |
| `long_text_anonymizer` | fake long text |
| `random_text_anonymizer` | random text token |
| `number_anonymizer` | fake number |
| `date_anonymizer` | fake date |
| `password_anonymizer` | scrambled password |
| `uri_anonymizer` | fake URI |
| `clear_anonymizer` | empties the value |

## Services

- `anonymizer.faker` — `FakerService`, `->generator()` returns a `Faker\Generator`.
- `anonymizer.anonymizer_factory` — `AnonymizerFactory`, `->get($plugin_id)` returns an
  anonymizer instance (wraps the plugin manager).
- `plugin.manager.anonymizer` — `->getDefinitions()` / `->createInstance($id)`.

Use one directly:
```php
$value = \Drupal::service('anonymizer.anonymizer_factory')->get('email_anonymizer')->anonymize($old);
// or
$defs = array_keys(\Drupal::service('plugin.manager.anonymizer')->getDefinitions());
```

## Add a custom anonymizer

Create a plugin in your module at `src/Plugin/Anonymizer/PhoneAnonymizer.php`:

```php
namespace Drupal\my_module\Plugin\Anonymizer;

use Drupal\anonymizer\Anonymizer\AnonymizerBase;
use Drupal\Core\Field\FieldItemListInterface;

/**
 * @Anonymizer(
 *   id = "phone_anonymizer",
 *   label = @Translation("Phone anonymizer"),
 *   description = @Translation("Anonymizes phone numbers.")
 * )
 */
class PhoneAnonymizer extends AnonymizerBase {
  public function anonymize($input, FieldItemListInterface $field = NULL) {
    return $this->faker->generator()->phoneNumber;
  }
}
```

After enabling the module (and a cache rebuild) it appears in
`plugin.manager.anonymizer->getDefinitions()` and is selectable wherever anonymizers are used
(e.g. GDPR Fields, GDPR Dump). No config is needed to register it — discovery is by class +
annotation.
