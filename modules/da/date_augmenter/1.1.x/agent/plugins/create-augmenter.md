<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing a DateAugmenter plugin

Place the class in your module's `src/Plugin/DateAugmenter/` directory, implement
`\Drupal\date_augmenter\Plugin\DateAugmenterInterface` (or extend `DateAugmenterBase` /
`DateAugmenter\DateAugmenterPluginBase`).

## Attribute (Drupal 10/11, recommended)

```php
namespace Drupal\my_module\Plugin\DateAugmenter;

use Drupal\date_augmenter\Attribute\DateAugmenter;
use Drupal\date_augmenter\Plugin\DateAugmenterBase;
use Drupal\Core\Datetime\DrupalDateTime;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[DateAugmenter(
  id: 'my_augmenter',
  label: new TranslatableMarkup('My Augmenter'),
  description: new TranslatableMarkup('Does something useful to date output.'),
  weight: 0,
)]
class MyAugmenter extends DateAugmenterBase {

  public function augmentOutput(array &$output, DrupalDateTime $start, ?DrupalDateTime $end = NULL, array $options = []): void {
    // Mutate $output (a render array) in place; e.g. append a link, note, or calendar button.
  }

}
```

Attribute fields (`Attribute/DateAugmenter.php`): `id` (string), `label` (TranslatableMarkup),
`description` (nullable), `weight` (int — relative ordering hint in the Field UI).

## Annotation (legacy, Drupal 9)

```php
/**
 * @DateAugmenter(
 *   id = "my_augmenter",
 *   label = @Translation("My Augmenter"),
 *   description = @Translation("Does something useful to date output."),
 *   weight = 0,
 * )
 */
```

## The interface method

`augmentOutput(array &$output, DrupalDateTime $start, ?DrupalDateTime $end = NULL, array $options = [])`
— `$output` is the existing date render array (modify by reference), `$start`/`$end` the
`DrupalDateTime` bounds, `$options` extra guidance (e.g. third-party settings passed by the
formatter).

## Making it configurable

To expose a settings form for the augmenter, also implement Drupal core's `PluginFormInterface`
plus `\Drupal\date_augmenter\Plugin\ConfigurablePluginInterface` (or extend
`DateAugmenter\DateAugmenterPluginBase`). The module ships `PluginFormTrait` with default
`validateConfigurationForm()` / `submitConfigurationForm()` implementations. When configurable, the
augmenter's `configurationFields()` output is embedded in a vertical-tab details element in the
formatter settings form, and its values are saved under
`third_party_settings.date_augmenter[...settings][<augmenter_id>]`.

## Altering discovered plugins

`hook_date_augmenter_plugin_info(array &$definitions)` (the manager's `alterInfo` id
`date_augmenter_plugin_info`) lets other modules change or remove augmenter definitions.
