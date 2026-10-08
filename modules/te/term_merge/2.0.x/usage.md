<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Term Merge lets editors collapse two or more taxonomy terms in the same vocabulary into a single term, re-pointing every entity that referenced the old terms at the survivor before deleting them.

---

The module adds a **Merge** local task to each vocabulary's term overview page and a three-step wizard behind it: pick the terms (`/admin/structure/taxonomy/manage/{vocabulary}/merge`), choose a target — either a brand-new term name or an existing term in the same vocabulary (`…/merge/target`) — and confirm (`…/merge/confirm`). Selections are carried between steps in the `term_merge` private tempstore under the keys `terms`, `target` and (with the optional Synonyms module) `terms_to_synonym`. The actual work is done by the `term_merge.term_merger` service (`Drupal\term_merge\TermMerger`, implementing `TermMergerInterface`) which exposes `mergeIntoNewTerm(array $terms, string $label)` and `mergeIntoTerm(array $terms, TermInterface $target)`. Reference migration is delegated to the required **Term reference change** module's `term_reference_change.migrator` service, so any entity field referencing a source term is rewritten to the target before the source terms are deleted — the merge is destructive and cannot be undone. Both methods refuse to run on an empty list or on terms from mixed vocabularies (`RuntimeException`), and `mergeIntoTerm()` also refuses a target in a different vocabulary. Just before deletion the module dispatches the `term_merge.terms_merged` event (`TermMergeEventNames::TERMS_MERGED`) carrying a `TermsMergedEvent` with `getSourceTerms()` and `getTargetTerm()`, which is the supported extension point. Access is deliberately two-layered: the routes require the module's own `merge taxonomy terms` permission **and** pass a `_term_merge_access_check` that additionally demands `edit terms in <vocabulary_id>` or `administer taxonomy`. The module ships no settings form, no configure route, no config schema, no Drush commands and no plugins.

---

- Deduplicate a tags vocabulary where editors created "Bicycle", "Bicycles" and "Bike" as separate terms.
- Consolidate imported taxonomy noise after a migration without hand-editing every node.
- Merge case-variant duplicates ("berlin" into "Berlin") while keeping all content correctly tagged.
- Fold several narrow topic terms into one broader term when simplifying an information architecture.
- Retire a deprecated category term by merging it into its replacement.
- Merge misspelled terms into the correctly spelled one and have references follow automatically.
- Create a brand-new canonical term and merge a cluster of synonyms into it in one pass.
- Clean up a free-tagging vocabulary that has drifted over years of editorial use.
- Rewrite entity reference fields on nodes, media, users and paragraphs in bulk via `term_reference_change`.
- Script a bulk taxonomy cleanup with `term_merge.term_merger` in a `drush php:eval` or an update hook.
- Merge terms as part of a deployment/update hook so all environments converge on the same taxonomy.
- Delegate taxonomy tidy-up to editors by granting `merge taxonomy terms` plus `edit terms in <vocab>`.
- Restrict merging to a single vocabulary by granting only that vocabulary's `edit terms in …` permission.
- React to a merge from custom code — log it, invalidate a cache, ping an external index — via `term_merge.terms_merged`.
- Update a search index or external taxonomy mirror when terms are collapsed, using `TermsMergedEvent`.
- Carry old term labels over as synonyms on the target term when the Synonyms module is installed.
- Reduce facet clutter in Search API / Facets by collapsing near-duplicate filter values.
- Normalise a vocabulary before exporting content to another system.
- Merge terms created by two teams that were maintaining the same vocabulary independently.
- Collapse a "test"/"staging" term into the real one after content QA.
- Shrink an oversized vocabulary so autocomplete term reference widgets stay usable.
- Guarantee referential integrity when deleting a term — merge instead of delete so nothing loses its tag.
- Preview exactly which terms will disappear on the confirm step before committing the change.
- Migrate the Drupal 7 `merge terms` permission automatically on upgrade (the module maps it to `merge taxonomy terms`).
