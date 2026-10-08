# The `entity_type_behavior` plugin type

Define a behavior = a config form (per bundle) + a values form (per entity) + optional render `view()`.

## Wiring

- Manager: `plugin.manager.entity_type_behavior` → `EntityTypeBehaviorManager` (extends
  `DefaultPluginManager`), discovers `Plugin/EntityTypeBehavior/`, annotation `@EntityTypeBehavior`,
  interface `EntityTypeBehaviorInterface`. Alter hook `hook_entity_type_behavior_info_alter`.
  `getDefinitions()` sorts by the `weight` element; `getDefinitionsByEntityType($type)` returns behaviors
  whose annotation `entityTypes` is empty (all) or contains `$type`.
- Base class: `EntityTypeBehaviorBase` (extends `PluginBase`, implements
  `ContainerFactoryPluginInterface`).

## Annotation properties (`src/Annotation/EntityTypeBehavior.php`)

| Property | Meaning |
|---|---|
| `id` | Plugin id (used as the config/values array key and in hook names). |
| `label` | Translated label (shown as the details title in the widget). |
| `description` | Plugin description. |
| `weight` | Sort/render weight (int). |
| `entityTypes` | Array of entity type ids this behavior applies to; empty/omitted = all fieldable types. |

## Plugin API (`EntityTypeBehaviorInterface` / base defaults)

| Method | Role |
|---|---|
| `getForm(): array` | The **values** form shown to editors on the entity form (per entity). Default `[]`. |
| `getConfigForm(): array` | The **config** form shown on the entity-type/bundle settings (per bundle). Default `[]`. |
| `massageValues($values, $form, $form_state): array` | Normalize editor values before storage. Default: unchanged. |
| `massageConfig($config, $form, $form_state): array` | Normalize config before storage. Default: unchanged. |
| `getValues(): array` / `getValueByKey($key)` | Read stored editor values (`$this->configuration['values']`). |
| `getConfig(): array` / `getConfigValue($key)` | Read stored bundle config (`$this->configuration['config']`). |
| `getEntityTypeId(): ?string` / `getBundle(): ?string` | Context the plugin was instantiated with. |
| `view(array &$build, EntityInterface $entity, EntityViewDisplayInterface $display, $view_mode)` | Optional direct render-array mutation at view time. Default no-op. |

Plugins are instantiated with a configuration array of `entity_type`, `bundle`, `config`, and `values`
(see the widget and `EntityTypeBehaviorHelper`).

## Minimal plugin

```php
namespace Drupal\my_module\Plugin\EntityTypeBehavior;

use Drupal\entity_type_behaviors\EntityTypeBehaviorBase;

/**
 * @EntityTypeBehavior(
 *   id = "bg_color",
 *   label = @Translation("Background color"),
 *   description = "Pick a background color.",
 *   entityTypes = {"node", "media"}
 * )
 */
class BgColor extends EntityTypeBehaviorBase {

  // Per-entity values form (editors).
  public function getForm(): array {
    return ['bg_color' => [
      '#type' => 'textfield',
      '#title' => $this->t('Background color'),
      '#default_value' => $this->getValueByKey('bg_color') ?? '',
    ]];
  }

  // Optional per-bundle config form (site builders).
  // public function getConfigForm(): array { ... }

  // Optional direct render alter (or use the alter hooks — see hooks/preprocess.md).
  // public function view(array &$build, $entity, $display, $view_mode) { ... }
}
```

Read the values back at render time in `view()` or in a `hook_entity_type_behaviors_alter__bg_color()`
implementation (see [../hooks/preprocess.md](../hooks/preprocess.md)). The shipped
`entity_type_behaviors_example` submodule has fuller examples including a config-restricted color list.
