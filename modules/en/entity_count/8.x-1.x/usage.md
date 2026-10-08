<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Count builds an admin report showing how many entities of each type are stored, with an optional per-bundle breakdown.

---

Entity Count adds a sortable report at `/admin/reports/entity-count` (linked from Administration > Reports) that lists every entity type defined on the site alongside its total number of stored entities. For content entity types the total comes from an aggregate entity-query count; for configuration entity types it is the number of loaded config entities. When a type has more than one bundle, a "Per bundle" action opens a second report at `/admin/reports/entity-count/{entity_type}` breaking the total down by bundle. Both tables can be sorted by the Count column. The report is gated by a single permission, `access entity count`, and the module requires no configuration — install it, grant the permission, and open the report. It is a lightweight census and capacity-planning aid for administrators and site builders.

---

- See a site-wide census of how many entities exist per type.
- Check the total number of nodes stored in the database.
- Check how many user accounts exist.
- Count taxonomy terms across vocabularies.
- Count media entities on the site.
- Count files, comments, or menu links.
- Break a content type's total down by bundle (per node type).
- Break taxonomy term totals down per vocabulary.
- Sort the report by count to find the largest entity types.
- Sort ascending to find rarely-used entity types.
- Gauge database size drivers before a migration.
- Support performance and capacity planning with real entity totals.
- Verify a bulk import created the expected number of entities.
- Confirm a bulk delete removed the expected entities.
- Track entity growth over time by revisiting the report.
- Audit which entity types are actually in use on a site.
- Include config entity counts (views, image styles, etc.) in an inventory.
- Give site builders a quick data inventory during a site audit.
- Provide a reports-menu link for stakeholders to self-serve counts.
- Restrict the report to trusted roles via the `access entity count` permission.
- Estimate content volume when scoping a redesign or theme.
- Sanity-check entity counts after a configuration or module change.
