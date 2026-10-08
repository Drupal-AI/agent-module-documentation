<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The GlobalVariable plugin type

mgv defines one plugin type; each `global_variables.<key>` value is a plugin.

- **Manager:** `Drupal\mgv\MgvPluginManager` (service `Drupal\mgv\MgvPluginManagerInterface`, alias
  `plugin.manager.mgv`), extends `DefaultPluginManager`.
- **Discovery namespace:** `Plugin/GlobalVariable` in any module.
- **Attribute:** `#[Drupal\mgv\Attribute\Variable('id')]` (constructor: `id`, `variableDependencies`,
  `deriver`, `context_definitions`). Legacy annotation `@Mgv` exists but is **deprecated in 2.3.0**,
  removed in 3.0 — use the attribute.
- **Interface / base:** implement `GlobalVariableInterface`; extend `Drupal\mgv\Plugin\GlobalVariable`
  (`PluginBase`). Required: `getValue()`. Optional: `getCacheMetadata()` (default `NULL`).

## Minimal plugin

```php
namespace Drupal\my_module\Plugin\GlobalVariable;

use Drupal\mgv\Attribute\Variable;
use Drupal\mgv\Plugin\GlobalVariable;

#[Variable('my_thing')]
class MyThing extends GlobalVariable {
  public function getValue() {
    return 'hello';
  }
}
```

Print with `{{ global_variables.my_thing }}`. Inject services by implementing
`ContainerFactoryPluginInterface` and a `create()` (see `CurrentPath`, `SocialSharingEmail`).

## Nested keys

A backslash in the id nests the value: `#[Variable('social_sharing\facebook')]` →
`global_variables.social_sharing.facebook`. `MgvPluginManager::getNamespacedValue()` explodes the id
on `\` and `NestedArray::mergeDeep`s the result.

## Depending on other variables

Declare `variableDependencies`; the manager resolves each dependency's `getValue()` and passes it in
`configuration['variableDependencies']`, readable via `$this->getDependency('id')`:

```php
#[Variable(id: 'my_share', variableDependencies: ['base_url', 'current_path'])]
class MyShare extends GlobalVariable {
  public function getValue() {
    return $this->getDependency('base_url') . $this->getDependency('current_path');
  }
}
```

## Cache metadata

Override `getCacheMetadata()` to return a `CacheableMetadata`; the manager wraps the value in
`CacheableVariableValue` so contexts/tags/max-age bubble during template rendering:

```php
public function getCacheMetadata() {
  return (new CacheableMetadata())
    ->addCacheContexts(['url'])              // varies by URL
    ->addCacheTags(['config:system.site']);  // invalidate on site config change
}
```

Common patterns: `['languages:language_interface']` (per language), `['node:123']` (per node),
`->setCacheMaxAge(0)` (never cache). `current_path` already adds the `url` context.

## Context-aware plugins

Implement `ContextAwarePluginInterface` (use `ContextAwarePluginTrait`), declare `context_definitions`
in the attribute, and override `getContextMapping()` to map to a context provider (e.g.
`'@node.node_route_context:node'` — requires the `node` module). The manager calls
`getRuntimeContexts()` + `applyContextMapping()` before `getValue()`. If a required context is
missing, the plugin throws and is **silently skipped** (so the variable is simply absent on that
page). Declare the providing module as a dependency in your `.info.yml`.
