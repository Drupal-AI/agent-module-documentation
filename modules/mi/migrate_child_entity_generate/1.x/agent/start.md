<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Child Entity Generate (migrate_child_entity_generate) — agent index

Provides **one Migrate process plugin, `child_entity_generate`**, that creates a child entity from
the incoming value during a migration and returns the saved entity object. It is meant for entities
that only exist in the context of their parent — paragraphs, field_collection items, referenced
sub-entities — so it deliberately does **no lookup / dedupe**: every run of `transform()` calls
`$storage->create($values)` then `$entity->save()` and hands back the new entity. Unlike Migrate
Plus's `entity_generate`, it can build an entity from an **array of values** (mapping source
sub-keys to destination fields via `values:`) or store the whole incoming value in one property via
`destination:`. The single class is
`src/Plugin/migrate/process/ChildEntityGenerate.php` (`transform()` at `:134`).

This is developer/CLI migration infrastructure: you author it in a migration YAML's `process:`
section and run it under Drush (`drush migrate:import`). There are no routes, controllers, forms,
services (beyond the injected `entity_type.manager`), permissions, or request-time surface.

- Depends on: `drupal:migrate` (core Migrate). No external libraries.
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Migration`.
- No settings page / `configure` route. No permissions. No drush commands of its own. No config
  schema. Defines **no** new plugin *type* — it is a single plugin *instance* of core's existing
  `migrate.process` plugin type.

## What you'd do → where

- **Use / configure the `child_entity_generate` process plugin in a migration YAML (all keys,
  mapping modes, gotchas)** → [plugins/child-entity-generate.md](plugins/child-entity-generate.md)

## Key facts (real machine names)

- Process plugin id: **`child_entity_generate`** (`@MigrateProcessPlugin(id = "child_entity_generate")`),
  class `Drupal\migrate_child_entity_generate\Plugin\migrate\process\ChildEntityGenerate`, extends
  `Drupal\migrate\ProcessPluginBase`, implements `ContainerFactoryPluginInterface`.
- Injected service: `entity_type.manager` (`$this->entityTypeManager`).
- Plugin config keys read in `transform()`: `entity_type` (required), `bundle`, `destination`,
  `values` (map `destination_field: source_key`), `default_values` (map `destination_field: literal`).
- Field-path nesting: `values`/`default_values` keys are split on `Row::PROPERTY_SEPARATOR` (`/`)
  and set with `NestedArray::setValue()`, so keys like `field_faq_answer/format` work.
- Returns the **saved entity object** (not an id) — chain it into an entity-reference destination.
