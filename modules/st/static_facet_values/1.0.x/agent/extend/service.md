<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Static Facet Values — implementing a values service

1. Create a class implementing `Drupal\static_facet_values\StaticFacetValuesServiceInterface`. It is responsible for producing the results rendered in the facet widget.

2. Register it as a service. With `autoconfigure`, it is picked up automatically:
```yaml
  my_module.facets.static_value.example:
    class: Drupal\my_module\Facets\Example
    autoconfigure: true
    autowire: true
    Drupal\my_module\Facets\Example: '@my_module.facets.static_value.example'
```
Or tag manually:
```yaml
  my_module.facets.static_value.example:
    class: Drupal\my_module\Facets\Example
    autowire: true
    tags:
      - { name: 'static_facet_values' }
```

3. All tagged services are collected by `static_facet_values.collection` (`StaticFacetValuesCollection`), which also receives the `ReverseContainer` so a service can be resolved back to its id for per-facet selection.

4. On the facet configuration, enable the **Static facet values** processor and select your registered service. The chosen service then generates the facet results.
