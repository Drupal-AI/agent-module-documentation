<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Components Extras — register & render Twig components

Two moving parts: a **YAML plugin type** that registers named components, and a **`component` render
element** that renders one from a render array. Requires the **Components** module (which owns the
Twig template namespaces the component `path` usually points at).

## 1. Register components — `{name}.components.yml`

Place a `{module|theme}.components.yml` at the root of any enabled module or theme. Each top-level key
is a component id:

```yaml
my-card:
  path: '@customer/card/card.twig'   # required: a Twig template (namespace or path)
  label: 'Card'                       # optional, translatable
  variables:                          # names of the variables the component accepts
    - title
    - body
```

- `path` is passed straight to Twig `include`, so it must be a real, resolvable template — typically a
  Components Twig namespace (`@namespace/...`) or another registered Twig path.
- `variables` is an allow-list: only these keys are forwarded into the template (see §2).
- `id` and `path` are required; a definition missing either throws `PluginException` at discovery.
- Definitions from every module + theme directory are discovered and cached (cache key
  `component_theme`); rebuild with `drush cr` after adding or editing a file.
- The module ships `components_extras.components.yml` with examples `first` and `second`.

Because Twig forbids dynamic block names, write components to read **variables**, not blocks:

```twig
{% if title is defined %}{{ title }}{% endif %}
```

## 2. Render a component — `#type => 'component'`

```php
$build['card'] = [
  '#type' => 'component',
  '#component' => 'my-card',   // a registered component id
  '#title' => $title,          // one key per declared variable, prefixed with '#'
  '#body' => $body,
];
```

Flow (`Element\ComponentTheme`):

- `getInfo()` sets `#theme => 'components_extras'` and registers the pre-render
  `ComponentTheme::preRenderComponent()`.
- The pre-render looks up the definition via `plugin.manager.component_theme`
  (`getDefinition($element['#component'])` — an unregistered id throws `PluginNotFoundException`),
  stores it as `#component_definition`, then copies **only** the declared `variables` that were
  actually supplied and non-empty into `#component_variables`.
- The theme hook `components_extras` (template `components-extras.html.twig`) renders:

  ```twig
  {% include element['#component_definition']['path'] with element['#component_variables'] %}
  ```

  i.e. it includes the component's template with the filtered variables. Values pass through Twig
  autoescaping as normal.

## 3. Plugin manager service (programmatic)

`plugin.manager.component_theme` (`ComponentThemeManager extends DefaultPluginManager`) exposes the
usual API:

```php
$manager = \Drupal::service('plugin.manager.component_theme');
$manager->getDefinitions();            // all registered components (keyed by id)
$manager->getDefinition('my-card');    // one definition: path, variables, label, id
```

Other modules can adjust definitions with the `hook_component_theme_alter()` alter hook.

## Reference

- Element class: `Drupal\components_extras\Element\ComponentTheme` (`@RenderElement("component")`).
- Manager: `Drupal\components_extras\ComponentThemeManager` /
  `ComponentThemeManagerInterface` (service `plugin.manager.component_theme`).
- Theme hook `components_extras` (render element `element`), template
  `templates/components-extras.html.twig`.
- Discovery: `YamlDiscovery('components', module + theme directories)`, translatable property `label`.
