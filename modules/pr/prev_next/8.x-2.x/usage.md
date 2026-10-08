<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prev/Next precomputes each node's previous and next neighbour into a lookup table and serves them through a block and a service API, so navigation links stay fast no matter how large the archive grows.

---

Computing "previous article / next article" live is a whole-table ordered query run on every node page, and it gets slower as content accumulates. Prev/Next avoids that by maintaining a dedicated `prev_next_node` table (columns `nid`, `prev_nid`, `next_nid`, `changed`) that is updated on node insert, update and delete via entity hooks, then read with a single indexed `WHERE nid = :nid` lookup. Neighbour order is configurable per content type — by node ID, post date, updated date, or title — and can be limited to the same content type or to a chosen set of included types. A context-aware "Prev/Next" block renders the links on any node page, and the `prev_next.helper` service (`getPrevId`, `getNextId`, `getPrevnextId`) exposes the same lookup to custom code. Only published nodes (`status = 1`) are indexed as neighbours, so unpublished content never becomes a prev/next target. Existing content is indexed backwards over successive cron runs (batch size configurable, default 200) or immediately by bulk-saving nodes; changing any per-type indexing option is meant to trigger a full re-index.

---

- Add "previous / next node" links below articles without a live ordered query.
- Keep neighbour lookup at constant cost as the content archive grows.
- Place the context-aware Prev/Next block on node pages via Block layout.
- Serve prev/next links from a precomputed lookup table instead of computing on the fly.
- Order neighbours by post date for a chronological blog or news archive.
- Order neighbours by node ID, updated date, or title per content type.
- Restrict prev/next navigation to a single content type (same-type only).
- Restrict indexing to a chosen set of content types (e.g. video and image, not pages).
- Navigate an image gallery with next/previous thumbnails under each image.
- Build series or chapter navigation across a set of nodes.
- Customise the previous and next link text per block instance.
- Show only the previous link, only the next link, or both.
- Fetch a node's next id in custom code with the `prev_next.helper` service.
- Fetch a node's previous id programmatically for a custom template or controller.
- Reindex all existing nodes after installing the module on a populated site.
- Tune the per-cron batch size down on shared or memory-constrained hosting.
- Bulk-save existing nodes to index them immediately instead of waiting for cron.
- Re-index the whole site from the settings page after changing indexing criteria.
- Avoid bringing a large site's database to its knees with per-page neighbour queries.
- Provide gallery/portfolio browsing where visitors step through items one at a time.
- Keep neighbour relationships correct when nodes are added, edited, or deleted.
