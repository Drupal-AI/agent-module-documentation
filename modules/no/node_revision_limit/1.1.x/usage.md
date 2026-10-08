<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Revision Limit prunes old node revisions on update so each node keeps only a set number of revisions.

---

On node update the module's `NodeRevisionLimitManager` service counts a node's revisions and deletes the oldest ones beyond the configured limit. A settings form at `/admin/config/content/node_revision_limit` (`administer site configuration`) lets you set a global limit and, optionally, per-content-type overrides. Limits are stored in `node_revision_limit.settings` with a schema.

The pruning respects Drupal's revision system (it deletes surplus historical revisions, keeping the current/default one), so it bounds unbounded revision growth without manual maintenance. There are no web-facing routes beyond the admin form and no custom permissions; behaviour is entirely automatic once configured.

---
- Cap how many revisions each node retains.
- Automatically delete the oldest revisions on every node save.
- Set a different revision limit per content type.
- Keep the node revision table from growing without bound.
- Reduce database size on sites with frequent edits.
- Retain a useful edit history without keeping everything forever.
- Avoid manual revision cleanup routines.
- Apply a strict limit to high-churn content types.
- Allow unlimited revisions for content types you exclude.
- Improve backup and query performance by trimming revisions.
- Enforce a retention policy for editorial history.
- Prune revisions transparently as part of normal editing.
- Combine with node_health reporting for revision hygiene.
- Keep only the last N versions for compliance simplicity.
- Configure once and let it run automatically.
- Bound storage growth on long-lived editorial sites.
