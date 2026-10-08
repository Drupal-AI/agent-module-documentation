<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mechanism — how a cross-bundle collection is built by decoration

The module owns **no route, controller, config or normalizer**. It decorates two core JSON:API
services and re-uses core's own route generation and serialization. All names below are real.

```
services (jsonapi_cross_bundles.services.yml)
  cross_bundle_resource_type_repository   decorates jsonapi.resource_type.repository
      args: @…inner, @entity_type.manager, @cache.jsonapi_resource_types, @…shim
  cross_bundle_field_resolver             decorates jsonapi.field_resolver   (parent: jsonapi.field_resolver)
  resource_type_repository_shim           parent:   jsonapi.resource_type.repository   (helper, not a decorator)
```

## 1. Resource-type repository decorator

`Drupal\jsonapi_cross_bundles\ResourceType\CrossBundleResourceTypeRepository`
(`src/ResourceType/CrossBundleResourceTypeRepository.php`) implements
`ResourceTypeRepositoryInterface` and wraps the inner repository.

- `getByTypeName()` (`:68`) and `get()` (`:77`) both call `$this->all()` first (to prime the cache),
  then delegate to `$this->inner`. So the synthetic types are made available via `all()`; the
  bare-entity-type-id lookups (`getByTypeName('node')`) resolve out of the rebuilt cache.
- `all()` (`:86`) is the core of the module:
  1. Reads the cache entry `jsonapi.resource_types` from `cache.jsonapi_resource_types`
     (`cache->get('jsonapi.resource_types', FALSE)`, `:88`). On a hit it returns `$cached->data`
     unchanged.
  2. On a miss it calls `$this->inner->all()` to get core's per-bundle resource types, then groups
     them by entity type id with `array_reduce` + `array_merge_recursive` (`:91`).
  3. For each entity type id it fetches the entity type definition and **skips any entity type
     without a bundle key** (`if (!$entity_type->getKey('bundle')) continue;`, `:100`) — that is why
     `user` (no bundles) gets no cross-bundle type but `node`, `taxonomy_term`, `media`, `block_content`
     etc. do.
  4. `$at_least_one_is_locatable` (`:105`) — OR-reduce over the bundle resource types' `isLocatable()`.
  5. `$field_mapping_superset` (`:108`) — for each bundle resource type it asks the **shim** for
     `getAllFieldNames($entity_type, $bundle)` then `getFields(...)`, and merges them with
     `getFieldMappingSuperset()` (below).
  6. Constructs `new CrossBundlesResourceType($entity_type_id, $entity_type_id, $class, $is_internal,
     $at_least_one_is_locatable, FALSE, FALSE, $field_mapping_superset)` (`:115`). The 6th/7th
     constructor args are `is_mutable=FALSE` and `is_versionable=FALSE` — the endpoint is read-only.
  7. `setBundleResourceTypes($resource_types)` (`:125`) stores the aggregated per-bundle types on the
     object; `setRelatableResourceTypes(getRelatableResourceTypesSuperset(...))` (`:127`) sets the
     merged relationships.
  8. `array_merge($initial_resource_types, $cross_bundle_resource_types)` (`:130`) — the synthetic
     types are **added alongside** the originals, then the whole set is cached `Cache::PERMANENT`
     with tag `jsonapi_resource_types` (`:131`).

### `CrossBundlesResourceType` (`src/ResourceType/CrossBundlesResourceType.php`)

`final` subclass of core `ResourceType`:

- `getTypeName()` (`:22`) returns `$this->entityTypeId` (bare, avoids the `node--` prefix).
- `getPath()` (`:56`) returns `$this->entityTypeId` → the collection path is `/jsonapi/node`.
- `getBundle()` (`:63`) returns `NULL` → core's collection query adds **no bundle condition**, so it
  queries every bundle of the entity type.
- `isMutable()` (`:70`) returns `FALSE` → core generates only the **collection GET** route, not
  create/update/delete.
