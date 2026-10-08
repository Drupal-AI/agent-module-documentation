<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin Constructor Factory (plugin_constructor_factory) — agent index

**Developer API: a `ConstructorFactory` that injects dependencies into plugins through the constructor (autowiring-friendly).**

- **Version:** 1.1.x
- **Core:** ^8.8.4 || ^9 || ^10 || ^11 (PHP 7.2+)
- **Key classes:** `Plugin\Factory\ConstructorFactory`, `ConstructorFactoryPluginManagerTrait`, `PluginConfigurationTrait`, `PluginInspectionInterface`/`PluginInspectionTrait`
- **Submodule:** `plugin_constructor_factory_core` — constructor-injectable base classes/managers for Action, Filter, QueueWorker + a service provider
- **No routes, permissions, or config.** Does nothing until a manager opts in.

**Security:** pure developer code infrastructure — no web-facing routes, endpoints or stored data. Only replaces `ContainerFactory` in `DefaultPluginManager` subclasses. No security findings. (Vendor security contact: security@wieni.be; MIT.)

See [extend/factory.md](extend/factory.md)
