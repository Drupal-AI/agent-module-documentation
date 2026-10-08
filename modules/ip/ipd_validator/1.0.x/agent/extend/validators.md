<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using and extending ipd_validator

## Validate a document
```php
$manager = \Drupal::service('plugin.manager.ipd_validator');
/** @var \Drupal\ipd_validator\ValidatorInterface $validator */
$validator = $manager->createInstance('ar_dni_cuit_cuil'); // plugin id
if (!$validator->isValid($raw)) {
  // reject
}
$clean = $validator->format($raw);
```
Discover available plugins with `$manager->getDefinitions()`; each definition exposes `country_code` and `active`.

## Add a new country validator
Create a plugin in your own module:
```php
namespace Drupal\my_module\Plugin\Validator;

use Drupal\ipd_validator\ValidatorPluginBase;

/**
 * @Validator(
 *   id = "xx_id",
 *   title = @Translation("Xxland ID"),
 *   description = @Translation("Validates the Xxland national ID."),
 *   country_code = "XX",
 *   active = TRUE,
 * )
 */
final class XxIdValidator extends ValidatorPluginBase {
  public function isValid(string $document): bool { /* checksum logic */ }
  public function format(string $document): string { /* normalise */ }
}
```
The annotation keys are defined in `src/Annotation/Validator.php` (`id`, `title`, `description`, `country_code`, `active`). No changes to ipd_validator are needed — the plugin manager picks it up automatically.