- `getBundleResourceTypes()` (`:46`) throws `LogicException` if `setBundleResourceTypes()` was never
  called — the field resolver relies on this being populated.

Because this object is a locatable resource type with a path, **core's `jsonapi` route subscriber
generates `jsonapi.{entity_type_id}.collection` at `/jsonapi/{entity_type_id}` automatically** — the
module contributes no `*.routing.yml`. (Confirmed by the functional test asserting
`Url::fromRoute('jsonapi.entity_test_with_bundle.collection')`, and live: `GET /jsonapi/node` → 200.)

## 2. Field-mapping superset — `getFieldMappingSuperset()` (`:148`, static)

Merges the per-bundle `ResourceTypeField[]` maps into one:

- First time a field name is seen → take that mapping.
- Field already present as a **boolean** (enabled/disabled, unmapped) → prefer any real (string/object)
  mapping, or an enabled one (`$superset[$name] = $field_mapping[$name] ?: $superset[$name]`, `:168`).
- Field already present with a **different object mapping** → the two bundles disagree on the public
  name/alias, so the field is pushed to `$undefined_field_names` and **removed from the superset**
  (`:171–176`) — its cross-bundle behaviour is intentionally left undefined rather than guessed.

`getRelatableResourceTypesSuperset()` (`:204`) unions each bundle's relatable types (via the shim's
`calculateRelatableResourceTypes()`) and intersects with the relationship fields that survived into the
field-mapping superset, keyed by public field name.

## 3. Field-resolver decorator — `CrossBundleFieldResolver` (`src/Context/CrossBundleFieldResolver.php`)

`extends Drupal\jsonapi\Context\FieldResolver` (declared with `parent: jsonapi.field_resolver` so it
inherits the same constructor args). Overrides two protected methods used while resolving
`filter` / `sort` / `include` paths:

- `getFieldItemDefinitions(array $resource_types, $field_name)` (`:29`) — splits the incoming resource
  types into bundle-specific vs `CrossBundlesResourceType`. For each cross-bundle type it recurses via
  `parent::getFieldItemDefinitions($resource_type->getBundleResourceTypes(), $field_name)` and takes
  the **first** candidate (field names are unique across an entity type's bundles, so any bundle that
  has the field gives the same definition), keyed by the cross-bundle type name. Bundle-specific types
  fall through to `parent::` unchanged, and the two result sets are merged.
- `getFieldAccess(ResourceType $resource_type, $internal_field_name)` (`:60`) — for a
  `CrossBundlesResourceType` it reduces over `getBundleResourceTypes()` with
  `AccessResult::allowed()->andIf(...)`, checking `view` access on **every bundle that actually has the
  field** (`$resource_type->hasField($internal_field_name)`). This is a **conservative AND**: a filter
  or sort on a field is permitted only if `view` access is allowed on all bundles carrying it. Non
  cross-bundle types delegate to `parent::getFieldAccess()`.

## 4. Shim — `ResourceTypeRepositoryShim` (`src/ResourceType/ResourceTypeRepositoryShim.php`)

`final`, `@internal`, `extends ResourceTypeRepository`, wired with
`parent: jsonapi.resource_type.repository`. It only re-exposes core's `protected` methods as public so
the decorator can call them: `getFields()` (`:19`), `getAllFieldNames()` (`:26`),
`calculateRelatableResourceTypes()` (`:30`). No behaviour change.

## Serialization: why response items keep their bundle type

The cross-bundle resource type governs **route + query + filter/sort resolution**, not per-entity
output. Core loads the collection via an entity query on the entity type id (no bundle condition,
`accessCheck(TRUE)`), then normalises **each entity through its own bundle-specific resource type**.
Live confirmation: `GET /jsonapi/node` returns items with `"type":"node--article"` and `self` links
under `/jsonapi/node/article/{uuid}`. Consequence for consumers: the collection is heterogeneous —
branch on each item's `type`; the fields present per item are that bundle's fields (subject to that
bundle's field access), not the whole superset.
