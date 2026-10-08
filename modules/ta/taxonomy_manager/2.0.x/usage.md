Taxonomy Manager replaces Drupal's one-term-at-a-time taxonomy admin with a single JavaScript tree interface where you can mass-add, delete, move, edit and (with a submodule) merge terms across a whole vocabulary.

---

Taxonomy Manager provides an alternate administration UI for the core Taxonomy module aimed at large vocabularies. At **Admin → Structure → Taxonomy Manager** (`/admin/structure/taxonomy_manager/voc`) you pick a vocabulary and get a Fancytree-powered, AJAX tree of every term with its hierarchy, a paged term list (default page size 500, configurable), a search/autocomplete box, and a toolbar of bulk operations. Selecting terms via checkboxes enables toolbar actions that open modal dialog forms: **Add** (mass-add many terms at once, one per line, with `-` prefixes to build parent/child depth and an optional description delimiter), **Delete** (bulk delete with an option to also delete orphaned children), **Move** (re-parent selected terms, optionally keeping old parents for multi-parent hierarchies), and **Export CSV / Export list**. Clicking a single term loads its full edit form beside the tree and saves changes over AJAX, and term weights can be nudged up/down with arrows that persist instantly. Access to term operations is governed by core Taxonomy permissions (`administer taxonomy`, and per-vocabulary `create/edit/delete terms in {vid}`); the module itself adds an `access taxonomy manager list` permission plus per-vocabulary CSV/list export permissions. A settings form at `/admin/config/user-interface/taxonomy-manager-settings` (`taxonomy_manager.settings`) tunes page size, the description delimiter, the mouse-over effect, and translation display. The bulk logic lives in the `taxonomy_manager.helper` service (`massAddTerms()`, `deleteTerms()`) so it can be reused from code. An optional **Taxonomy Manager Merge** submodule integrates the Term Merge module to fold duplicate terms into one, reassigning their references.

---

- Administer a large vocabulary from a single tree view instead of the paginated core term list.
- Mass-add dozens of terms at once, one per line, in a modal textarea.
- Build a term hierarchy in one paste by prefixing child terms with dashes (`-`, `--`, ...).
- Import a term name and description together on one line using the configurable delimiter (default `|`).
- Add new terms as children of one or more terms selected in the tree.
- Bulk-delete many selected terms in one confirmation step.
- Optionally delete the orphaned children of deleted parent terms (or re-root them).
- Move (re-parent) selected terms under a different parent term.
- Keep old parents while adding a new one to create multi-parent relationships.
- Edit a term's name and description inline beside the tree, saved over AJAX with no page reload.
- Reorder terms by nudging their weight up or down with arrow controls that save instantly.
- Change a term's weight from its edit form via a select that reorders the tree live.
- Search/autocomplete to jump straight to an existing term for editing.
- Switch between vocabularies from the toolbar dropdown without leaving the interface.
- Expand and collapse parent terms to lazily load children of deep hierarchies.
- Page through very large vocabularies with the built-in pager (page size 25–10000).
- Export a vocabulary's terms to CSV from the toolbar.
- Export a flat term list from the toolbar.
- Tune the pager page size, description delimiter, and mouse-over effect on the settings form.
- Mass-create terms programmatically via the `taxonomy_manager.helper` service (`massAddTerms()`).
- Delete terms in code with optional orphan handling via `deleteTerms()`.
- Grant non-admins scoped access with core per-vocabulary term permissions plus the list/export permissions.
- Merge duplicate terms into a single target term with the Taxonomy Manager Merge submodule.
- Reassign node/entity references from merged terms onto the surviving term (via Term Merge).
- Keep original term titles as synonyms of the merged target when merging.
- Display translatable term fields side by side per language when content translation is configured.
