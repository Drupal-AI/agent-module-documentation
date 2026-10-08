<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Property Traversal (property_traversal) — agent index

**API-only** helper submodule of `entity_segment` (stands alone; core-only). Walks Typed Data property paths across entity references over core's own Typed Data definitions. Version 1.0.0-alpha2. Core `^11.1 || ^12`. Package `Entity Segment`. GPL-2.0-or-later. No UI, entity, config, permissions, or plugin types.

Dependencies: **core only** (no dependency on `entity_segment`). Modelled on Search API's `FieldsHelper` but with no Search API / `typed_data` dependency.

## Service
`property_traversal.fetcher` → `Drupal\property_traversal\PropertyTraversal` (autowired; alias `PropertyTraversalInterface`). Defined in `property_traversal.services.yml`, class `src/PropertyTraversal.php`, contract `src/PropertyTraversalInterface.php`.

## Interface
- `rootDefinition(string $entity_type_id): ComplexDataDefinitionInterface` — start point (`EntityDataDefinition::create()`).
- `resolve($root, string $path): array` — load-bearing walk to a discriminated result:
  - `leaf` → `entity_type`, `field`, `storage`, `property`, `data_type` (a queryable value).
  - `hop` → `entity_type` reached (empty path, or a path ending on `<ref>.entity`).
  - `error` → human-readable `message` (never throws — a removed field yields an error, not a fatal).
- Primitives: `nestedProperties()` (unions bundles' configurable fields — the module's reason to exist, drupal.org/node/2169813), `innerProperty()`, `isReference()`, `isDescendable()` (content-reference only), `targetType()`.

Path grammar: dot-separated; a `<field>.entity` boundary is a reference hop; a trailing `<field>` or `<field>.<property>` is the leaf. Consumed by base `field_value` for field discovery, hop introspection, validation, and labeling. Parent → [../../../1.0.x/agent/start.md](../../../1.0.x/agent/start.md).
