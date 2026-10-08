Taxonomy Term Replace provides an admin dashboard that bulk-replaces a referenced taxonomy term on nodes with another term from the same vocabulary, shows how many nodes reference a term, and can export that list as CSV.

---

The module adds a single admin form at `/admin/structure/taxonomy/taxonomy-term-replace` (route `taxonomy_term_replace.dashboard`, gated by the permission `access Taxonomy Term Replace dashboard`), linked from the Taxonomy vocabulary collection. You pick a vocabulary, then a **target** term and a **replacement** term (both from that vocabulary). Clicking **Search** lists the nodes associated with the target term in a selectable table (Node ID, URL, content type, status); a checkbox adds unpublished nodes to the search. For published nodes it queries core's `taxonomy_index` table; for the unpublished path it scans each content type's fields for an entity-reference field whose `target_type` is `taxonomy_term` and whose target bundle matches the vocabulary, then loads nodes referencing the term. You select rows and click **Process replacement**, which runs a batch that, for each node, finds the matching `target_id` in the reference field and swaps it to the replacement term's id, then saves the node. A **Download table** button exports the searched node list to a CSV (`public://taxonomy-term-node-search.csv`). The module has no configuration, config schema, plugins, services, or Drush commands — it is purely this UI workflow plus one permission.

---

- Merge a duplicate taxonomy term into the canonical one across all nodes that use it.
- Rename-by-replace: move every node from an old term to a new term, then delete the old term.
- Consolidate several near-identical tags into a single tag in bulk.
- Reassign content from a deprecated category to its successor.
- See how many published nodes are tagged with a specific term before deleting it.
- Include unpublished nodes in a term's usage count and replacement.
- Export a CSV of all nodes referencing a given term for an audit.
- Clean up taxonomy after an import created redundant terms.
- Bulk-move articles from a misspelled term to the corrected term.
- Retire a seasonal tag by replacing it with an evergreen one.
- Reduce vocabulary sprawl by folding synonyms into one term.
- Verify a term is unused (zero associated nodes) before removing it.
- Reorganize a content taxonomy without editing each node by hand.
- Replace a term only on selected nodes rather than all of them.
- Support editorial re-tagging campaigns across a large content set.
- Produce a report of term usage for stakeholders via the CSV export.
- Migrate content between vocabularies-of-record by replacing term references.
- Fix incorrectly assigned category terms in bulk after a migration.
- Preview affected nodes (with links) before committing the replacement.
- Replace a term used only on unpublished drafts.
- Combine two product-category terms following a catalog restructure.
- Free up a term for deletion by moving its content elsewhere first.
- Give non-developers a safe UI to perform bulk term reassignment.
