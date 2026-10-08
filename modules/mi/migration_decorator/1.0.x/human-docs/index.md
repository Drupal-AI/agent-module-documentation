# Migration Decorator — manual setup guide

**Migration Decorator** (`migration_decorator`) is developer infrastructure that
lets you reshape migration definitions *before* they reach the normal alter hooks
and get instantiated. It inserts itself into the migration plugin discovery
pipeline so that a single "winner" decorator plugin can rewrite definitions, add
extra derivatives, or remove definitions entirely.

The problem it targets is big, single-table migrations. A large SQL-sourced
migration — a Drupal 7 `node_complete` or `comment` migration, for instance — can
be slow and memory-hungry to run as one plugin. Migration Decorator lets you
"chop" such a source into smaller paged derivative migrations, cutting runtime and
memory use. It ships an `AutoDeriver` mechanism plus chopped `NodeComplete` and
`Comment` migrate source plugins that demonstrate exactly this.

It works by swapping the core `plugin.manager.migration` service (via a service
provider) so that migration discovery is wrapped with decorator logic. Exactly one
decorator plugin — the one with the lowest weight — wins and gets to shape the
discovered definitions. Everything is expressed **in code**: there are no routes,
no permissions, no configuration UI, and nothing to export. Its install hook sets
the module weight to 1 so its service provider loads after Migrate Drupal's. It
depends only on Drupal core's **Migrate** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it is configured entirely in
code by writing decorator plugins, described below.

## Where it lives in the admin menu

Migration Decorator adds nothing to the admin menu — no page, block, permission,
or settings form. You configure it purely by writing PHP plugin classes.

## How to use it

1. Enable the module to gain the decorated migration discovery pipeline.
2. Create a decorator plugin under
   `src/Plugin/migration_decorator/Decorator/` in your own module, annotated with
   `@MigrationDiscoveryDecorator` (the module's bundled `Fallback` plugin is the
   minimal example to copy).
3. Extend `DecoratorPluginBase` and implement your decoration logic — modify, add
   derivatives to, or unset definitions in the discovered array.
4. Give your plugin a lower `weight` than any competing decorators so that it
   becomes the winner (lowest weight wins).
5. Clear caches. The decorated definitions then flow into the normal migration
   alter hooks, and you run everything with the standard `drush migrate:*`
   commands.

To split a large source into paged derivatives, look at the bundled `NodeComplete`
and `Comment` source plugins (with `AutoDeriver` / `ChopperDeriverBase` and the
`ChoppedSourceTrait` / `AutoDeriverTrait`) as working patterns.
