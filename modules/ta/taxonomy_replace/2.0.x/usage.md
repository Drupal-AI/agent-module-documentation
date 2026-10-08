<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Replace lets you replace every node reference to one taxonomy term with references to one or more other terms in the same vocabulary, then deletes the original term.

---

The module adds a **Replace** tab and operation to each taxonomy term (`hook_entity_type_build` registers a `replace` entity form and link template at `/taxonomy/term/{taxonomy_term}/replace`). The route requires the `replace taxonomy terms` permission **and** `delete` access to that specific term (`_entity_access: taxonomy_term.delete`), and the operation link is only shown when both hold. The `TaxonomyReplaceForm` (a `ContentEntityDeleteForm` subclass, so it doubles as a confirm-and-delete step) lists the nodes that will be updated and offers an entity-autocomplete restricted to the same vocabulary, allowing multiple replacement terms. `TaxonomyReplaceService::replace()` finds affected nodes via the `taxonomy_index` table, and for each node adds the new term reference(s) to the correct entity-reference field (unless already present), removes the old term, and saves the node; it then logs the change and the form deletes the old term and redirects to the first replacement. A Drush command `taxonomy:replace <oldTid> <newTid> [--delete]` is also registered for scripted replacements.

Typical use is content cleanup: consolidating duplicate or misspelled terms, or merging one term into another before deleting it. Operational/security notes: the UI is properly gated (permission + per-term delete access), and DB queries use the database API with bound conditions (no raw SQL concatenation). Be aware the action is destructive — it edits and re-saves every affected node and deletes the source term — so run it deliberately (and note the bundled Drush command has a known argument bug in this branch, so prefer the UI or verify before scripting).

---
- Merge a duplicate taxonomy term into the correct one.
- Fix a misspelled term by replacing it with the corrected term.
- Consolidate several near-identical tags into a single term.
- Replace one term with multiple terms across all nodes.
- Delete an obsolete term after moving its content to another.
- Preview which nodes will be updated before confirming.
- Restrict replacement to terms in the same vocabulary.
- Require the `replace taxonomy terms` permission to use the tool.
- Enforce per-term delete access before allowing replacement.
- Access the Replace action from a term's operations dropdown.
- Access the Replace tab on the term's canonical page.
- Batch-clean taxonomy after a content migration.
- Reassign content when restructuring a vocabulary.
- Avoid orphaning nodes when removing a term.
- Keep existing references intact when a node already has the new term.
- Redirect to the new term after a replacement completes.
- Script term replacement with `drush taxonomy:replace`.
- Delete the old term automatically via the Drush `--delete` option.
- Log each replacement for auditing.
- Return to the vocabulary overview after cancelling.
