<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `extra_field` plugin type

efap turns Drupal display "extra fields" (pseudo-fields on *Manage display*) into a discoverable
plugin type. All logic is in five small files.

## The plugin manager

`src/ExtraFieldPluginManager.php` — `ExtraFieldPluginManager extends DefaultPluginManager`.
Registered as service **`efap.plugin_manager`** (`efap.services.yml`, `parent: default_plugin_manager`).
Its constructor calls `parent::__construct()` with:

- subdirectory **`Plugin/ExtraField`** — plugins live in each module's `src/Plugin/ExtraField/…`;
- interface `ExtraFieldInterface::class`;
- annotation `ExtraField::class`.

So any module's `src/Plugin/ExtraField/*` class annotated `@ExtraField` and implementing
`ExtraFieldInterface` is auto-discovered. Discovery is cached like any annotated plugin (rebuild
with `drush cr` after adding/changing a plugin).

## The contract

`src/ExtraFieldInterface.php` — two methods:

- `info(): array` — returns the array structure that `hook_entity_extra_field_info()` expects,
  i.e. `$info[$entity_type][$bundle]['display'][$id] = ['label'=>…, 'description'=>…, 'weight'=>…, 'visible'=>…]`.
- `view(array &$build, EntityInterface $entity, EntityViewDisplayInterface $display, $viewMode): array`
  — returns a render array for the field.

`src/Annotation/ExtraField.php` — `ExtraField extends \Drupal\Component\Annotation\Plugin` (empty
body). In practice the annotation carries `id`, `label`, `description` (see the scaffold template).

## The base class

`src/ExtraFieldBase.php` — `abstract ExtraFieldBase extends PluginBase implements ExtraFieldInterface`.
It leaves `info()` abstract but provides a default `view()` returning:

```php
['#type' => 'container', '#attributes' => ['class' => [Html::cleanCssIdentifier($this->pluginDefinition['id']), 'extra-field']]]
```

i.e. an empty container with a CSS class derived from the plugin id plus `extra-field`. Subclasses
typically call `parent::view(...)` then add their content into that array.

## How the hooks wire plugins into displays (`efap.module`)

- `efap_entity_extra_field_info()` — loads `efap.plugin_manager`, iterates
  `$manager->getDefinitions()`, does `createInstance($definition['id'])` for each, and
  `array_merge_recursive`es every plugin's `info()`. Result: each plugin's extra field appears on the
  matching entity/bundle *Manage display* form.
- `efap_entity_view()` — for each definition, if `$display->getComponent($definition['id'])` is set
  (the site builder enabled the component on that view display), it instantiates the plugin and sets
  `$build[$id] = $instance->view($build, $entity, $display, $view_mode)`.

So a field renders only when it is both (a) declared by a plugin's `info()` and (b) enabled on the
active view display. `info()` defaults `visible => FALSE`, so it is hidden until a builder turns it on.

## Writing a plugin (minimal)

1. `drush en efap` (or add `efap` to your module's dependencies).
2. Create `src/Plugin/ExtraField/<Entity>/<Class>.php` in your module (subfolder is by convention
   the entity type, but discovery is recursive so the folder name is cosmetic).
3. Extend `ExtraFieldBase`, annotate, implement `info()` and `view()`:

```php
namespace Drupal\my_module\Plugin\ExtraField\Node;

use Drupal\Core\Entity\Display\EntityViewDisplayInterface;
use Drupal\Core\Entity\EntityInterface;
use Drupal\efap\ExtraFieldBase;

/**
 * @ExtraField(
 *   id = "my_module__hello",
 *   label = @Translation("Hello"),
 *   description = @Translation("Says hello"),
 * )
 */
class Hello extends ExtraFieldBase {

  public function info(): array {
    $field['node']['article']['display'][$this->pluginDefinition['id']] = [
      'label' => $this->pluginDefinition['label'],
      'description' => $this->pluginDefinition['description'],
      'weight' => 0,
      'visible' => FALSE,
    ];
    return $field;
  }

  public function view(array &$build, EntityInterface $entity, EntityViewDisplayInterface $display, $viewMode): array {
    $output = parent::view($build, $entity, $display, $viewMode);
    $output['content'] = ['#markup' => $this->t('Hello from @label', ['@label' => $entity->label()])];
    return $output;
  }
}
```

4. `drush cr`, then enable the field on the entity's *Manage display* and position it.

To inject services, implement `ContainerFactoryPluginInterface` on the plugin (the scaffold template
generates the `__construct`/`create` pair for you — see
[tools/generate-command.md](../tools/generate-command.md)).

## Notes

- Any data a plugin's `view()`/`info()` renders is developer-authored; use standard render-array
  escaping (`#markup` is filtered; pass user/entity data through proper render elements or
  `t()`/`Html::escape()`), and apply entity/field access in the plugin as you would in any hook — efap
  performs no escaping or access control on your behalf.
- efap ships **no** config, schema, permissions, routes, or install file; enabling it does nothing
  visible until a module provides plugins.
