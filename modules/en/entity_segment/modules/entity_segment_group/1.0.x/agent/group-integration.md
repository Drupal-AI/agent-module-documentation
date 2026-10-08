<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group integration mechanics

All classes under `modules/entity_segment_group/src/`.

## Relation + deriver
- `Plugin/Group/Relation/GroupSegment` — the `group_segment` relation plugin. `GroupSegmentDeriver` derives one relation per `segment_type`, so any segment type (shipped or admin-created) gets its own relation with no code. A group type installs the relations it accepts via Group's own relation UI.

## Access model — additive, never subtractive
- `Plugin/Group/RelationHandler/SegmentAccessControl` (decorates `group.relation_handler.access_control`, non-shared): `entityAccess()` asks the wrapped default handler; if the result `isForbidden()` it is replaced with `AccessResult::neutral()->addCacheableDependency($result)`. A group `allowed` (or genuine neutral) passes through. So Group can only ADD access; the base `SegmentAccessControlHandler` (owner/scope/admin) still decides otherwise. The permission provider keeps Group's default (standard per-relation create/view/update/delete any/own).
- `QueryAccess/GroupSegmentQueryAccessHandler` — the query-access counterpart, so group-visible segments appear in access-checked listings. (The base `SegmentQueryAccessHandler` documents this as an extension point: group grants are membership-based and not expressible as segment base-field conditions, so they are OR'd in here.)

## Global-only rule (enforced end to end)
- `Plugin/Group/RelationHandler/SegmentEntityReference` (decorates `group.relation_handler.entity_reference`, non-shared) + `Plugin/EntityReferenceSelection/GlobalSegmentSelection` — scope the relation's reference field to **global** segments, so the group UI only offers eligible segments.
- `Plugin/Validation/Constraint/GlobalWhenGroupedConstraint` + `...Validator` — reject a personal segment being grouped, and reject switching a grouped segment back to personal.
- Hooks (`src/Hook/EntityTypeHooks`, `FormHooks`, `SegmentTypeHooks`) + `GroupCompatibility` service wire the constraint, the in-group-creation "force global" behavior, and per-Group-version compatibility.

## Flows (Group's native UI)
- "Create relation" builds a new segment (forced global) already related to the group.
- "Add existing content" relates an existing global segment.

Tested against both `drupal/group:^3.3` and `4.0.0-alpha1` (run separately — the two cannot be installed together).
