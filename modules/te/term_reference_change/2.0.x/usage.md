<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Term Reference Change is a pure API module that finds every entity referencing a taxonomy term and can rewrite those references from one term to another in bulk. It ships no UI, no routes, no settings and no permissions — install it only because another module (or your own code) depends on it.

---

The module registers exactly two services. `term_reference_change.reference_finder` (`ReferenceFinder`) walks every fieldable entity type, collects every non-computed `entity_reference` field whose `target_type` setting is `taxonomy_term` (deliberately skipping the special `parent` field, which fatals in entity queries), and can then load every entity that references a given term via `loadByProperties([$field_name => $term->id()])`, returning them grouped by entity type ID. `term_reference_change.migrator` (`ReferenceMigrator`) builds on that: `migrateReference($sourceTerm, $targetTerm, $limit)` loads the referencing entities, swaps every field delta whose `target_id` equals the source term ID for the target term ID, removes duplicate targets that the swap may have created inside a multi-value field, and saves each changed entity. The optional `$limit` argument is an array of entity IDs keyed by entity type ID, so a caller can restrict the migration to, say, only certain nodes. Because entities are saved with `$entity->save()`, all normal hooks, validation-free presave logic and revision defaults apply. There is no batch API wrapper, no queue and no dry-run mode — the caller owns chunking and progress reporting. The README is explicit that the module has no user-facing functionality; its only reason to exist is to be a shared dependency for term-merge tooling.

---

- Merge two duplicate taxonomy terms by re-pointing every reference to the surviving term before deleting the loser.
- Build a "merge terms" admin form in a custom module and delegate the heavy lifting to `term_reference_change.migrator`.
- Clean up a taxonomy after a content migration that created near-duplicate terms.
- Consolidate a vocabulary from 400 free-tagging terms down to a curated 40 without losing content associations.
- Re-point references from a deprecated term to its replacement as part of an editorial taxonomy governance workflow.
- Find every node, media item, user, block or paragraph that references a term before allowing an editor to delete it.
- Show a "this term is used by N entities" warning on a term delete form using `findReferencesFor()`.
- Enumerate all taxonomy term reference fields on the site with `findTermReferenceFields()` for an audit report.
- Generate a site-structure report of which bundles actually use a given vocabulary.
- Restrict a term migration to a single entity type (e.g. only `node`) by passing a `$limit` array keyed by entity type.
- Restrict a term migration to a hand-picked list of node IDs during a staged rollout.
- Deduplicate a multi-value term reference field that ends up with the same target twice after a merge.
- Power a Drush command in your own module that merges terms from the command line.
- Drive a taxonomy consolidation from a migration post-import event subscriber.
- Swap a term used by Views contextual filters across all content when a vocabulary is restructured.
- Support "rename plus reparent" flows where a term is replaced rather than edited.
- Back a batch operation that walks terms in chunks and calls `migrateReference()` per chunk.
- Let a content moderation workflow reassign topics when a section of the site is retired.
- Re-point references stored on non-node entities such as media, users, taxonomy terms and custom blocks in one pass.
- Serve as the shared dependency for contributed term-merge UIs so they do not each reimplement reference discovery.
- Validate before a vocabulary delete that no fieldable entity still references its terms.
- Move references off a term that is being converted into a different vocabulary.
- Write a kernel test fixture that asserts references followed a term merge correctly.
- Detect which entity types on the site have taxonomy term reference fields at all, to decide whether a feature is relevant.
- Provide a programmatic escape hatch when the taxonomy UI has no bulk "change term" operation.
