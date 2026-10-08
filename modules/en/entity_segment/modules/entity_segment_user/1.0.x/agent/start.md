<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Segment: User (entity_segment_user) — agent index

Thin **target submodule** of `entity_segment` for core `user`. Version 1.0.0-alpha2. Core `^11.1`. Package `Entity Segment`. GPL-2.0-or-later.

Dependencies: `entity_segment:entity_segment`, `drupal:user`.

## What it ships
- The **`user` segment type** — `config/install/entity_segment.segment_type.user.yml` (`id: user`, `target_entity_type_id: user`, enforced module dep `entity_segment_user`). This makes users a targetable audience.
- A **Segments area under People** at `/admin/people/segments` — route `entity_segment_user.people_segments` reuses the base `SegmentCollectionController::byType`, pinning `segment_type: user` as an upcast route default gated by `_segment_list_access: 'TRUE'`. Links: `entity_segment_user.links.task.yml` (People local task), `entity_segment_user.links.action.yml` (Add user segment).

No PHP classes, no permissions, no config schema of its own — all engine behavior is the base module's. See the parent [start.md](../../../1.0.x/agent/start.md).
