<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Next.js JSON:API — the decoration

## Service provider

`Drupal\next_jsonapi\NextJsonapiServiceProvider` (a `ServiceProviderBase`) alters the container:

```php
public function alter(ContainerBuilder $container) {
  if ($container->hasDefinition('jsonapi.entity_resource')) {
    $container->getDefinition('jsonapi.entity_resource')
      ->setClass('Drupal\next_jsonapi\Controller\EntityResource')
      ->addMethodCall('setMaxSize', ['%next_jsonapi.size_max%']);
  }
}
```

So the core `jsonapi.entity_resource` service is re-classed to next_jsonapi's `EntityResource` and
told its max page size via a method call. This only takes effect while the module is enabled (the
container is rebuilt on install/uninstall).

## The parameter

`next_jsonapi.services.yml` declares:

```yaml
parameters:
  next_jsonapi.size_max: 1000
```

Core JSON:API's default maximum page size is 50; next_jsonapi lifts it to 1000. To use a different
cap, override the `next_jsonapi.size_max` parameter (e.g. in a site/module `services.yml`).

## The EntityResource subclass

`Drupal\next_jsonapi\Controller\EntityResource extends
Drupal\jsonapi\Controller\EntityResource`:

- `setMaxSize(int $maxSize): static` — stores the max.
- `getJsonApiParams(Request $request, ResourceType $resource_type)` — calls the parent, then, **when
  the request has a `fields` query parameter**, replaces the `OffsetPage` param with one built using
  the larger `$this->maxSize`, so bigger pages are allowed for sparse-fieldset requests.

## Reading the live state

```php
// which class serves jsonapi.entity_resource now?
get_class(\Drupal::service('jsonapi.entity_resource'));   // Drupal\next_jsonapi\Controller\EntityResource when enabled

// the configured max page size
\Drupal::getContainer()->getParameter('next_jsonapi.size_max');  // 1000
```

There is no configuration entity, permission, route, or Drush command — the module's entire effect is
this decoration + parameter.
