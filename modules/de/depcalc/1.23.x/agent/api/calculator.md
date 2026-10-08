# Calculating dependencies

## Core call

```php
use Drupal\depcalc\DependentEntityWrapper;
use Drupal\depcalc\DependencyStack;

$entity = \Drupal\node\Entity\Node::load(1);      // any content OR config entity
$wrapper = new DependentEntityWrapper($entity);
$stack = new DependencyStack();
$deps = \Drupal::service('entity.dependency.calculator')
  ->calculateDependencies($wrapper, $stack);
```

`$deps` is an associative array keyed by dependency **UUID** → `DependentEntityWrapper`, with an
extra `module` key holding the array of module machine names required. So a config entity like
image style `thumbnail` returns `{ '<uuid>' => DependentEntityWrapper(image_style:thumbnail),
'module' => [...] }`. Iterate wrappers to read `getEntityTypeId()`, `getId()`, `getUuid()`,
`getHash()`, `getModuleDependencies()`.

## Key classes

**`DependencyCalculator`** (service `entity.dependency.calculator`,
args `@event_dispatcher`, `@depcalc.logger_channel`)
- `calculateDependencies(DependentEntityWrapperInterface $wrapper, DependencyStack $stack, array &$dependencies = []): array`
- De-dups via the stack (won't process a UUID twice) and reuses cached results; on cache miss
  it dispatches `calculate_dependencies` so collectors add their dependencies.

**`DependentEntityWrapper`** — wraps one entity for the calculator:
`getEntity()`, `getId()`, `getUuid()`, `getEntityTypeId()`, `isConfigEntity()`, `getHash()`,
`getDependencies()`, `getModuleDependencies()`, `addDependency()`, `getRemoteUuid()/setRemoteUuid()`.
Constructor: `new DependentEntityWrapper($entity, $additional_processing = FALSE)`.

**`DependencyStack`** — accumulator / cache facade across a calculation:
`addDependency($wrapper, $cache = TRUE)`, `getDependency($uuid)`, `hasDependency($uuid)`,
`getDependencies()`, `getDependenciesByUuid(array $uuids)`, `ignoreConfig(bool)` /
`shouldIgnoreConfig()`, `ignoreCache(bool)`. Call `$stack->ignoreConfig()` before calculating
to skip config-entity dependencies.

**`FieldExtractor`** — helper the collectors use to pull fields out of an entity
(`getFieldsFromEntity()`), firing the `depcalc_filter_fields` event.

Results are cached in the `cache.depcalc` bin keyed by the wrapper's hash, so a second call for
the same unchanged entity is served from cache (see [../drush/commands.md](../drush/commands.md)).
Extend what counts as a dependency by adding an event subscriber — see [../hooks/events.md](../hooks/events.md).
