<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Preprocess Services (entity_preprocess_services) — agent index

A developer-only module that lets you implement entity preprocessing (the logic normally written in
`hook_preprocess_HOOK`) as **tagged services** instead of procedural functions, so it can use
dependency injection and be unit-tested. Mechanism: a `ServiceProvider` adds a compiler pass
(`EntityPreprocessPass`) that collects every service tagged `entity_preprocess_service`, reads its
`applies_to`/`excludes` `properties`, and hands the flattened, priority-sorted list to the
`entity_preprocess_services.manager` service. At render time the module's own
`hook_preprocess_node()` and `hook_preprocess_paragraph()` call the helper
`_entity_preprocess_services_preprocess_entity($variables, $entity, $viewMode)`, which asks the
manager which services match the entity's type/bundle/view-mode, then runs each one's `preprocess()`
and merges its cacheability into the template variables.

Out of the box only **nodes** and **paragraphs** are wired (those are the only two preprocess hooks
the module implements). To use it for any other entity type you implement that type's
`hook_preprocess_HOOK()` yourself and call the same helper function. There is no UI, no config, no
routes, no permissions — everything is done in `*.services.yml` and PHP classes. Each preprocess
service extends `PreprocessServiceBase` (implements `PreprocessServiceInterface extends
CacheableDependencyInterface`) and overrides `preprocess()`. The bundled
`entity_preprocess_services_example` submodule ships three sample services.

- Depends on: nothing (no `dependencies:` in info.yml). Optional: works with `paragraphs` if present,
  but does not require it.
- Core: `^8.8 || ^9 || ^10 || ^11`. PHP `>=8.1` (composer.json). Package: `Theming`.
- No settings page / `configure` route. No permissions. No drush commands. No config schema.
- Not a Drupal plugin type — discovery is a **service tag** (`entity_preprocess_service`) via a
  compiler pass, not a `DefaultPluginManager`.
- Submodule: `entity_preprocess_services_example` (disabled by default; example services only).

## What you'd do → where

- **Write a preprocess service (extend the base class, override `preprocess()`, inject deps)** →
  [api/services.md](api/services.md)
- **Register/target a service: the `entity_preprocess_service` tag, `applies_to`, `excludes`,
  `priority`, and how matching works** → [plugins/preprocess-service.md](plugins/preprocess-service.md)
- **Enable preprocessing for an entity type other than node/paragraph** → [api/services.md](api/services.md)
- **Understand cacheability of preprocessed variables** → [api/services.md](api/services.md)

## Key facts (real machine names)

- Service: `entity_preprocess_services.manager` (`Drupal\entity_preprocess_services\EntityPreprocessServicesManager`,
  arg `@service_container`). Methods: `getEntityPreprocessServices(EntityInterface $entity, string $viewMode): array`,
  `addEntityPreprocessServices(array $serviceDefinitions)`.
- Service tag: **`entity_preprocess_service`** with optional integer attribute `priority` (default `0`;
  higher runs first). Collected by `EntityPreprocessPass` (registered from
  `EntityPreprocessServicesServiceProvider::register()`).
- Service `properties` read by the pass: `applies_to` (list of `{entity_type, bundle?, view_mode?}`;
  `entity_type` required) and `excludes` (same shape; matches are skipped).
- Interface: `Drupal\entity_preprocess_services\PreprocessService\PreprocessServiceInterface`
  (extends `Drupal\Core\Cache\CacheableDependencyInterface`). Base class:
  `Drupal\entity_preprocess_services\PreprocessService\PreprocessServiceBase`.
- Interface methods: `preprocess(): array`, `setEntity(EntityInterface): self`,
  `setViewMode(string): self`, `setVariables(array &): self`,
  `setCacheableMetadata(CacheableMetadata): self` + `getCacheContexts()`/`getCacheTags()`/`getCacheMaxAge()`.
- Helper function: `_entity_preprocess_services_preprocess_entity(array &$variables, EntityInterface $entity, string $viewMode)`
  (in `entity_preprocess_services.module`).
- Hooks implemented: `hook_help` (`help.page.entity_preprocess_services`), `hook_preprocess_node`,
  `hook_preprocess_paragraph`.
- Submodule services (`entity_preprocess_services_example`): `…preprocess_service.node`
  (`ExampleNodePreprocessService`, all nodes, sets `welcome`), `…preprocess_service.node.page`
  (`ExampleNodePagePreprocessService`, node bundle `page`, sets `info_text`),
  `…preprocess_service.node.full` (`ExampleNodeFullPreprocessService`, node view mode `full`, sets
  `info_text`). All tagged `entity_preprocess_service` at `priority: 100`.
