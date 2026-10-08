<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Field Lookup (entity_field_lookup) — agent index

Migrate API **process plugin** (`plugin: entity_field_lookup`) that finds an existing entity by
running an **`EntityQuery` on a field value**, rather than by id or by a migration map. It returns
the **first matching entity id** (via `reset()`), or `NULL` on no match / `NULL` input. Package
`Migrate`. Version **1.0.7**. Core `^10.1 || ^11`. GPL-2.0-or-later.

## What it is / is NOT

- It **is** a single PHP class: `Drupal\entity_field_lookup\Plugin\migrate\process\EntityFieldLookup`
  (`src/Plugin/migrate/process/EntityFieldLookup.php`), extending `ProcessPluginBase`.
- It is used **only inside a migration YAML** as a `process` step. It runs when a migration runs
  (`drush migrate:import`, the Migrate UI, etc.).
- It exposes **no route, no REST resource, no controller, no service, no permission, no Drush
  command, no config schema, no admin form**. There is nothing to configure in the UI and no web
  surface. The only other file of substance is a trivial `LoadTest` functional test.

## Mechanism (read `agent/api/migrate-process-plugin.md` for the full key reference)

The `transform()` method:
1. Returns `NULL` immediately if the incoming value is `NULL`.
2. Gets the storage for `entity_type_id` and builds `->getQuery()`.
3. `->accessCheck($this->accessCheck)` — **defaults to TRUE**; set `access_check: false` to disable.
4. `->condition(bundle_key, bundle_id, 'IN')` — `bundle_id` is wrapped in an array if scalar.
5. `->condition(entity_field, $value)` — the primary lookup, source value vs the configured field.
6. Each `extra_conditions` entry adds `->condition(field, value, operator, langcode)`.
7. `->execute()`; returns `reset($results)` (first id) or `NULL` if empty.

## Required vs optional config

- **Required** (validated in the constructor; missing → `BadPluginDefinitionException`):
  `entity_type_id`, `bundle_key`, `bundle_id`, `entity_field`.
- Unknown `entity_type_id` → `InvalidPluginDefinitionException`.
- An `extra_conditions` item with an empty `field` → `InvalidPluginDefinitionException`.
- **Optional**: `access_check` (bool, default `TRUE`), `extra_conditions` (list of
  `{field, value, operator, langcode}`).
- `source` is the standard Migrate process input (the value queried against `entity_field`).

## Reliability notes (these produce quietly wrong data, not errors)

1. **Query the field on a value that is unique in practice** — the plugin returns the *first* match
   with no ordering guarantee, so a non-unique field silently attaches content to the wrong entity.
2. **A miss returns `NULL`** — decide the outcome deliberately (`skip_on_empty`, a default, or a
   stub-creating migration).
3. **One query per row** — often the slowest migration step; index the queried field.

## Files

- `agent/api/migrate-process-plugin.md` — full configuration-key reference and worked YAML examples.
- `usage.md` — orientation, dense summary, use-case list.
- `data.json` — metadata.
