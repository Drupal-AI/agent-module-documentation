<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Repeat Group (entity_repeat_group) — agent index

Optional submodule of **Entity Repeat**. Adds each generated (replicated) entity to the same Group
that the original entity belongs to. Depends on `entity_repeat` and contrib `group`. No config, no
routes, no permissions, no config schema. Core `^9.3 || ^10 || ^11`, GPL-2.0-or-later, version 1.1.4.

Parent project index: [../../../1.1.x/agent/start.md](../../../1.1.x/agent/start.md).

## What it does

Purely procedural in `entity_repeat_group.module`:
- `entity_repeat_group_form_alter()` — on entity forms, stores the entity plus its `group` (add form)
  or existing `group_content`/`group_relationship` (edit form) in form storage, and appends
  `_entity_repeat_group_submit` to the submit handlers; bails if the entity is in no group.
- `_entity_repeat_group_submit()` — reads Entity Repeat's key/value `replications:{uuid}` list and
  adds each generated clone to the group via `addRelationship()` (Group 3+) or `addContent()`
  (Group 2).
- `_group_relationship_exists()` — runtime switch: TRUE if the `group_relationship` entity type
  exists (Group 3+), else uses the legacy `group_content` API.
- `entity_repeat_group_module_implements_alter()` — moves this module's `form_alter` to run last.

Details → [api/group.md](api/group.md).
