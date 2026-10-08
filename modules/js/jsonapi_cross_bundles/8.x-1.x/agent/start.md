<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Cross Bundles (jsonapi_cross_bundles) — agent index

Adds a **read-only, cross-bundle collection endpoint per entity type** at `/jsonapi/{entity_type_id}`
(e.g. `/jsonapi/node`, `/jsonapi/taxonomy_term`, `/jsonapi/media`) that returns entities from **every
bundle** of that entity type in one paged, sortable, filterable JSON:API request. Depends only on core
`jsonapi`. Version **8.x-1.2**, core `^8.7.7 || ^9 || ^10 || ^11`. Explicitly **experimental**.
No routes file, no config, no permissions, no UI — it works entirely by **service decoration**.

## What problem it solves

Core JSON:API exposes one resource **per bundle** (`/jsonapi/node/article`, `/jsonapi/node/page`).
When the bundle does not matter (site-wide feed, sitemap, migration, activity stream, search index)
the client must request each bundle and merge them, must know the bundle list, must update when a
bundle is added, and — the real blocker — **cannot page or sort across the combined set**. This
module adds one aggregate collection so paging and sorting work across the whole entity type.

## Mechanism (confirmed from source)

Two core services are decorated (see `jsonapi_cross_bundles.services.yml`):

1. **`jsonapi.resource_type.repository`** → `CrossBundleResourceTypeRepository`
   (`src/ResourceType/CrossBundleResourceTypeRepository.php`). In `all()` it groups core's resource
   types by entity type id, and for each entity type **that has a bundle key** it builds one extra
   `CrossBundlesResourceType` (`src/ResourceType/CrossBundlesResourceType.php`) whose **type name and
   path are the bare entity type id** (`node`, not `node--article`), `getBundle()` is `NULL`,
   `isMutable()` is `FALSE`, `isLocatable()` is true **iff at least one bundle is locatable**, and
   whose field mapping is the **superset** of the per-bundle field mappings
   (`getFieldMappingSuperset()`; conflicting mappings across bundles are dropped and left undefined).
   The result set is cached in `cache.jsonapi_resource_types` under `jsonapi.resource_types`.
   Because the synthetic resource type is locatable with a path, **core's own route generator emits
   the `/jsonapi/{entity_type_id}` collection route** — this module adds no route itself.
2. **`jsonapi.field_resolver`** → `CrossBundleFieldResolver`
   (`src/Context/CrossBundleFieldResolver.php`). Overrides `getFieldItemDefinitions()` and
   `getFieldAccess()` so `filter` / `sort` / `include` field paths resolve against the aggregated
   bundle resource types.

A third helper, `ResourceTypeRepositoryShim` (`src/ResourceType/ResourceTypeRepositoryShim.php`,
`parent: jsonapi.resource_type.repository`), simply re-exposes core's protected `getFields()`,
`getAllFieldNames()` and `calculateRelatableResourceTypes()` so the decorator can call them.

## Key facts for answering questions

- **Endpoint:** `GET /jsonapi/{entity_type_id}` — one per entity type that has bundles. Read-only
  (no POST/PATCH/DELETE; the resource type is not mutable). Individual-resource and per-bundle routes
  from core are unchanged.
- **Response types are per bundle.** Each item in `data` is serialised through its own
  bundle-specific resource type, so its `type` is `node--article` etc., not `node`. A consumer must
  **branch on each item's `type`** — the collection is heterogeneous.
- **Access is core's access.** The collection query is built by core JSON:API with entity-access
  checks (`accessCheck(TRUE)`); field access/config come from each entity's real bundle resource type;
  the decorated field resolver checks `view` access for filter/sort paths across bundles with a
  conservative AND (`getFieldAccess()` uses `andIf` over every bundle that has the field). No new
  permission is introduced — read access matches core JSON:API (respects entity/field access).
- **No config, no schema, no Drush, no plugins, no permissions.** `provides_config_schema` is false;
  there is no `config/` directory.
- **JSON:API Extras:** dev-time compatible (`require-dev: drupal/jsonapi_extras ^3`); the decoration
  is written not to conflict (see `tests/src/Kernel/JsonapiExtrasIntegrationTest.php`).

## Deeper docs

- `api/mechanism.md` — full decoration walk-through with file:line references, the field-mapping
  superset algorithm, relatable-types superset, and how the collection route materialises.
