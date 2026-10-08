Taxonomy Entity Index maintains a denormalized database table mapping every content entity to the taxonomy terms it references, for any entity type you choose — a general-purpose replacement for core's node-only `taxonomy_index`.

---

The module creates a `taxonomy_entity_index` table (columns `entity_type`, `bundle`, `entity_id`, `revision_id`, `field_name`, `delta`, `tid`) and keeps it in sync via entity CRUD hooks: on insert/update it scans the entity's taxonomy_term entity-reference fields and writes one row per referenced term, and on delete (of the entity, a revision, a term, or a field instance) it removes the matching rows. You choose which entity types to index on the settings form (`taxonomy_entity_index.admin`, `/admin/config/system/taxonomy-entity-index`), which stores a `types` list plus two booleans — `index_revisions` (keep a row per historical revision) and `index_per_field` (store a separate row per field even when the same term appears in several fields). A companion reindex form and the Drush command `taxonomy_entity_index:rebuild` (aliases `tei:rebuild`, `tei-rebuild`) batch-rebuild the table for the configured types. The module ships Views integration — an argument (`taxonomy_entity_index_tid_depth` and a UUID variant with configurable term-hierarchy `depth`), a field (`taxonomy_entity_index_tid`), and a filter (`taxonomy_entity_index_tid_depth`) — so you can build listings of any entity type by term with depth support. It only indexes entities whose ID key is an integer, and defines no permissions of its own (the admin routes require `administer site configuration`).

---

- Build a View of media (or users, or custom entities) filtered by taxonomy term, not just nodes.
- Provide a "content tagged with term X, including child terms" listing with depth support.
- Replace core's node-only `taxonomy_index` with a cross-entity-type index.
- Index paragraphs or commerce products by the terms they reference.
- Add a contextual filter that accepts a term ID (or UUID) with a configurable hierarchy depth.
- Show which terms an entity references by joining against the index table.
- Count how many entities reference a given term across all indexed types.
- Keep a per-revision term index to query historical taxonomy relationships (`index_revisions`).
- Distinguish which field a term came from by enabling `index_per_field`.
- Rebuild the whole index after a bulk import with `drush taxonomy_entity_index:rebuild`.
- Reindex only specific entity types, e.g. `drush tei:rebuild node,media`.
- Reindex from the admin UI via the reindex form after changing which types are indexed.
- Drive a faceted-style term browse page across multiple entity types.
- Feed a "related content by shared terms" block using the index table.
- Automatically clean up index rows when a term is deleted.
- Automatically drop index rows when an entity or one of its revisions is deleted.
- Automatically remove rows when a taxonomy field instance is deleted from a bundle.
- Select which entity types participate in indexing from a single settings form.
- Query the `taxonomy_entity_index` table directly for reporting or migration checks.
- Build a Views field that lists an entity's taxonomy terms with an optional link to the term page.
- Limit a Views term field to specific vocabularies.
- Support UUID-based term arguments for decoupled/JSON:API-style routing.
- Provide term-based navigation for entity types that lack core taxonomy Views integration.
- Keep the index current automatically as editors add or change tags on content.
