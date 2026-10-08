<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity expand (entity_expand) — agent index
**Developer API that decorates a loaded entity with custom methods + fluent field helpers.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10 || ^11 (PHP ^7 || ^8)
- **Package:** Development
- **API:** `entity_expand_load(EntityInterface)`, `_entity_load($type,$id,$unchanged=false)`; extend `EntityExpandBase`; implement `hook_entity_expand_load($entity, $entity_type_id)`
- **No routes, permissions, services or config.**

**Security:** code-only helper with no HTTP surface; it wraps entities the caller already loaded and applies no access logic of its own, so callers remain responsible for access checks. No findings.

See [api/expand.md](api/expand.md).
