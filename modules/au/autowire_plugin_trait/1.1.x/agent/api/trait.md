# AutowirePluginTrait — usage

`Drupal\autowire_plugin_trait\AutowirePluginTrait` supplies a static `create()` for any plugin
implementing `ContainerFactoryPluginInterface`. Add `use AutowirePluginTrait;` and remove your
own `create()`.

## How `create()` resolves each constructor parameter
It reflects over `__construct()` and, per parameter (matched by name), builds an arg array:
- `configuration` → the `$configuration` array
- `plugin_id` **or** `pluginId` → the plugin id
- `plugin_definition` **or** `pluginDefinition` → the plugin definition
- any other parameter → `$container->get(<service>)`, where `<service>` is the parameter's
  type-hint (leading `?` stripped), **unless** a `#[Autowire(service: '…')]` attribute on the
  parameter overrides it. If `$container->has(<service>)` is false → `AutowiringFailedException`.

The class is then instantiated with named args: `new static(...$args)`, so the **order** of the
constructor parameters does not matter.

If the class has **no** `__construct`, it falls back to
`new static($container, $configuration, $plugin_id, $plugin_definition)`.

## Example
```php
use Drupal\Core\Block\BlockBase;
use Drupal\Core\Entity\EntityTypeManagerInterface;
use Drupal\Core\Plugin\ContainerFactoryPluginInterface;
use Drupal\autowire_plugin_trait\AutowirePluginTrait;
use Symfony\Component\DependencyInjection\Attribute\Autowire;

class MyBlock extends BlockBase implements ContainerFactoryPluginInterface {
  use AutowirePluginTrait;

  public function __construct(
    array $configuration,
    $plugin_id,
    $plugin_definition,
    protected EntityTypeManagerInterface $entityTypeManager,
    #[Autowire(service: 'my_module.thing')] protected ThingInterface $thing,
  ) {
    parent::__construct($configuration, $plugin_id, $plugin_definition);
  }
  // No create() needed.
}
```

Notes:
- The type-hint must be a real service id (interfaces that map to a service, or an explicit
  `#[Autowire]`); value objects that are not services will fail to resolve.
- Resolution is by parameter name, then the instance is built with named arguments.
- Signature: `public static function create(ContainerInterface $container, array $configuration, $plugin_id, $plugin_definition): static`.

## 1.1.x / core 11.3
Unchanged trait vs 1.0.x. On Drupal 11.3+ this module is obsolete — core `PluginBase` provides
an equivalent autowired `create()`; stop using the trait and extend `PluginBase` normally.
