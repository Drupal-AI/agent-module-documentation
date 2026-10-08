<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Referenced Entities Revision (referenced_entities_revision) — agent index

**Adds a node "Revision List" tab that lists revisions of the node plus every node it references (recursively).**

- **Version:** 1.0.x
- **Core:** ^9 || ^10
- **Routes:** `/node/{node}/revisionList` and `/referenced_entities_revision/revisionList` (`RevisionsListController::listRender`), both `_admin_route: TRUE`.
- **Permission:** core `view all revisions` (module defines none of its own).
- **Tab:** `referenced_entities_revision.links.task.yml` adds a local task on node pages.
- **Behaviour:** walks `entity_reference` / `entity_reference_revisions` fields with `target_type: node`, recurses, and renders a combined revision table; revert links use core `node.revision_revert_confirm`.

**Security:** read-only admin-route report gated by the core `view all revisions` permission; no mutating endpoint of its own (revert goes through core's access-checked confirm form). No anonymous access.
