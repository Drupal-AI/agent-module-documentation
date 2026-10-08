<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy term depth adds a `depth_level` integer base field to every taxonomy term that stores how deep the term sits in its hierarchy (root = 1, its child = 2, and so on), kept up to date automatically and exposed to Views for sorting and filtering.

---

The module declares a `depth_level` base field on the `taxonomy_term` entity
(`hook_entity_base_field_info`), stored in the `taxonomy_term_field_data` table. Whenever a
term is inserted or updated (`hook_entity_insert`/`hook_entity_update`) it recomputes the value
by walking the parent chain (`taxonomy_term__parent`) and writes the new depth, so the field
stays correct as terms are created or re-parented. On install it queues **all** existing terms
for calculation via a batch, using a `taxonomy_term_depth.queue_service` (QueueManager) and a
`taxonomy_term_depth_update_depth` QueueWorker; you can re-run this per vocabulary from the
**Update term depths** local task / entity operation
(`/admin/structure/taxonomy/manage/{vocabulary}/taxonomy_term_depth_update`) or programmatically
via the queue service (`queueBatch()`, `queueBatchMissing()`, `clear()`, `queueSize()`). A set
of procedural helpers reads the hierarchy: `taxonomy_term_depth_get_by_tid($tid, $force)`
(cached, with an optional forced SQL recalculation that also updates the stored value),
`taxonomy_term_depth_get_parent()`, `taxonomy_term_depth_get_parents()` (chain of ancestors),
`taxonomy_term_depth_get_children()`, and `taxonomy_term_depth_get_full_chain()`. The field is
added to Views (`hook_views_data_alter`) as a numeric **Depth** field with sort and filter, so
you can build views like "top-level terms only" or "terms at level ≤ 2". Because a stored base
field cannot be dropped while it holds data, the module ships an uninstall validator plus a
Drush command (`term-depth-prepare-uninstall`, alias `tdpu`) and a *Delete taxonomy term depths
data* form to null the values before uninstalling.

---

- Store each taxonomy term's hierarchy depth (1-based) in a queryable `depth_level` field.
- Show only top-level (depth = 1) terms in a Views-based menu or listing.
- Filter a term View to a maximum depth (e.g. levels 1–2) for a compact navigation.
- Sort terms by depth to render a hierarchy outline.
- Get a single term's depth in code with `taxonomy_term_depth_get_by_tid($tid)`.
- Force a fresh depth recalculation for a term with `taxonomy_term_depth_get_by_tid($tid, TRUE)`.
- Retrieve a term's full ancestor chain with `taxonomy_term_depth_get_parents($tid)`.
- Retrieve descendants with `taxonomy_term_depth_get_children($tid)`.
- Build a complete parent→term→child chain with `taxonomy_term_depth_get_full_chain($tid)`.
- Recalculate all depths for a vocabulary from the "Update term depths" operation in the UI.
- Recalculate depths programmatically via the `taxonomy_term_depth.queue_service` queue manager.
- Backfill depth values for only the terms missing them with `queueBatchMissing()`.
- Keep depth correct automatically when editors add or move terms (insert/update hooks).
- Drive breadcrumb or indentation logic from a term's stored depth instead of recursion at render time.
- Style term pages differently per level using the depth value.
- Expose depth as a numeric column in a taxonomy overview View.
- Populate depth for an existing site after install via the automatic batch.
- Prepare the module for uninstall by nulling depth data with `drush tdpu`.
- Use the *Delete taxonomy term depths data* form before uninstalling in the UI.
- Query the raw `depth_level` column in `taxonomy_term_field_data` for reporting.
- Restrict a facet or block to terms of a particular hierarchy level.
- Integrate depth-aware logic into custom modules via the procedural API.
- Detect deeply nested terms (e.g. depth > N) for content-model cleanup.
