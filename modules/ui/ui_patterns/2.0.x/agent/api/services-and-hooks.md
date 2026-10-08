<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, Twig, and hooks

## Key services

| Service id | Class | Use |
|---|---|---|
| `plugin.manager.sdc` | `ComponentPluginManager` (decorates core) | List/get SDC component definitions (props, slots, variants). |
| `plugin.manager.ui_patterns_source` | `SourcePluginManager` | Discover/instantiate Source plugins. |
| `plugin.manager.ui_patterns_prop_type` | `PropTypePluginManager` | Resolve/validate a prop's type. |
| `plugin.manager.ui_patterns_derivable_context` | `DerivableContextPluginManager` | Derived render contexts. |
| `ui_patterns.component_element_builder` | `ComponentElementBuilder` | Build a component render array from sources. |
| `ui_patterns.sample_entity_generator` | `SampleEntityGenerator` | Sample entities for previews. |

List all components with props/slots:
```php
$m = \Drupal::service('plugin.manager.sdc');
foreach ($m->getDefinitions() as $id => $d) { /* $d['props']['properties'], $d['slots'] */ }
```

## Rendering a component directly

UI Patterns registers the standard SDC render element; a component renders via core's
`#type => 'component'`:
```php
$build = ['#type' => 'component', '#component' => 'olivero:teaser',
  '#slots' => ['title' => ['#markup' => 'Hi']], '#props' => []];
```
Its Twig extension (`ui_patterns.twig.extension`) also lets templates emit components.

## Alter hooks (from `ui_patterns.api.php`)

- `hook_component_info_alter(array &$definitions)` — change/extend discovered SDC component
  definitions (props, slots, metadata) before they are exposed.
- `hook_ui_patterns_source_value_alter(mixed &$value, SourceInterface $source, array &$source_configuration)`
  — post-process the value a Source produced (e.g. sanitize, wrap, transform).
- `hook_ui_patterns_component_pre_build_alter(array &$element)` — adjust a component render
  element just before it is built.

The main module defines **no permissions**, **no Drush commands**, and **no config UI**
(`configure: null`); it ships config **schema** only. All site-builder interaction happens
through the submodules.
