<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Define, once and centrally, a fixed set of target entities that appear as a computed entity-reference field on a source entity type.

---

Computed relationships lets an administrator create `computed_relationship` records that each pin a hand-picked list of target entities (selected by UUID from a chosen entity/bundle) to a computed `entity_reference` base field on a chosen source entity type. When a source entity is loaded, the field resolves to that same fixed target set at runtime rather than storing reference values per entity — so instead of adding a reference field and manually setting the same default targets on every piece of content, you declare the relationship once and the field is created and populated automatically. It supports JSON:API out of the box, and when `jsonapi_extras` is present it registers the computed field into already-existing resource configs automatically. It is a fields/developer feature; depends only on core `field`; supports Drupal 9, 10, and 11. Note: the generated field is a base field on the whole source entity type (it shows on all its bundles), and this release is a beta not covered by Drupal's security advisory policy.

---

- Attach the same fixed set of related entities to every entity of a content type without editing each one.
- Centrally declare a reference relationship once instead of maintaining per-entity default values.
- Add a computed `entity_reference` field to a source entity type via config, no code.
- Pick specific target entities by UUID from a chosen target entity/bundle.
- Surface a curated set of "related" nodes, terms, media, or users alongside content.
- Expose the computed relationship over JSON:API as a normal relationship.
- Auto-register the computed field into existing `jsonapi_extras` resource configs.
- Merge several relationship records that share one field name into a single multi-value field.
- Manage relationships from an admin list at `/admin/content/computed-relationship`.
- Gate all relationship management behind the `administer computed relationship` permission.
- Give each relationship an optional label and machine field name (auto-generated if left blank).
- Enable/disable individual relationship records and see them in a summary table.
- Use the AJAX add/edit form to filter target entities by the selected target bundle.
- Attach reference values that stay consistent site-wide because they are defined in one place.
- Reference across entity types (e.g. a node field pointing at taxonomy terms or media).
- Populate reference data at runtime so it is never stored on the source entities.
- De-duplicate target entities automatically (repeated UUIDs collapse to one).
- Serve as a building block for API-driven front ends that read related content from JSON:API.
- Provide an author/owner and created/changed audit trail per relationship record.
- Prototype relationship structures quickly without creating storage fields.
