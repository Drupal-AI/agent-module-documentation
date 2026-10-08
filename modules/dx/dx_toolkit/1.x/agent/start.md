<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DX Toolkit (dx_toolkit) — agent index

A **code-only developer library** for building Drupal modules. It ships **no routes, no
controllers, no permissions, no blocks, no config UI, no Drush** — only reusable PHP classes,
traits, interfaces, and two annotation plugin types. Package `DX`. No module dependencies.
Core requirement `^9 || ^10 || ^11`. PHP `>=8.1`. License GPL-2.0-or-later. Version 1.0.1
(beta). Bundles one submodule, `dx_toolkit_demo` (documented separately under
`modules/dx_toolkit_demo/1.x/`).

## What it actually provides

- **EntityGenerator plugin system** — annotation `@EntityGenerator`
  (`src/Annotation/EntityGenerator.php`), manager service `plugin.manager.entity_generator`
  (`EntityGeneratorManager`), base `EntityGeneratorBase`, interface `EntityGeneratorInterface`,
  and deriver `EntityTypeSourceEntityDeriver`. Creates a companion config entity per bundle of a
  source entity type. `FeedTypeGeneratorBase` specializes it for Feeds. → [plugins/entity_generator.md](plugins/entity_generator.md)
- **@ServiceInjector annotation** (`src/Annotation/ServiceInjector.php`) — describes a
  compile-time factory-service pattern. **Caveat:** version 1.0.1 ships only the annotation; there
  is **no `ServiceInjectorBase` class, manager, or compiler pass in this module**. See the plugin doc.
- **ServiceInstance pattern** — `ServiceInstanceInterface` + `ServiceInstanceTrait` give a service
  static self-lookup: `MyService::getService()` (uses `\Drupal::service()`).
- **Extended plugin base/manager** — `Plugin\PluginManager` (`createInstances`,
  `getPluginDerivatives`, `createDerivativeInstances`, `optionLabels`), `Plugin\PluginBase`,
  and `PluginManagerPropertyQueryTrait::findByProperties()`.
- **State wrapper** — `StateBase` (OO wrapper over core State), concrete `State\PreInstallState`
  toggled by `hook_module_preinstall` / `hook_install` in `dx_toolkit.module`.
- **Utility classes** — `Color`, `Json`, `Environment`, `ArrayUtilities`, `OptionsGenerator`,
  `EntityFieldPropertyAdapter`, `Extension`/`ExtensionTrait`, `AsArrayTrait`. → [api/utilities.md](api/utilities.md)

## Services (dx_toolkit.services.yml)

- `dx_toolkit.logger` — logger channel `dx_toolkit`.
- `dx_toolkit.key.storage` — `key` entity storage handler (factory off `entity_type.manager`).
- `plugin.manager.entity_generator` — the EntityGenerator plugin manager.

## Install / operate

`composer require drupal/dx_toolkit` then `drush en dx_toolkit`. Nothing to configure — you
consume the classes from your own module. Enable `dx_toolkit_demo` to see runnable examples.

## Solution docs

- [plugins/entity_generator.md](plugins/entity_generator.md) — EntityGenerator + FeedTypeGenerator + ServiceInjector annotation.
- [api/utilities.md](api/utilities.md) — Color, Json, State, ServiceInstance, plugin managers, array/entity helpers.
