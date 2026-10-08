# Preprocess services — the PHP API

## The service you write

Every preprocess service extends `PreprocessServiceBase` and overrides `preprocess()`. The base
class implements `PreprocessServiceInterface`, which `extends CacheableDependencyInterface`.

```php
namespace Drupal\my_module\PreprocessService;

use Drupal\entity_preprocess_services\PreprocessService\PreprocessServiceBase;

class MyNodePreprocessService extends PreprocessServiceBase {

  public function preprocess(): array {
    // $this->entity, $this->viewMode, $this->variables are populated for you.
    $this->variables['my_var'] = 'value derived from ' . $this->entity->label();
    // Return the (possibly modified) variables. parent::preprocess() returns $this->variables.
    return parent::preprocess();
  }

}
```

Then register it in `my_module.services.yml` with the `entity_preprocess_service` tag and
`applies_to` (see [../plugins/preprocess-service.md](../plugins/preprocess-service.md)). Because it is
an ordinary service you can add constructor `arguments:` and inject anything from the container — the
whole point of the module over a procedural `hook_preprocess_HOOK`.

## Interface contract — `PreprocessServiceInterface`

`Drupal\entity_preprocess_services\PreprocessService\PreprocessServiceInterface`

| Method | Purpose |
|---|---|
| `preprocess(): array` | Do the work; return the variables array that replaces `$variables`. |
| `setEntity(EntityInterface $entity): self` | Called by the manager with the current entity. |
| `setViewMode(string $viewMode): self` | Called by the manager with the current view mode. |
| `setVariables(array &$variables): self` | Called by the helper with the template variables. |
| `setCacheableMetadata(CacheableMetadata $cm): self` | Called by the helper with a fresh metadata bag. |
| `getCacheContexts()` / `getCacheTags()` / `getCacheMaxAge()` | From `CacheableDependencyInterface`. |

`PreprocessServiceBase` provides all setters (fluent, storing into protected `$entity`, `$viewMode`,
`$variables`, `$cacheableMetadata`) and a default `preprocess()` that just returns `$this->variables`
unchanged. The base cache defaults are `getCacheContexts() => []`, `getCacheTags() => []`,
`getCacheMaxAge() => CacheBackendInterface::CACHE_PERMANENT`. Override those methods (or add
cacheability inside `preprocess()`) if your logic varies per user/URL/etc.

The base class also declares two public properties, `public $applies_to;` and `public $excludes;` —
these exist only so the container's `properties:` YAML has somewhere to write; the runtime matching
does **not** read them off the object (it reads the flattened definitions built at compile time).

## The manager service — `entity_preprocess_services.manager`

`Drupal\entity_preprocess_services\EntityPreprocessServicesManager` (constructor arg
`@service_container`). Two methods matter:

- `addEntityPreprocessServices(array $serviceDefinitions)` — called once at compile time by the
  compiler pass with the flattened, priority-sorted definition list.
- `getEntityPreprocessServices(EntityInterface $entity, string $viewMode): array` — returns the
  loaded, matching service objects (each already `setEntity()`/`setViewMode()`-ed), in priority order.
  Results are statically cached per `entityTypeId → bundle → viewMode`. Each returned service is
  fetched with `$container->get($id)`; if it does not implement `PreprocessServiceInterface` an
  `\Exception` is thrown (`The preprocess service must implement …`).

Because services are shared by default, the manager reuses one instance per service id and mutates
its `entity`/`viewMode` right before each `preprocess()` — fine for the sequential render flow, but do
not rely on instance state persisting between entities.

## The render-time helper — how a service gets called

`_entity_preprocess_services_preprocess_entity(array &$variables, EntityInterface $entity, string $viewMode)`
in `entity_preprocess_services.module` is the single entry point:

```php
$manager = \Drupal::service('entity_preprocess_services.manager');
$services = $manager->getEntityPreprocessServices($entity, $viewMode);
foreach ($services as $service) {
  $cacheableMetadata = new CacheableMetadata();
  $service->setVariables($variables);
  $service->setCacheableMetadata($cacheableMetadata);
  $variables = $service->preprocess();               // your return value replaces $variables
  $cacheableMetadata->addCacheableDependency($service);
  $variablesMetadata = CacheableMetadata::createFromRenderArray($variables);
  $cacheableMetadata->merge($variablesMetadata)->applyTo($variables);
}
```

So each service's `getCacheContexts/Tags/MaxAge` are folded into the template's `#cache` alongside
whatever cacheability was already on the variables. **Return the variables from `preprocess()`** — a
service that forgets to return `$this->variables` (or `parent::preprocess()`) will blank the template.

## Enabling it for other entity types (node & paragraph work out of the box)

The module only implements `hook_preprocess_node()` and `hook_preprocess_paragraph()`. For any other
entity type, implement that type's preprocess hook in your own module/theme and call the helper:

```php
/**
 * Implements hook_preprocess_taxonomy_term().
 */
function my_module_preprocess_taxonomy_term(array &$variables) {
  _entity_preprocess_services_preprocess_entity(
    $variables,
    $variables['term'],
    $variables['elements']['#view_mode']
  );
}
```

Your tagged services then just declare `applies_to: [{ entity_type: 'taxonomy_term', ... }]`. Clear
caches (`drush cr`) after adding or retagging a service so the compiler pass re-runs.
