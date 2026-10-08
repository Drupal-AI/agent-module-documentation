<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Plugin Constructor Factory is a developer-facing API that lets you inject services into plugin classes through the constructor instead of via `ContainerFactoryPluginInterface`, removing the boilerplate `create()`/`__construct($configuration, $plugin_id, $plugin_definition, …)` signature and making plugin inspection info and configuration optional.

By itself the module does nothing at runtime — it ships the classes needed to opt a plugin manager into constructor injection. To use it, override a plugin manager's `getFactory()` to return the provided `ConstructorFactory` (a `ConstructorFactoryPluginManagerTrait` does this in one line), register your plugin class as a service, and reference the service id from the plugin annotation; dependencies then arrive through the constructor and autowiring works. Plugins only receive `$pluginId`/`$pluginDefinition` if they implement `PluginInspectionInterface` (setters provided via `PluginInspectionTrait`), and only receive `$configuration` if they implement `ConfigurableInterface` (via `PluginConfigurationTrait`). The `plugin_constructor_factory_core` submodule provides ready-made constructor-injectable base classes and managers for core plugin types (Action, Filter, QueueWorker) plus a service provider.

Operational notes: `ConstructorFactory` can only replace `ContainerFactory`, so plugin managers extending `DefaultPluginManager` are supported but plugins using a custom factory are not. No routes, permissions, or config — this is code infrastructure for module developers. Report security issues to security@wieni.be (MIT licensed).
---
Inject dependencies into Drupal plugins through the constructor via a drop-in ConstructorFactory (autowiring-friendly).
---
- Enable a plugin manager to use `ConstructorFactory` by overriding `getFactory()`.
- Apply `ConstructorFactoryPluginManagerTrait` to a manager in one line.
- Inject services into a plugin through its constructor instead of `create()`.
- Register a plugin class as a service and reference its id in the annotation.
- Use autowiring for plugin dependencies where available.
- Make plugin inspection info optional by implementing `PluginInspectionInterface`.
- Reuse the provided `PluginInspectionTrait` for `$pluginId`/`$pluginDefinition` setters.
- Access `$configuration` only when implementing `ConfigurableInterface`.
- Reuse the provided `PluginConfigurationTrait` for configuration handling.
- Drop the boilerplate constructor signature from your plugin classes.
- Use the `plugin_constructor_factory_core` constructor-injectable ActionBase.
- Use the constructor-injectable ConfigurableActionBase / EntityActionBase.
- Use the constructor-injectable FilterBase and QueueWorkerBase.
- Swap in the provided ActionManager / FilterPluginManager / QueueWorkerManager.
- Register the core service provider from the submodule.
- Keep using `PluginBase` optional rather than practically required.
- Support core versions from 8.8.4 through 11 with PHP 7.2+.
- Replace `ContainerFactory` (not custom factories) in `DefaultPluginManager` subclasses.
