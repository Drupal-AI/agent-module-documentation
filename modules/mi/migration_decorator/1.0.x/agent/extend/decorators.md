<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing a migration decorator

Migration Decorator replaces `plugin.manager.migration` (via `MigrationDecoratorServiceProvider`)
with a manager whose discovery is wrapped by
`ContainerDerivativeDiscoveryWithAutoDeriverDecorator` + `FilterDecorator`. Exactly one decorator
plugin — the one with the lowest `weight` — is allowed to decorate the discovered definitions.

## Steps
1. Create a plugin under `src/Plugin/migration_decorator/Decorator/` annotated with
   `@MigrationDiscoveryDecorator` (see `Fallback.php` for the minimal example).
2. Extend `DecoratorPluginBase` and implement the decoration logic: modify, add derivatives to,
   or unset definitions in the discovered array.
3. Give it a lower `weight` than competing decorators to make it the winner.
4. Clear caches; the decorated definitions flow into the normal migration alter hooks.

## Chopping big sources
The bundled `NodeComplete` and `Comment` migrate source plugins (plus `AutoDeriver` /
`ChopperDeriverBase` and `ChoppedSourceTrait` / `AutoDeriverTrait`) demonstrate splitting a single
large SQL source into paged derivative migrations to cut runtime and memory use.

No configuration is stored; everything is expressed in code.
