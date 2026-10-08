# AutowirePluginTrait — usage

`Drupal\autowire_plugin_trait\AutowirePluginTrait` supplies a static `create()` for any plugin
implementing `ContainerFactoryPluginInterface`. Add `use AutowirePluginTrait;` and remove your
own `create()`.

## How `create()` resolves each constructor parameter
Reflecting over `__construct()`, per parameter (by name):
- `configuration` → the `$configuration` array
- `plugin_id` **or** `pluginId` → the plugin id
- `plugin_definition` **or** `pluginDefinition` → the plugin definition
- any other parameter → `$container->get(<service>)`, where `<service>` is the parameter's
  type-hint (leading `?` stripped), **unless** a `#[Autowire(service: '…')]` attribute on the
  parameter overrides it. Missing service → `AutowiringFailedException`.

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

Notes: the type-hint must be a real service id (interfaces that map to a service, or an
explicit `#[Autowire]`); value objects that are not services will fail to resolve. Order of
the four standard args does not matter — resolution is by name, then the instance is built
with named arguments.
