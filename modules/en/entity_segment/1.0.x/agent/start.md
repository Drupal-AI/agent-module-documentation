<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Segment (entity_segment) — agent index

Generic **audience-segmentation engine**: a `segment` content entity whose bundle names the **target content entity type** it selects, plus a resolver that turns a stored **AND/OR condition tree** into live target-entity IDs. Version **1.0.0-alpha2** (pre-release). Core `^11.1` (Drupal 12 withheld pending `drupal/entity`). Package `Entity Segment`. License GPL-2.0-or-later.

Dependencies: core `options`, `user`, `views`; contrib `entity` (`drupal/entity ^1.5`); own submodule `property_traversal`. Optional (guarded by `module_exists()`): `diff`, `views_bulk_operations`, `eca`, and JSON:API.

## What it provides
- Entities: `segment` (content, revisionable, `src/Entity/Segment.php`) and `segment_type` (config bundle, `src/Entity/SegmentType.php`, key `target_entity_type_id`).
- Plugin type `entity_segment` (attribute `#[EntitySegment]`, namespace `Plugin/EntitySegment`, manager `plugin.manager.entity_segment`). Shipped plugin: `field_value` (`FieldValue`).
- Services: `entity_segment.resolver`, `entity_segment.audience_access`, `entity_segment.target_type_provider`, `entity_segment.operator_category_resolver`, `entity_segment.condition_tree_renderer`, `entity_segment.segment_list_access`.
- Two site-wide permissions (`administer segment types`, `administer segments`) plus **nine per-segment-type** permissions + a raw-membership permission (`SegmentPermissions`).
- Routes: segment collections under `/admin/content/segments`, segment types under `/admin/structure/segment-type`, JSON:API `resolved-members` endpoints.

## Solution docs
- Segment types + the segment entity, fields, scope → [config/entities.md](config/entities.md)
- The `entity_segment` plugin type, `field_value`, reference traversal → [plugins/segment-plugins.md](plugins/segment-plugins.md)
- Resolver, audience-access chokepoint, permissions & access handlers → [api/resolver-and-access.md](api/resolver-and-access.md)
- Views filter, tokens, ECA, VBO, Diff, JSON:API → [integrations/consumers.md](integrations/consumers.md)

## Submodules (own doc trees under `modules/`)
- `entity_segment_user` — ships the `user` segment type + People area.
- `entity_segment_crm` — ships the `crm_contact` segment type + CRM area (needs `drupal/crm`).
- `entity_segment_group` — segments as Group content (needs `drupal/group`).
- `property_traversal` — standalone Typed Data property-path traversal service (core-only).
