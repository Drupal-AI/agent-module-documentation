<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing an Extra Field Plus display plugin

## Where & how

Place the plugin at `your_module/src/Plugin/ExtraField/Display/YourField.php`. Discovery and
the annotation come from **Extra Field** (`@ExtraFieldDisplay`); Extra Field Plus supplies the
base classes that add the settings layer.

Pick a base class:

| Base class | Output |
|---|---|
| `ExtraFieldPlusDisplayBase` | raw render array from `view()` (no field wrapper) |
| `ExtraFieldPlusDisplayFormattedBase` | wrapped in the standard field template; implement `viewElements()`, `getLabel()`, `getLabelDisplay()` |

## Required + optional methods

Implement two **static** methods for settings, plus the render method for your base:

```php
namespace Drupal\your_module\Plugin\ExtraField\Display;

use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\extra_field_plus\Plugin\ExtraFieldPlusDisplayBase;

/**
 * @ExtraFieldDisplay(
 *   id = "my_summary",
 *   label = @Translation("My summary"),
 *   bundles = { "node.*" },
 *   visible = false
 * )
 */
class MySummary extends ExtraFieldPlusDisplayBase {

  // The FAPI settings elements shown on Manage display (STATIC).
  protected static function extraFieldSettingsForm(): array {
    $form = parent::extraFieldSettingsForm();
    $form['wrapper'] = [
      '#type' => 'select',
      '#title' => t('Wrapper'),
      '#options' => ['span' => 'span', 'p' => 'p', 'h2' => 'h2'],
    ];
    $form['link_to_entity'] = ['#type' => 'checkbox', '#title' => t('Link to the entity')];
    return $form;
  }

  // Defaults for those settings (STATIC).
  protected static function defaultExtraFieldSettings(): array {
    return parent::defaultExtraFieldSettings() + [
      'wrapper' => 'span',
      'link_to_entity' => FALSE,
    ];
  }

  // Optional: a summary line next to the cog (STATIC).
  protected static function settingsSummary(string $field_id, string $entity_type_id, string $bundle, string $view_mode = 'default'): array {
    return [
      t('Wrapper: @w', ['@w' => self::getExtraFieldSetting($field_id, 'wrapper', $entity_type_id, $bundle, $view_mode)]),
    ];
  }

  // Render — read the configured settings for THIS entity instance.
  public function view(ContentEntityInterface $entity) {
    $settings = $this->getEntityExtraFieldSettings();   // ['wrapper' => …, 'link_to_entity' => …]
    return [
      '#type' => 'html_tag',
      '#tag' => $settings['wrapper'],
      '#value' => $entity->label(),
    ];
  }
}
```

For `ExtraFieldPlusDisplayFormattedBase`, replace `view()` with `viewElements()` and add
`getLabel()` / `getLabelDisplay()` (see the example module's `ExampleNodeLabelFormatted`).

## 3.x method names (breaking change from 1.x/2.x)

| Old (1.x/2.x) | New (3.x) |
|---|---|
| `protected function settingsForm()` | `protected static function extraFieldSettingsForm()` |
| `protected static function defaultFormValues()` | `protected static function defaultExtraFieldSettings()` |

The old method names are deprecated shims in `ExtraFieldPlusDisplayTrait` and removed in 4.x.
`settingsSummary()` is optional (default: "This extra field has settings").

## After adding the plugin

`drush cr`, then go to the bundle's *Manage display*
(`/admin/structure/types/manage/<bundle>/display`), drag the extra field out of Disabled, and
click its cog to set the values. It appears in the plugins report at `/admin/reports/extra_fields`.
