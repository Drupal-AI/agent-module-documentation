# Events (extending calculation)

Depcalc is event-driven; extend it by tagging an `event_subscriber` service. Constants live in
`Drupal\depcalc\DependencyCalculatorEvents`.

| Constant | String | Event object | Use |
|---|---|---|---|
| `CALCULATE_DEPENDENCIES` | `calculate_dependencies` | `CalculateEntityDependenciesEvent` | Add dependencies for an entity/field type |
| `FILTER_FIELDS` | `depcalc_filter_fields` | `FilterDependencyCalculationFieldsEvent` | Include/exclude fields before extraction |
| `FILTER_CONFIG_ENTITIES` | `depcalc_filter_config_entities` | `FilterDependencyConfigEntityEvent` | Filter which config entities count |
| `SECTION_COMPONENT_DEPENDENCIES_EVENT` | `section_component_dependencies_event` | `SectionComponentDependenciesEvent` | Layout Builder component deps |
| `INVALIDATE_DEPENDENCIES` | `depcalc_invalidate_dependencies` | `InvalidateDependenciesEvent` | React to a dependency being invalidated |
| `INVALIDATE_DEPCALC_CACHE` | `invalidate_depcalc_cache` | `InvalidateDepcalcCacheEvent` | Invalidate an entity + tagged deps |
| `HASH_CALCULATION` | `hash_calculation` | `CalculateHashEvent` | Skip hashing specific fields |

## The main event

`CalculateEntityDependenciesEvent` (dispatched by `DependencyCalculator` on cache miss):
`getWrapper()`, `getEntity()`, `getStack()`, `addDependency(DependentEntityWrapper)`,
`setDependencies(...)`, `getDependencies()`, `getModuleDependencies()`,
`setModuleDependencies(array)`.

## Add a collector

```php
# my_module.services.yml
services:
  my_module.dep_collector:
    class: Drupal\my_module\EventSubscriber\MyCollector
    tags: [{ name: event_subscriber }]
```

```php
use Drupal\depcalc\DependencyCalculatorEvents;
use Drupal\depcalc\Event\CalculateEntityDependenciesEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyCollector implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [DependencyCalculatorEvents::CALCULATE_DEPENDENCIES => 'onCalculate'];
  }
  public function onCalculate(CalculateEntityDependenciesEvent $event): void {
    $entity = $event->getEntity();
    // Inspect $entity, then for each referenced entity:
    //   $event->addDependency(new \Drupal\depcalc\DependentEntityWrapper($referenced));
    // and/or $event->setModuleDependencies(['my_module']);
  }
}
```

The many built-in `EventSubscriber/DependencyCollector/*` classes (e.g.
`EntityReferenceFieldDependencyCollector`, `ConfigEntityDependencyCollector`,
`LayoutBuilderFieldDependencyCollector`, `TextItemFieldDependencyCollector`,
`MenuItemContentDependencyCollector`, `PathAliasEntityCollector`) are the reference examples.
