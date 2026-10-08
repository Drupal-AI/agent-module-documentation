<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migration Decorator provides a plugin layer that decorates discovered migration definitions before they reach the normal alter hooks.
---
Large migrations sourced from a single SQL table (D7 node/comment complete migrations, for example) can be slow and memory-heavy to run as one plugin. Migration Decorator inserts itself into the migration plugin discovery pipeline so that a single "winner" decorator plugin (the one with the lowest weight) can rewrite, add derivatives to, or entirely remove migration definitions before they are altered and instantiated.

It works by swapping the `plugin.manager.migration` service via a `ServiceProvider`, wrapping core's discovery with `ContainerDerivativeDiscoveryWithAutoDeriverDecorator` and a `FilterDecorator`. Ships `AutoDeriver` derivatives plus chopped `Comment` / `NodeComplete` migrate source plugins that let a big source be split ("chopped") into paged derivative migrations. The module has no routes, no permissions, no config UI and no user-facing surface — it is pure developer/migration infrastructure and is configured entirely in code by writing decorator plugins under `Plugin/migration_decorator/Decorator`. `hook_install()` sets the module weight to 1 so its service provider runs after Migrate Drupal's.

Typical setup: enable the module, then implement a `@MigrationDiscoveryDecorator` plugin (extend `DecoratorPluginBase`, see the `Fallback` example) to shape how definitions are chopped or filtered.
---
- Enable the module to gain the decorated migration discovery pipeline.
- Split a large SQL-sourced migration into smaller paged derivative migrations.
- Add extra derivative calculations on already-derived migrations.
- Remove certain migration definitions entirely before they run.
- Write a custom `@MigrationDiscoveryDecorator` plugin to reshape definitions.
- Use the provided `Fallback` decorator as a starting template.
- Chop a D7 `node_complete` source into per-page migrations with `NodeComplete` source.
- Chop a D7 `comment` source into per-page migrations with the `Comment` source.
- Rely on `AutoDeriver` derivatives to auto-generate chopped derivatives.
- Control which decorator wins by assigning plugin weights (lowest wins).
- Reduce memory usage of one-shot SQL migrations by paging the source.
- Extend `DecoratorPluginBase` for a bespoke decoration strategy.
- Combine with migmag/tecla dev tooling for migration debugging.
- Inspect `MigrationDiscoveryDecoratorManager` to understand plugin discovery.
- Keep migration behavior in code with no site configuration to export.
- Run standard `drush migrate:*` commands against the decorated definitions.
- Audit which decorator plugin is active for a given migration.
- Layer chopping on top of Migrate Drupal upgrade migrations.
