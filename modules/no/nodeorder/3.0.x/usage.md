<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Order lets editors manually drag-and-drop the order of nodes within each taxonomy term, instead of relying on the default sticky/created-date ordering.

---

By default Drupal lists a term's nodes by stickiness then creation date. Node Order lets you mark a **vocabulary as "orderable"** (a checkbox added to the vocabulary edit form, mirrored in `nodeorder.settings` under the `vocabularies` map), after which each term in that vocabulary gets an **Order** tab/operation (`/taxonomy/term/{tid}/order`) with a tabledrag interface for setting per-node weights. The weight is stored in a **`weight` column the module adds to core's `taxonomy_index` table** at install (dropped on uninstall) — deliberately extending a core table to keep the join cheap. Node insert/update/delete hooks maintain each node's position within its terms, keeping the ordered list balanced around zero. The admin settings form at `/admin/config/content/nodeorder` (`nodeorder.admin`) controls which vocabularies are orderable, how ordering links are displayed, whether nodeorder overrides the default taxonomy term page, and the page size (`entity_list_limit`). Two permissions gate use: *order nodes within categories* (do the ordering) and *administer nodeorder* (reach the settings form). A Views integration adds a **"Nodeorder"** sort/field on `taxonomy_index.weight` so you can respect the manual order in your own Views. Business logic lives in the `nodeorder.manager` service (`NodeOrderManager`).

---

- Manually order news articles within a "Category" term so featured stories appear first.
- Drag-and-drop the sequence of products shown under a taxonomy term.
- Curate a hand-picked order for staff-profile nodes within a department term.
- Make a "Featured" vocabulary orderable and control the exact order of promoted nodes.
- Order FAQ nodes within a topic term rather than by date.
- Give editors an Order tab on each term to reorder its nodes without code.
- Keep the same node in two terms with a different manual position in each.
- Respect manual node order in a custom View via the "Nodeorder" sort on taxonomy_index.weight.
- Override the default taxonomy term listing page with a nodeorder-ordered one.
- Show ordering links only for the currently active category on a node.
- Set how many nodes appear per page on the ordering screen (entity_list_limit).
- Restrict who can reorder nodes with the 'order nodes within categories' permission.
- Restrict who can change nodeorder settings with the 'administer nodeorder' permission.
- Reorder recipe nodes within a cuisine term for a food site.
- Manually sequence portfolio items within a project-type term.
- Provide a stable, editor-defined order for landing-page teasers pulled from a term.
- Turn a vocabulary orderable in bulk (a batch reweights all existing term/node pairs).
- Turn a vocabulary non-orderable again (a batch resets the weights) when no longer needed.
- Add a "tab" link from taxonomy admin pages straight to a term's ordering screen.
- Use the nodeorder.manager service programmatically to push a node to the top of a term list.
- Query the manual weight per node/term directly from the taxonomy_index table.
- Order event nodes within a "Series" term for a predictable programme sequence.
- Let content teams reorder nodes with drag handles and a single Save.
- Combine orderable terms with Views to build hand-ordered content blocks.
