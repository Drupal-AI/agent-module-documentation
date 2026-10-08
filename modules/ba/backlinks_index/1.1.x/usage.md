<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Backlinks Index scans rendered node content for internal links and records, per node, which other nodes link to it, exposing the list on a "Backlinks" node tab.
---
When you unpublish or delete a node, other pages that linked to it silently break. Backlinks Index maintains a reverse index so editors can see what points at a page before changing it. On node save (`hook_node_postsave`, provided via the Hook Post Action module) it renders the node in the default theme, extracts `href="…"` links with a regex, discards external URLs, resolves each internal path to a node id — handling `node/{id}` paths, path aliases, language prefixes and Redirect module source paths — and writes rows into a custom `backlinks` table (`source`, `backlink`, `langcode`, `timestamp`). A `backlinks` base field flags nodes that have inbound links; the node edit form warns editors when an unpublished node still has backlinks pointing to it.

Two permissions guard the module: **`administer backlinks_index`** for the settings form at `/admin/config/content/backlinks` (choose which node bundles are scanned, plus Reindex/Purge actions) and **`access backlinks_index`** for the per-node backlinks tab (`/node/{node}/backlinks`). Bulk operations run through Batch API — a site-wide reindex (`BacklinksScanBatch`) and a purge that truncates the table and resets the node flags. Two Drush commands are provided: `backlinks_index:reindex` (alias `b_i:reindex`) and `backlinks_index:purge` (alias `b_i:purge`). All database access uses parameterized query-builder calls; there is no anonymous or mutating public endpoint.
---
- See every internal page that links to the current node.
- Warn editors before unpublishing a node that still has inbound links.
- Choose which node bundles are scanned for backlinks.
- Reindex all backlinks site-wide from the settings form.
- Purge the entire backlinks index and reset node flags.
- Reindex from the CLI with `drush backlinks_index:reindex`.
- Purge from the CLI with `drush backlinks_index:purge`.
- Grant editors read-only access to backlinks via `access backlinks_index`.
- Restrict backlink configuration to admins via `administer backlinks_index`.
- Resolve alias-based internal links back to their node ids.
- Follow Redirect module source paths when resolving links.
- Track inbound links per translation (langcode-aware).
- Count how many backlinks and how many linking nodes exist.
- Identify orphaned pages with no inbound internal links.
- Audit internal linking structure for SEO.
- Detect which pages would 404 if a node is deleted.
- View the occurrence count when one page links multiple times.
- Open a linking node's edit form directly from the backlinks table.
- Rebuild the index after a bulk content import.
- Keep the index current automatically on every node save.
- Exclude self-links from the index automatically.
