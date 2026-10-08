Enhanced Taxonomy Manager replaces core's term overview page with a lazy-loading, collapsible drag-and-drop tree built for vocabularies too large for core's page, and wraps it with rename, merge, clone, find & replace, bulk operations, CSV import/export, revisions, undo and named snapshots.

---

Core's taxonomy overview is a flat weighted list that loads every term at once. That is fine for fifteen countries and unworkable for fifteen thousand subject headings — the page slows to a crawl, the drag handles stop responding, and reordering becomes something nobody attempts twice. ETM rebuilds that surface: the tree loads children on demand (`TreeController::getTermChildren` / `loadMoreTerms`), stages drag-and-drop changes in the browser and commits them in one batch through Drupal's Entity API (`TermController::saveOrderBatch`), so hooks, access checks and cache invalidation all still fire.

Around the tree sit the operations a real taxonomy programme needs: inline rename, term merge with automatic content-reference reassignment (`MergeTermsForm`), clone with or without children, find-and-replace with a preview step, orphan repair, duplicate detection, per-vocabulary statistics and a structural health check. Every mutating operation captures an auto-snapshot first, so changes are undoable (Ctrl+Z), and a named snapshot can be saved and restored — the feature that makes bulk work on a production vocabulary defensible rather than reckless. Snapshots and revisions live in two dedicated tables (`enhanced_taxonomy_snapshots`, `enhanced_taxonomy_revisions`) and are cleaned up when a vocabulary is deleted. An optional `etm_ai` submodule adds AI-driven term generation, placement suggestions, semantic duplicate detection, auto-description, health analysis, restructuring and natural-language search; it is a separate enable and requires the AI module.

Access is delegated per-vocabulary: `administer taxonomy` grants everything, otherwise a dynamically generated `etm manage terms in {vid}` permission (plus separate export/import permissions) lets you hand one vocabulary to an editor without giving them the whole taxonomy system.

---

- Manage a vocabulary with tens of thousands of terms without the page timing out.
- Reorder and reparent terms by drag and drop with instant feedback.
- Load a deep hierarchy lazily instead of loading every term up front.
- Rename a term in place by double-clicking it.
- Edit a term's name, description, status and weight in an AJAX dialog.
- Merge a duplicate term into another, reassigning all content references and reparenting its children.
- Clone a term, optionally including its whole subtree.
- Find and replace across term names with a preview before applying.
- Detect exact duplicate term names in a vocabulary.
- Repair orphaned terms whose parent no longer exists (reparent to root or delete).
- Undo the last change with Ctrl+Z, backed by automatic pre-operation snapshots.
- Save a named snapshot before a big reorganization and restore it in one click.
- Run a structural health check for orphans, cycles, deep nesting and weight gaps.
- Bulk publish, unpublish or delete many selected terms at once.
- Export a vocabulary to CSV (choosing fields, separator, BOM and depth).
- Export a vocabulary as an indented text list.
- Bulk import terms from an indented text list, with descriptions after a pipe.
- See how many content entities reference a given term, and where.
- Normalize sibling term weights to a clean sequential order.
- Filter terms by status, depth, child count or modification date with breadcrumb context.
- Jump from a search or filter result straight to the term's place in the tree.
- Delegate a single vocabulary to an editor who lacks `administer taxonomy`.
- Grant export or import access to a vocabulary separately from edit access.
- Generate large numbers of test terms (or purge them) with the bundled Drush commands.
