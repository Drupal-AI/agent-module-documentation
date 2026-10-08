<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Property Traversal is an API-only service that walks nested Typed Data property paths across entity references over Drupal core's own Typed Data definitions.

---

An API-only helper submodule (shaped to stand alone as its own project) that ships one service, `property_traversal.fetcher` (`Drupal\property_traversal\PropertyTraversalInterface`). It answers property-path questions over a root entity definition: `rootDefinition($entity_type_id)`, the load-bearing `resolve($root, $path)` which walks a dot-separated path to a discriminated `leaf` / `hop` / `error` result, and the primitives `nestedProperties()`, `innerProperty()`, `isReference()`, `isDescendable()`, and `targetType()`. Its point over core's `EntityDataDefinition` is unioning a hop target's configurable fields across its bundles, so a reference chain such as `field_ref.entity.some_field` does not silently degrade to base fields only (drupal.org/node/2169813). Modelled on Search API's `FieldsHelper` but with no dependency on Search API or the `typed_data` contrib module. `resolve()` is forgiving by contract — an unresolvable path returns an `error` result rather than throwing — and it depends solely on core, so it can be enabled on its own.

---

- Resolve a dot-separated Typed Data property path from a root entity type.
- Walk entity-reference chains (`uid.entity.name`) to any depth.
- Distinguish a queryable leaf property from a reference hop from an invalid path.
- Union a hop target's configurable fields across all its bundles.
- Reach a configurable field on a referenced entity, not just base fields.
- Get a leaf's entity type, field, storage, property, and data type.
- Get the entity type reached by a partial reference-hop path.
- Test whether a field definition is an entity reference (`isReference()`).
- Test whether a reference is descendable into a content entity (`isDescendable()`).
- Get a reference field's target entity type (`targetType()`).
- Render a stable label for a stored path whose fields no longer exist (error, no throw).
- Build field/operator selectors for any content entity type from its property graph.
- Reuse the traversal in your own module without pulling in Search API.
- Inject the interface (autowiring) or fetch `property_traversal.fetcher` directly.
- Back the Entity Segment `field_value` plugin's field discovery and validation.
