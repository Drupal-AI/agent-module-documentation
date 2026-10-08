Broken reference is an admin diagnostic tool that scans all entity-reference and entity-reference-revisions fields on a Drupal site and reports which stored references point at entities that no longer exist.

---

The module adds a single admin report at `/admin/config/development/broken_reference` (also linked under Reports as "Broken entity references"). On load it runs a fast entity-query sampling pass to tell you whether any broken references likely exist; pressing "Build report" launches a Batch API job that loads every referencing entity in chunks of 30, checks each reference item's target, and stores the dangling ones in the private tempstore. The result is a table grouped by entity type, bundle and field, showing how many source entities hold broken references and how many target references are missing. It is purely diagnostic: it does NOT delete or repair anything. It only reads; the operator uses the findings to decide where to add cleanup hooks (`hook_ENTITY_TYPE_delete`) or to manually fix data. Nothing is scanned by external services and no content labels are exposed — the report shows only machine names and counts. Requires only Drupal core; supports entity_reference and, when present, entity_reference_revisions fields (e.g. Paragraphs).

---

- Audit an existing site for dangling entity references before a migration or upgrade.
- Diagnose intermittent "Call to a member function getCacheTags() on null" or similar fatal errors caused by references to deleted entities.
- Find nodes that still reference a taxonomy term, media item, or other node that was deleted.
- Detect Paragraphs (`entity_reference_revisions`) whose referenced revision no longer exists.
- Get a quick yes/no on whether broken references exist without running a full scan (the page's initial estimate).
- Produce a full grouped report of every broken reference by entity type, bundle and field.
- Quantify data-integrity debt: see total broken references and how many distinct type/bundle/field combinations are affected.
- Decide which entity types are missing `hook_ENTITY_delete` / `hook_ENTITY_TYPE_delete` cleanup logic.
- Validate that a custom delete hook is actually cleaning up references, by re-running the report after content changes.
- Spot fields where one source entity references multiple removed targets (source count vs. target count mismatch).
- Include a broken-reference check in a periodic content-QA routine.
- Confirm a bulk delete of taxonomy terms or media did not leave orphaned references behind.
- Sanity-check a site after importing content via Feeds or Migrate.
- Give a site owner a concrete list of fields to remediate before launch.
- Scope cleanup work by seeing exactly which bundles and fields are affected rather than guessing.
- Re-scan after a repair to confirm the broken reference count has dropped to zero.
- Restrict who can run the scan by granting the "Search broken entity references" permission only to trusted administrators.
- Use the report as evidence when arguing for adding referential-integrity safeguards to a content model.
