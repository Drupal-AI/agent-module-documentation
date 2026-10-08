<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Schema (ai_schema) — agent index

Drush-only tool that exports the site's entity/field data model to LLM-friendly JSON files on disk. Version **1.0.0-rc2**, version-dir `1.0.x`. Core `^10 || ^11`. Package: AI.

## What it is
Introspects every fieldable content entity type/bundle and writes JSON artifacts (entity export, relation graph, storage map, compact model, SQL queries, per-entity files). Each field gets a normalized type and an inferred semantic role. No UI, no routes, no permissions, no config, no page output — everything runs through Drush.

## Dependencies
- Drupal core only (no contrib deps, no libraries). `composer require drupal/ai_schema`.
- Drush 12.x or 13.x to run the commands.

## Provides
- **Drush commands** (`drush.services.yml` → `Drupal\ai_schema\Commands\AiSchemaCommands`):
  `aischema:export` (`--compact`), `aischema:relations`, `aischema:storage`, `aischema:compact`, `aischema:sql`, `aischema:per-entity`, `aischema:export-all`.
- **6 services** (`ai_schema.services.yml`): `ai_schema.builder`, `ai_schema.relation_graph`, `ai_schema.storage_map`, `ai_schema.compact`, `ai_schema.sql_query`, `ai_schema.per_entity`.
- No permissions.yml, no routing.yml, no config schema, no plugins, no hooks.

## Solution docs
- [Drush commands & output files](commands/export.md)
- [Builder services API](api/builders.md)
