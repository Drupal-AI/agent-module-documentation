# The `entity_preprocess_service` service tag (discovery & targeting)

This module has no Drupal plugin type. "Registration" is a **service tag** collected by a compiler
pass. This file documents the tag, the `properties` that target it, priority, and the exact matching
rules.

## Registering a service

In any `*.services.yml`:

```yaml
services:
  my_module.preprocess_service.node.full:
    class: Drupal\my_module\PreprocessService\MyNodeFullPreprocessService
    tags:
      - { name: entity_preprocess_service, priority: 100 }
    properties:
      applies_to:
        - { entity_type: 'node', view_mode: 'full', bundle: 'page' }
```

- **tag** `entity_preprocess_service` — makes the compiler pass pick the service up.
- **`priority`** (tag attribute, integer, default `0`) — services are sorted **descending**, so a
  higher priority runs *first*. See `EntityPreprocessPass::process()` (`uasort … $b <=> $a`).
- **`properties.applies_to`** — a list; **each list entry becomes one registration**. `entity_type`
  is required (an entry with no `entity_type` is silently dropped). `bundle` and `view_mode` are
  optional; omitting one means "match any". A service with no `applies_to` at all is skipped entirely.
- **`properties.excludes`** — optional list, same `{entity_type, bundle, view_mode}` shape; a match
  against any exclude removes the service for that entity. Shared across all `applies_to` entries of
  the service.

## The three targeting properties

| Key | Compared against | Semantics |
|---|---|---|
| `entity_type` | `$entity->getEntityTypeId()` | Required in `applies_to`. Exact match. |
| `bundle` | `$entity->bundle()` | Optional. Omit ⇒ all bundles. |
| `view_mode` | the `$viewMode` passed to the helper | Optional. Omit ⇒ all view modes. |

## How matching actually works

At compile time `EntityPreprocessPass` flattens every tagged service into definitions of the shape
`{service, entity_type, bundle, view_mode, excludes, priority}` (one per `applies_to` entry),
priority-sorts them, and passes them to `EntityPreprocessServicesManager::addEntityPreprocessServices()`.

At render time `getEntityPreprocessServices($entity, $viewMode)` walks that list (result cached per
`type→bundle→viewMode`) and, for each definition:

1. **Excludes first** — for each entry in `excludes`, if it matches the entity
   (`serviceDefinitionMatches()`, using the same isset-based rules below), the service is skipped
   (`continue 2`).
2. `entity_type` set and `!== $entity->getEntityTypeId()` ⇒ skip.
3. `bundle` set and `!== $entity->bundle()` ⇒ skip.
4. `view_mode` set and `!== $viewMode` ⇒ skip.

Note the checks use `isset()`, so a `NULL` bundle/view_mode (the default when the key is omitted)
counts as "not set" and therefore matches everything. A surviving definition contributes its service
id; the manager then `$container->get()`s each, calls `setEntity()`/`setViewMode()`, and returns them
in priority order for the helper to run.

## Example submodule (`entity_preprocess_services_example`)

Three services, all tagged at `priority: 100`, illustrate the three targeting styles:

| Service id | Class | `applies_to` | Effect |
|---|---|---|---|
| `entity_preprocess_services_example.preprocess_service.node` | `ExampleNodePreprocessService` | `{ entity_type: node }` | every node (any bundle/view mode) → sets `$variables['welcome']` |
| `entity_preprocess_services_example.preprocess_service.node.page` | `ExampleNodePagePreprocessService` | `{ entity_type: node, bundle: page }` | only `page` nodes → sets `$variables['info_text']` |
| `entity_preprocess_services_example.preprocess_service.node.full` | `ExampleNodeFullPreprocessService` | `{ entity_type: node, view_mode: full }` | any node in `full` view mode → sets `$variables['info_text']` |

Each overrides `preprocess()` to set a variable then `return parent::preprocess();`. Enable the
submodule (`drush en entity_preprocess_services_example`) to see them fire on node templates.

## Excluding entities

To preprocess all nodes *except* one bundle:

```yaml
properties:
  applies_to:
    - { entity_type: 'node', view_mode: 'full' }
  excludes:
    - { entity_type: 'node', bundle: 'news' }
```

Run `drush cr` after any change to `.services.yml` tags/properties — the compiler pass only re-runs
when the container is rebuilt.
