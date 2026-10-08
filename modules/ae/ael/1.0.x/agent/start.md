<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# As Event Listener (ael) — agent index

A **framework helper**: enables Symfony's **`#[AsEventListener]`** PHP attribute for registering event
listeners in Drupal, so a class or method carrying the attribute is auto-tagged
`kernel.event_listener`. No dependencies. Core **`^11.3`**. License GPL-2.0-or-later. Version 1.0.2.

- **How the attribute is enabled and how to use it in your module** →
  [api/event-listener.md](api/event-listener.md)

## What it actually is

- One class: `AelServiceProvider` (`src/AelServiceProvider.php`,
  `implements ServiceProviderInterface`). Drupal auto-discovers a `<Camel>ServiceProvider` named after
  the module, so no `*.services.yml` registration is needed.
- `register(ContainerBuilder $container)` does exactly two things:
  1. `addCompilerPass(new AddEventAliasesPass(KernelEvents::ALIASES))` — registers Symfony's kernel
     event name aliases so attribute `event:` values can use them.
  2. `registerAttributeForAutoconfiguration(AsEventListener::class, [self::class, 'addEventListenerTag'])`
     — wires the attribute into container autoconfiguration.
- `addEventListenerTag(ChildDefinition $definition, AsEventListener $attribute, \ReflectionClass|\ReflectionMethod $reflector)`
  copies the attribute's properties (`event`, `method`, `priority`, `dispatcher`) into a
  `kernel.event_listener` tag. On a method it sets `method` to the method name (and throws
  `LogicException` if the attribute also declared a `method`).

## Provides

- **No** routes, permissions, services, entities, plugins, config, schema, hooks, Drush, JS/CSS, or
  submodules. Its only artifact is the service provider that enables the attribute.

## Requirements & use

- Requires the target service to be **autoconfigured** (`autoconfigure: true`, typically with
  `autowire: true`). The attribute has no effect on a manually-defined, non-autoconfigured service.
- Drupal core **11.3+** only. See [api/event-listener.md](api/event-listener.md) for a worked example.
