<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Back Reference

A small library module that answers "what references this entity?" by scanning all entity-reference fields that could target the given entity type/bundle and querying for matches.

- Provides the `entity_back_reference.back_reference_finder` service.
- Discovers applicable reference fields via the field map.
- Loads the referencing entities for a target ID.
- Intended as a building block for other code/displays.

---

# Installing & configuring

- Enable the module (`drush en entity_back_reference`).
- There is no UI, admin form, or configuration route.
- Inject or fetch `entity_back_reference.back_reference_finder` to use it.
- Depends only on core (entity + field APIs).
- No permissions are defined.

---

# Usage & behaviour

- `getReferencingFieldList($entityTypeId, $entityBundleId)` returns candidate `FieldConfig`s.
- `referenceFieldAppliesToEntity()` filters fields by `target_type` and `target_bundles`.
- `loadBackReferencedEntities(FieldConfig $field, $targetId)` returns the referencing entities.
- Results are cached in-object per field+target to avoid re-querying.
- The lookup query runs with `accessCheck(FALSE)`.
- Returned entities are the full loaded objects, not just IDs.
- The docblock states callers are responsible for applicability/access checks.
- No route, controller, formatter, or block ships in this version.
- Because there is no exposed surface, disclosure depends entirely on the calling code.
- Useful for "referenced by" panels, integrity checks, or pre-delete warnings.
- Handles any entity type with entity-reference fields.
- Field discovery uses `getFieldMapByFieldType('entity_reference')`.
- The service is stateless between requests aside from per-request caches.
- No database schema is added.
- Uninstalling simply removes the service.
- Callers displaying results to end users must re-apply entity access.
