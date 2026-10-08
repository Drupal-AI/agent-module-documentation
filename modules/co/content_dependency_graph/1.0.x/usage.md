<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Dependency Graph renders an interactive graph of how a node relates to other
content — the media, taxonomy terms, paragraphs and referenced entities it points to.

---

It adds an admin section at `/admin/content/dependency-graph` listing the 100 most recently
changed nodes (access-checked entity query), each linking to a per-node graph at
`/admin/content/dependency-graph/{node}`. The controller walks the node's fields to build a
relationship graph for display. Both routes are gated by the **"access content dependency
graph"** permission. It is a read-only reporting/visualization tool with no write operations.

Use it to understand editorial dependencies before deleting or unpublishing content, to audit
which media/terms a page relies on, or to explore how paragraphs and referenced entities knit
together. Grant the permission to editors who need to inspect content structure.

---

- Visualize a node's outgoing entity references as a graph.
- List recently changed nodes to pick one to inspect.
- See which media a node depends on.
- See which taxonomy terms a node references.
- Trace paragraph and referenced-entity relationships.
- Audit dependencies before deleting content.
- Check what breaks if a term or media item is removed.
- Grant editors the `access content dependency graph` permission.
- Explore content structure from the admin content area.
- Review published/unpublished status alongside dependencies.
- Inspect a page before archiving it.
- Find orphaned or heavily-referenced media.
- Support editors reviewing content relationships.
- Spot-check reference integrity after a migration.
- Open a node's graph directly by its node id URL.
- Limit graph access to trusted editorial roles.
- Review the 100 most recently edited nodes at a glance.
