<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Merge duplicate nodes, taxonomy terms, or media entities into one survivor and re-point every entity-reference field on the site to the survivor.

---

Entity Reference Manager is a content-maintenance tool for consolidating duplicate content. You pick one or more source entities and a single target (survivor) of the same type (node, taxonomy term, or media); the module scans every `entity_reference` field on the site that points at a source, shows a per-field impact summary (field name, referencing entity type, reference count, and optionally revisions), and — after you confirm — rewrites all those references to the target using the Batch API. By default each source is deleted after its references are moved, but you can keep it. The same operation is available from a "Merge" tab/operation on node, term, and media pages, from a central admin form, and from a Drush command (`drush erm-merge`). It works entirely through core entity/field APIs, so there are no external dependencies.

---

- Merge two or more duplicate taxonomy terms into a single canonical term.
- Consolidate duplicate nodes created by imports or double submissions.
- Deduplicate media library entities that point to the same asset.
- Re-point every reference field on the site from a source entity to a survivor so no reference is left dangling.
- Preview exactly which fields and how many references will change before committing (two-step analyze-then-confirm flow).
- Merge multiple source entities into one target in a single run.
- Optionally keep the source entities after their references are moved (analysis/copy-references mode).
- Optionally rewrite references stored in past revisions as well as current values.
- Run large merges safely in the background with the Drupal Batch API.
- Clean up a taxonomy vocabulary that accumulated near-duplicate terms.
- Fix content modeled with two nodes that should have been one.
- Trigger a merge directly from a node's page via the "Merge" tab.
- Trigger a merge directly from a taxonomy term's page.
- Trigger a merge directly from a media entity's page.
- Script bulk merges from the command line during a data migration or cleanup.
- Merge entities as part of a post-import deduplication step.
- Reduce reference fragmentation before a site relaunch or content audit.
- Remove orphaned duplicate terms while preserving all tagged content.
- Collapse redundant category/tag terms so faceted search and listings stay clean.
- Restrict source/target selection to a single bundle so only comparable entities are merged.
- Automatically drop duplicate reference values on a field when source and target both appear.
- Combine several imported media items into one canonical asset used everywhere.
- Consolidate content ahead of a taxonomy restructure.
