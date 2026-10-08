<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Segment: Group (entity_segment_group) — agent index

Integration **target submodule** bridging `entity_segment` to the contrib Group module: a segment can be Group content. Version 1.0.0-alpha2. Core `^11.1`. Package `Entity Segment`. GPL-2.0-or-later.

Dependencies: `entity_segment:entity_segment`, `group:group` (`drupal/group ^3.3 || ^4` — this submodule only, `ddev poser`).

## What it ships
- Group relation `group_segment` with a deriver — **one relation per segment type** (`group_segment:crm_contact`, `group_segment:user`, new types auto-derived): `Plugin/Group/Relation/GroupSegment` + `GroupSegmentDeriver`.
- Relation handlers (non-shared per-relation decorators, wired in `entity_segment_group.services.yml`): `SegmentAccessControl` (access-control), `SegmentEntityReference` (entity-reference).
- `QueryAccess/GroupSegmentQueryAccessHandler`, entity-reference selection `Plugin/EntityReferenceSelection/GlobalSegmentSelection`, validation `Plugin/Validation/Constraint/GlobalWhenGroupedConstraint[Validator]`, service `GroupCompatibility`, and hooks `src/Hook/{EntityTypeHooks,FormHooks,SegmentTypeHooks}`.

## Behavior
- **Additive access**: group roles ADD CRUD to a group's segments; `SegmentAccessControl::entityAccess()` downgrades Group's default `forbidden` to `neutral` so the base `SegmentAccessControlHandler` grants union in. Nothing is ever revoked.
- **Global-only**: only global segments can be group content — enforced by `GlobalSegmentSelection` (reference field scoped to global), the `GlobalWhenGrouped` constraint, and forcing global scope on in-group creation.

Details → [group-integration.md](group-integration.md). Parent engine → [../../../1.0.x/agent/start.md](../../../1.0.x/agent/start.md).
