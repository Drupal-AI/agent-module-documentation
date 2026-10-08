# Plugin Constructor Factory — manual setup guide

**Plugin Constructor Factory** (`plugin_constructor_factory`) is a developer‑facing
API that lets you inject services into plugin classes **through the constructor** —
the way autowiring works elsewhere in modern PHP — instead of through Drupal's
usual `ContainerFactoryPluginInterface` and its `create()`/`__construct(...)`
boilerplate. It removes the repetitive
`__construct($configuration, $plugin_id, $plugin_definition, …)` signature and
makes the plugin inspection info and configuration *optional* rather than always
required.

By itself the module **does nothing at runtime**. It simply ships the classes
needed to opt a plugin manager into constructor injection. You wire it up in code:
override a plugin manager's `getFactory()` to return the provided
`ConstructorFactory` (a one‑line trait does this), register your plugin class as a
service, and reference that service id from the plugin's annotation. Dependencies
then arrive through the constructor and autowiring works. A plugin only receives
`$pluginId`/`$pluginDefinition` if it implements `PluginInspectionInterface`, and
only receives `$configuration` if it implements `ConfigurableInterface` — matching
traits are provided for both.

A companion submodule, **`plugin_constructor_factory_core`**, ships ready‑made
constructor‑injectable base classes and managers for core plugin types (Action,
Filter, QueueWorker) plus a service provider, so you can adopt the pattern for
those types without writing the plumbing yourself.

One operational limit: `ConstructorFactory` can only *replace*
`ContainerFactory`. Plugin managers extending `DefaultPluginManager` are supported,
but plugins that use a custom factory are not. There are no routes, permissions, or
configuration — this is code infrastructure for module developers. (The module is
MIT‑licensed; the vendor's security contact is security@wieni.be.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally enable the core‑types submodule.

There is **no configuration page** for this module — it has no settings form. It
is a code API used in your own modules, described in "How to use it" below.

## How to use it

The workflow is entirely in code (see the [`agent/extend`](../agent/extend/factory.md)
notes for the exact snippets):

1. **Opt a plugin manager in** — override its `getFactory()` to return
   `ConstructorFactory`, most easily by applying
   `ConstructorFactoryPluginManagerTrait`, and swap the manager's class in a
   `ServiceModifierInterface::alter()` service provider.
2. **Define the plugin with constructor dependencies** — register the plugin class
   as a service (the class name is the service id when autowiring), add the
   `service_id` to its annotation, and inject dependencies through the constructor.
3. **Opt in to inspection info or configuration only if you need it** — implement
   `PluginInspectionInterface` (with `PluginInspectionTrait`) for
   `$pluginId`/`$pluginDefinition`, or `ConfigurableInterface` (with
   `PluginConfigurationTrait`) for `$configuration`.

For Action, Filter, and QueueWorker plugins, enable the
`plugin_constructor_factory_core` submodule and extend its provided base classes
and managers instead of building your own.
