<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic data attributes: DataProviderInterface, Dataset, the route enhancer

Source: `src/DataProviderInterface.php`, `src/RouteDefinitionDataProvider.php`, `src/Dataset.php`,
`src/Routing/DatasetRouteEnhancer.php`, `decoupled_pages.services.yml`.

## When to use

Static config goes in the route's `_decoupled_page_data` map (see
[../routing/decoupled-pages.md](../routing/decoupled-pages.md)). Use a **data provider** when the `data-*`
attributes must be computed per request (e.g. from a query parameter, the current user, or another service)
with correct cacheability.

## The interface

`Drupal\decoupled_pages\DataProviderInterface` — one method:

```php
public function getData(\Symfony\Component\Routing\Route $route, \Symfony\Component\HttpFoundation\Request $request): Dataset;
```

Return a `Dataset` (below). The default implementation `RouteDefinitionDataProvider` (`final`, `@internal`,
`SERVICE_ID = decoupled_pages.route_definition_data_provider`) simply returns the route's
`_decoupled_page_data` map via `Dataset::cachePermanent()`.

## Registering a custom provider

1. Implement `DataProviderInterface`.
2. Register it as a service **tagged `decoupled_pages_data_provider`** (the tag is collected onto the route
   enhancer via `service_collector`):

```yaml
services:
  your_module.data_provider:
    class: Drupal\your_module\DataProvider
    tags:
      - { name: decoupled_pages_data_provider }
```

3. Point the route at it: `defaults: { _decoupled_page_data_provider: your_module.data_provider }`.

The route default must name a registered service or the routing subscriber throws `RouteDefinitionException`.

## The Dataset value object

`Drupal\decoupled_pages\Dataset` (`final`, extends `\ArrayIterator`, implements
`CacheableDependencyInterface` via `CacheableDependencyTrait`) — the attribute map plus cacheability:

- `Dataset::cachePermanent(array $data)` — no cache metadata; use for values that never vary.
- `Dataset::cacheVariable(CacheableMetadata $cacheability, array $data)` — attach cache contexts/tags/max-age;
  use for request-dependent values.
- `Dataset::merge(Dataset $a, Dataset $b)` — union of values (b overrides a on key clash) and the combined
  cacheability.

## How merging/validation works at request time (`DatasetRouteEnhancer::enhance()`)

The enhancer (`route_enhancer` tag) runs before the controller:

1. Reads the route's `_decoupled_page_data_provider` id; if none, returns unchanged.
2. Calls that provider's `getData($route, $request)`.
3. **If the provider is not the default one**, each returned key is re-validated against `/^[a-z\-]+$/`
   (no leading/trailing dash) — a bad key throws `DataProviderException`. It then also runs the default
   `RouteDefinitionDataProvider` and merges the route's static `_decoupled_page_data` under the dynamic data
   (`Dataset::merge(routeDefinitionData, enhancedData)`), so static attributes are still applied and dynamic
   values win on clash.
4. Merges with any pre-existing `decoupled_page_data` request attribute and stores the result. The controller
   then copies each entry to a `data-<name>` attribute and applies the dataset's cacheability to the build.

Provider lookup uses the reverse container to key providers by service id (a `\Drupal::VERSION <= 9.5.0`
branch reads `$provider->_serviceId` instead) — no action needed by implementers.

## Example (shipped in the test submodule)

`decoupled_pages_test`'s `DataProvider` reads a `dynamic_value` query parameter and, when present, returns
`['dynamic' => <value>]` with cache context `url.query_args:dynamic_value`, otherwise an empty dataset. This
shows the correct pattern: request-derived attribute + matching cache context so page cache varies properly.
Attribute values are emitted through Drupal's render/attribute system (`html_tag` `#attributes`), which
escapes them for the HTML-attribute context; keys are constrained to `[a-z-]`.
