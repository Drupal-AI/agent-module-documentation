Adds a "Bulk Delete Terms" button to the taxonomy terms overview page so an administrator can select and delete many terms in one confirmed action.

---

Bulk Term Delete is a small, dependency-light taxonomy utility (core `taxonomy` only). It alters the core taxonomy overview form (`taxonomy_overview_terms`) to add a "Bulk Delete Terms" button, then provides a two-step flow: a `tableselect` form listing every term in the vocabulary (indented by depth) where you tick the ones to remove, followed by a standard Drupal confirmation form that lists each selected term and permanently deletes them on confirm. Every entry point is gated by the core `administer taxonomy` permission, the apply step is a POST confirm form, and each deletion is written to the `bulk_term_delete` logger channel with the acting user and the term labels/IDs. There are no settings, no config, no permissions of its own, no Drush commands, and no plugins — it is purely UI glue over core term deletion.

---

- Clean up a large, messy vocabulary by removing dozens of obsolete terms in a single pass instead of one-by-one.
- Delete all terms in a vocabulary before re-importing a fresh term set from a feed or migration.
- Remove test/demo taxonomy terms after building out a site.
- Prune deprecated tags after a content taxonomy is restructured.
- Quickly empty a staging vocabulary that accumulated junk terms.
- Select a contiguous block of terms from the overview list and delete them together.
- Deep-link an editor to a pre-filtered selection using the `?tids=1,2,3` query parameter on the selection form.
- Remove a category tree's leaf terms while keeping parents (select only the indented children).
- Bulk-delete terms as part of a taxonomy consolidation (merge-then-delete workflow) where the survivors stay and the rest go.
- Give trusted taxonomy administrators a faster editorial cleanup tool without writing custom code.
- Clear out auto-generated terms created by an earlier bad import.
- Delete terms in a vocabulary that a Views/entity-reference field no longer uses.
- Confirm exactly which terms are about to be removed via the itemized confirmation list before committing.
- Maintain an audit trail of who deleted which terms via the module's watchdog log entries.
- Retire a whole subject area's terms when a section of the site is decommissioned.
- Speed up periodic taxonomy housekeeping on editorial sites with churny tag vocabularies.
- Reduce term sprawl in flat "tags" vocabularies that grew unbounded from free-tagging.
- Trigger the flow from the standard Structure → Taxonomy → List terms UI, no extra navigation to learn.
- Use it on any vocabulary — the vocabulary machine name is a route parameter, so it works per-vocabulary.
