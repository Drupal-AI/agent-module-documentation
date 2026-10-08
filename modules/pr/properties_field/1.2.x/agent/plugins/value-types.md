<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Value type plugins (`@PropertiesValueType`)

Each property row picks a **value type**, a plugin that controls the value's input widget, formatter settings and render. This is the only plugin type the module defines.

- Manager service: `plugin.manager.properties_value_type` (`PropertiesValueTypeManager`, extends `DefaultPluginManager`).
- Discovery: annotation `@PropertiesValueType(id, label)` in namespace `Plugin/PropertiesValueType`.
- Interface: `PropertiesValueTypeInterface` (extends `ConfigurableInterface`); base class `PropertiesValueTypeBase`.
- Alter hook: `hook_properties_value_type_alter()`. Cache bin key `properties_value_type`.

## Built-in plugins

| ID | Label | Widget control | Stored value | Render |
|---|---|---|---|---|
| `string` | String | textfield (no maxlength) | string | raw string (autoescaped) |
| `Integer` | Integer | number, step 1 | int | raw |
| `decimal` | Decimal | number, step 0.01 | float | `number_format` with configurable decimal/thousands separators |
| `size` | Size | number + unit select (cm/m/km/inch/feet/mile) | `['value','unit']` | formatted number + unit label |
| `weight` | Weight | number + unit select (gr/kg) | `['value','unit']` | formatted number + unit label |

Note the `Integer` plugin ID is capitalised. `size` and `weight` extend `decimal`, so they inherit its `decimal_separator` / `thousands_separator` formatter settings (defaults `.` and space).

## Writing a new value type

Create `src/Plugin/PropertiesValueType/MyType.php` in your module, extend `PropertiesValueTypeBase`, and override only what you need:

```php
namespace Drupal\my_module\Plugin\PropertiesValueType;

use Drupal\Core\Form\FormStateInterface;
use Drupal\properties_field\PropertiesValueType\PropertiesValueTypeBase;

/**
 * @PropertiesValueType(
 *   id = "boolean",
 *   label = @Translation("Yes / No"),
 * )
 */
class BooleanValueType extends PropertiesValueTypeBase {

  public function widgetForm(array $element, $value, FormStateInterface $form_state) {
    $element['#type'] = 'checkbox';
    $element['#default_value'] = (bool) $value;
    return $element;
  }

  public function formatterRender($value) {
    return $value ? $this->t('Yes') : $this->t('No');
  }
}
```

Overridable hooks (all optional, defaults in `PropertiesValueTypeBase`):

- `defaultConfiguration()` — per-type config defaults (used for formatter settings).
- `widgetForm($element, $value, $form_state)` — return the value input render element (default: textfield).
- `widgetSettingsForm()` / `widgetSettingsSummary()` — widget-level settings for this type.
- `formatterSettingsForm()` / `formatterSettingsSummary()` — formatter-level settings (see `decimal`).
- `formatterRender($value)` — string / markup / render array shown by the formatters (default: return the value as-is).

The plugin's config is instantiated with the formatter's stored `value_types[<id>]` settings, so `$this->configuration` holds the admin's choices during render.
