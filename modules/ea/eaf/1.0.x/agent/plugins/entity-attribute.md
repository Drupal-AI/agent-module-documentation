<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `EntityAttribute` plugin type

EAF defines its own plugin type so each selectable attribute (a CSS class, a full-width toggle, an
alignment select, …) is a small, reusable plugin.

## Discovery & metadata

- **Namespace**: `Plugin/EntityAttribute` (in any module).
- **PHP attribute**: `Drupal\eaf\Attribute\EntityAttribute` — `#[EntityAttribute(id, label, settings)]`
  where `settings` is an array (supports `weight` and `parent`).
- **Legacy annotation**: `Drupal\eaf\Annotation\EntityAttribute` (`@EntityAttribute`) with `label`
  and `settings` — still supported for older plugins.
- **Interface**: `Drupal\eaf\EntityAttributePluginInterface`.
- **Base class**: `Drupal\eaf\EntityAttributePluginBase` (extends core `PluginBase`, implements
  `ContainerFactoryPluginInterface`; its `create()` injects the manager service).
- **Manager**: `Drupal\eaf\EntityAttributePluginManager`, service id **`eaf.eaf_plugin_manager`**
  (also autowirable by class name). Cache bin `entity_attribute_plugins`; alter hook for definitions
  is **`entity_setting_info`** (note: not `entity_attribute_info`).

## Manager API (`EntityAttributePluginManagerInterface`)

- `getAll(): array` — instantiate every plugin, keyed by id (logs and skips on `PluginException`).
- `getPluginById(string $id)` — wrapper over `createInstance()`.
- `getAttributeFormElements(): array` — build `[$id => $plugin->formElement()]` for all plugins,
  run the **`entity_attributes`** alter hook over the array, and cache it under
  `entity_attribute_plugins:settings_form` (`SETTINGS_FORM_STORAGE_CID`). Each element carries
  `#plugin` (the instance) so callers can reach the plugin from the element.
- `getSettingsFieldForm()` — **deprecated** alias of `getAttributeFormElements()` (removed in 2.0.0).

## Base class behavior (`EntityAttributePluginBase`)

- `formElement()` returns a base element with `#title` (label), `#default_value`
  (`getDefaultValue()`, default `NULL`), `#weight` (`getWeight()`, from `settings['weight']`, default
  0) and `#plugin => $this`.
- `prepareFormElement(array $element, $value)` maps a stored value onto a form element by
  `#subtype`/`#type`: `css`/`element-list` (space-join a cleaned class list via `getElementList()` /
  `getListFromString()` which `preg_split`s on whitespace/commas), `select`, `number` (with
  `#min`/`#max`), `checkboxes` (casts stdClass→array), and a default text case (`#size` 32).
- `setValue(mixed $value, array $attributes, ?string $section = NULL)` writes
  `$attributes[$section][$id]` (or `$attributes[$id]`) and returns the array. Subclasses override to
  normalize their own value first.
- Parent/subtype helpers: `getParentPluginId()`/`hasParentPlugin()`/`isPluginParent()`/`isSubtype()`
  read `settings['parent']`; a plugin with a `parent` is treated as a modifier of that parent plugin.
- `getValidationRulesDefinition()` returns `[]` by default (hook for future validation).

## Shipped plugins

### `entity_css_class` — `EntityCssClass`

`src/Plugin/EntityAttribute/EntityCssClass.php`. A `textfield` with `#subtype => 'css'` (description
*"Please separate multiple classes by spaces."*). Default value `''`.

`setValue()` explodes the input on spaces, maps **each** part through
`Html::cleanCssIdentifier()`, de-duplicates, stores the space-joined result under
`$attributes['classes']` **and** under the plugin id. So editor-entered classes are normalized to
valid CSS identifiers before storage.

`EntityAttributeTypesInterface::CSS_CLASS_SETTING_NAME = 'entity_class'` names the canonical CSS-class
setting (used as the `parent` id by modifier plugins).

### `full_width` — `FullWidth`

`src/Plugin/EntityAttribute/FullWidth.php`. A `checkbox` (description *"Stretch this paragraph to 100%
browser width."*), default `0`, `settings: { parent: "entity_class", weight: 10 }` — i.e. a modifier
of the CSS-class attribute. `setValue()` sets `$attributes['classes'] = ['full-width']` when checked,
else `[]`.

## Writing your own attribute plugin

```php
namespace Drupal\my_module\Plugin\EntityAttribute;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\eaf\Attribute\EntityAttribute;
use Drupal\eaf\EntityAttributePluginBase;

#[EntityAttribute(
  id: "text_align",
  label: new TranslatableMarkup("Text alignment"),
  settings: ["weight" => 20],
)]
class TextAlign extends EntityAttributePluginBase {

  public function formElement(): array {
    return [
      '#type' => 'select',
      '#subtype' => 'select',
      '#options' => ['left' => 'Left', 'center' => 'Center', 'right' => 'Right'],
    ] + parent::formElement();
  }

  public function getDefaultValue(): mixed {
    return 'left';
  }
}
```

After adding a plugin, rebuild caches (`drush cr`) and enable it in each field instance's settings.
Sanitize any free-text value you accept in your own `setValue()` (as `EntityCssClass` does) — the
base class stores whatever you return.
