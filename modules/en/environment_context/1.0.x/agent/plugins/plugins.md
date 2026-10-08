<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition, typed-data & cache-context plugins

The module registers plugin *instances* into core plugin types (Condition, DataType, Cache context).
It defines **no new plugin types**.

## Condition plugin — "Current environment"

`Plugin\Condition\EnvironmentCondition`, id **`environment`**, label *"Current environment"*, extends
`ConditionPluginBase`, implements `ContainerFactoryPluginInterface`. Declared with both the
`#[Condition(...)]` attribute and the legacy `@Condition` annotation; it declares a
`context_definitions` entry `environment` (data-type `environment`).

- Injected `environment_context.registry` (via `create()`).
- `defaultConfiguration()` → `['environments' => []]` (+ parent).
- `buildConfigurationForm()` builds a `checkboxes` element `environments` from
  `registry->getEnvironmentDefinitions()` (label per machine name). If no environments exist it renders
  "There are no environments available." and skips the negate UI.
- `submitConfigurationForm()` stores `array_filter($form_state->getValue('environments'))`.
- `evaluateCondition()`: returns `FALSE` when no environments are selected; otherwise
  `in_array($this->getContextValue('environment'), $this->configuration['environments'], TRUE)`.
  `evaluate()` applies `isNegated()`.
- `summary()` lists selected environment labels. `getCacheContexts()` → `['environment']`.

Use it on any block/section: *Visibility → Current environment*, tick the environments, optionally
*Negate*. Requires environments to be registered (via the events / submodules) to show options.

## Typed-data plugin — `environment`

`Plugin\DataType\Environment`, id **`environment`**, extends core `StringData`.

- `isValid(): bool` → `in_array($this->value, registry->getAvailableEnvironments(), TRUE)` (uses
  `\Drupal::service('environment_context.registry')`).
- `getEnvironment(): string` → the string value.

This is the data-type used by the Context published by the resolver and by the condition's context
definition.

## Cache context — `environment`

`Cache\EnvironmentCacheContext`, service `cache_context.environment`, tagged
`{ name: cache.context, id: environment }`; constructed with the
`EnvironmentResolverInterface` service.

- `getContext()` → `resolver->getCurrentEnvironment()` (the per-environment cache key).
- `getLabel()` → *"Environment"*. `getCacheableMetadata()` → empty `CacheableMetadata`.

Add it to any render array whose output depends on the environment:

```php
'#cache' => ['contexts' => ['environment']],
```
