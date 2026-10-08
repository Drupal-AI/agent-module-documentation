# Setting type plugins (UiPatternsSettingType)

A **setting type** renders a config form element for a pattern setting and normalizes the
submitted value for the Twig template.

- Manager: `plugin.manager.ui_patterns_settings`
  (`\Drupal\ui_patterns_settings\UiPatternsSettingsManager`).
- Directory: `src/Plugin/UiPatterns/SettingType/`. Annotation:
  `@UiPatternsSettingType`. Interface: `PatternSettingTypeInterface`. Base:
  `PatternSettingTypeBase` (plus `ComplexSettingTypeBase`, `EnumerationSettingTypeBase`,
  `TokenSettingTypeBase`, `RoleCheckboxesSettingTypeBase`, `LanguageCheckboxesSettingTypeBase`).

## Built-in setting type ids

`textfield`, `select`, `radios`, `checkboxes`, `boolean`, `number`, `token`, `url`, `links`,
`attributes`, `machine_name`, `media_library`, `colorwidget`, `coloriswidget`, `enumeration`,
`value`, `group`, `publish`, `language_checkboxes`, `language_access`, `role_checkboxes`,
`role_access`.

You reference one by its id as the `type:` of a setting in the pattern YAML (see
[configure/settings-config.md](../configure/settings-config.md)).

## Implement a setting type

```php
namespace Drupal\my_module\Plugin\UiPatterns\SettingType;

use Drupal\ui_patterns_settings\Plugin\PatternSettingTypeBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * @UiPatternsSettingType(
 *   id = "stars",
 *   label = @Translation("Star rating"),
 * )
 */
class StarsSettingType extends PatternSettingTypeBase {
  public function buildConfigurationForm(array $form, FormStateInterface $form_state, $value) {
    $form['#type'] = 'number';
    $form['#min'] = 0; $form['#max'] = 5;
    $form['#default_value'] = $value;
    return $form;
  }
  public function settingsPreprocess($value, array $context) {
    return (int) $value;   // normalized value passed to Twig
  }
}
```

Add the class in the right namespace/annotation and clear caches — it is discovered as a
`DefaultPluginManager` plugin, no service registration needed.
