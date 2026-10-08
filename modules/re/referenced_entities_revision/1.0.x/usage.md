<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Referenced Entities Revision adds a "Revision List" tab to node edit pages that lists revisions of the node together with revisions of the nodes it references.

---

Content editors working with heavily cross-referenced nodes normally have to open each referenced node individually to review its revision history. This module walks the current node's `entity_reference` and `entity_reference_revisions` fields (recursively, node targets only) and renders a single combined table of every reachable node's revisions, each row linking to the revision view and to core's revision-revert confirm form.

The controller (`src/Controller/RevisionsListController.php`) collects referenced node ids by recursing through reference fields, loads each node's revision ids, and builds a sorted table. Both routes (`/node/{node}/revisionList` and `/referenced_entities_revision/revisionList`) are `_admin_route` and gated by the core `view all revisions` permission; revert links target core's own access-checked `node.revision_revert_confirm` route. There is no configuration; enable the module and open the tab on a node.
---
- Install the module and enable it with drush or the Extend UI.
- Grant the core `view all revisions` permission to editors who need the tab.
- Open `/node/{nid}/revisionList` to see combined revisions for a node and its references.
- Review the revision history of a node and all nodes it references in one table.
- See the title, item type, creator, node id and revision id of each revision.
- See the changed timestamp for every listed revision, sorted newest first.
- Click a row's View link to open a specific node revision.
- Click a row's Revert link to open core's revision-revert confirm form.
- Audit which user created each revision across a reference tree.
- Trace revisions across paragraph-style `entity_reference_revisions` node references.
- Trace revisions across ordinary `entity_reference` fields that target nodes.
- Use the tab on landing-page style nodes that reference many child nodes.
- Verify that referenced content changed at the same time as its parent.
- Reach the list via the local task tab added to node pages.
- Restrict access to the tab by controlling the `view all revisions` permission.
- Confirm the module has no settings form to configure.
