<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM Contact Segment (entity_segment_crm) — agent index

Thin **target submodule** of `entity_segment` for the contrib CRM module. Version 1.0.0-alpha2. Core `^11.1`. Package `Entity Segment`. GPL-2.0-or-later.

Dependencies: `entity_segment:entity_segment`, `crm:crm` (`drupal/crm ^1.0@beta` — this submodule only, resolved via `ddev poser`).

## What it ships
- The **`crm_contact` segment type** — `config/install/entity_segment.segment_type.crm_contact.yml` (`id: crm_contact`, `target_entity_type_id: crm_contact`, enforced module dep `entity_segment_crm`). Makes contacts a targetable audience.
- A **Segments area under CRM** at `/crm/segments` — route `entity_segment_crm.contact_segments` reuses the base `SegmentCollectionController::byType`, pinning `segment_type: crm_contact` as an upcast route default gated by `_segment_list_access: 'TRUE'` (which also admits the `administer segments` super-permission). Links: `entity_segment_crm.links.task.yml` (secondary task under `crm.admin`), `entity_segment_crm.links.action.yml` (Add segment via base `AddSegment` local action).

No PHP classes, permissions, or config schema of its own; all engine behavior is the base module's. See the parent [start.md](../../../1.0.x/agent/start.md). Drupal 12 blocked (base blocker + `drupal/crm` needs core `telephone`, removed in D12).
