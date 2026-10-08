<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Helper toolkit: form element, blocks, Twig, service tag, routing, theming, constraints

## Form element: `helper_entity_select`

A select listing entities of a type (best for config entities; use autocomplete for large content sets).

```php
$form['menu'] = ['#type' => 'helper_entity_select', '#target_type' => 'menu'];
$form['article'] = [
  '#type' => 'helper_entity_select',
  '#target_type' => 'node',
  '#target_bundles' => ['article'],
];
```

(Class `Drupal\helper\Element\EntitySelect`.)

## Blocks

- `helper_context_entity` (`Drupal\helper\Plugin\Block\ContextEntity`) — render the current context
  entity in a configured `view_mode`.
- `helper_node_field` (`Drupal\helper\Plugin\Block\NodeField`) — output one `field_name` of the
  current node in any block region (e.g. footnotes/legal text outside the content area).

## Twig helpers (`Drupal\helper\Twig\HelperExtension`)

- Filter `format_bytes` — human-readable byte size: `{{ file.getSize()|format_bytes }}`.
- Function `file_data_uri` — file URL/URI → data URI (wraps `File::getDataUri()`).

## Service tag: `module_dependency`

Remove a service (and its class alias) automatically when a module is not enabled
(`Drupal\helper\Compiler\ModuleDependencyPass`):

```yaml
services:
  _defaults: { autowire: true }
  my_module.other_service:
    class: Drupal\my_module\OtherService
    tags:
      - { name: module_dependency, module: other_module }
  Drupal\my_module\OtherService: '@my_module.other_service'
```

Both the service and the `OtherService` alias are dropped if `other_module` is absent. (Helper's own
`helper.pathauto` service uses this with `module: pathauto`.)

## Route requirement: `_is_multilingual`

```yaml
my_module.route:
  requirements:
    _is_multilingual: 'TRUE'
```

Restricts a route to multilingual sites (`Drupal\helper\Access\IsMultilingualAccessCheck`). Also
powers the `tmgmt_hide_if_not_multilingual` helper.

## Theming: sub-theme region inheritance

Add `inherit_regions: true` to a sub-theme's `.info.yml` to inherit the base theme's regions
(works around core not doing this):

```yaml
name: My Sub-Theme
type: theme
base theme: my_base_theme
inherit_regions: true
```

## Validation constraints

- `EntityFieldUniqueValues` / `EntityFieldUniqueValuesValidator` — enforce a field's values are
  unique across entities.
- `FieldListUniqueValues` / `FieldListUniqueValuesValidator` — enforce values within a single
  multi-value field are unique. Use static `Drupal\helper\Field::getDuplicateValues()` to detect
  duplicates.
