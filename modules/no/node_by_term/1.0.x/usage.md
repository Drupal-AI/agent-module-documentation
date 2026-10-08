<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node by Term provides an admin listing that filters site nodes by vocabulary, taxonomy term and content type.
---
The module adds a filter form and a results table at `/node-list` (route `node_by_term.nodelist`, the configure route) and a standalone filter form at `/node-by-term-form` (route `node_by_term.form`). Selecting a vocabulary loads its terms via AJAX; submitting redirects to the node list with `vocab`, `t_id` and `cont_type` query parameters, which the controller uses to build a paged (2 per page) `taxonomy_index`/`node_field_data` query. The results table shows title, content type, published status, created/changed dates and Edit/View operation links. Node objects are loaded through the entity storage, so field values are rendered through Drupal's normal escaping.

Both routes are gated by `_permission: 'administer node by term'`. That permission string is not actually declared anywhere (the `.permissions.yml` is empty and the D7-style `hook_permission()` in the `.module` declares a different, non-functional string), so in practice only user 1 passes the gate; the extra `_access: 'TRUE'` on the node list route is AND-combined with the permission and does not loosen it. The listing does include unpublished nodes (status column), but only for whoever passes that gate. Setup is simply enabling the module and visiting `/node-list`; there is no settings form.
---
- Filter published and unpublished nodes by a chosen vocabulary
- Narrow a node list to a single taxonomy term
- Combine a term filter with a content-type filter
- List all nodes of one content type
- Browse nodes with pager-based pagination (2 rows per page)
- Reach the tool from its configure link on the Extend/module page
- Open the standalone filter form at `/node-by-term-form`
- Pick a vocabulary and load its terms via AJAX before filtering
- See each node's published/unpublished status at a glance
- Read created and last-modified timestamps per node
- Jump to a node's edit form from the Operations column
- Jump to a node's canonical view from the Operations column
- Reset the filter form to return to the full node list
- Use query parameters (`vocab`, `t_id`, `cont_type`) to deep-link a filtered list
- Audit which nodes are tagged with a given term
- Find untagged content by filtering only on content type
- Provide editors a quick term-based content finder
- Verify taxonomy tagging coverage across a vocabulary
- Locate stale content by scanning changed dates
- Confirm publication state of term-tagged content in one view
