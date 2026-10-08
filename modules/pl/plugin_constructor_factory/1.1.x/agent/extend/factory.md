<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin Constructor Factory — usage

## 1. Opt a plugin manager into constructor injection
Override `getFactory()` to return `ConstructorFactory`. The trait does it for you:
```php
use Drupal\plugin_constructor_factory\ConstructorFactoryPluginManagerTrait;
use Drupal\wmcontroller\ControllerPluginManager as Base;

class ControllerPluginManager extends Base {
  use ConstructorFactoryPluginManagerTrait;
}
```
Swap the manager's class in a `ServiceModifierInterface::alter()` service provider.

## 2. Define the plugin with constructor dependencies
Register the plugin class as a service (class name = service id when autowiring), add
the `service_id` to the annotation, and inject through the constructor:
```php
/**
 * @Controller(entity_type = "node", bundle = "homepage", service_id = "wmcustom.homepage")
 */
class HomepageController { public function __construct(SomeService $svc) {} }
```

## 3. Opt in to inspection info / configuration (optional)
- Need `$pluginId` / `$pluginDefinition`? implement `PluginInspectionInterface`
  (use `PluginInspectionTrait` for the setters).
- Need `$configuration`? implement `Drupal\Component\Plugin\ConfigurableInterface`
  (use `PluginConfigurationTrait`).

## Core plugin types
The `plugin_constructor_factory_core` submodule ships constructor-injectable
`ActionBase`, `ConfigurableActionBase`, `EntityActionBase`, `FilterBase`,
`QueueWorkerBase`, and matching `ActionManager` / `FilterPluginManager` /
`QueueWorkerManager` plus `PluginConstructorFactoryCoreServiceProvider`.

## Limitation
`ConstructorFactory` only replaces `ContainerFactory`; plugins using a custom factory
are unsupported. `DefaultPluginManager` subclasses are fine.
