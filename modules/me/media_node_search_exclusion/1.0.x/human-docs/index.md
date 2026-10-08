# Media Node Search Exclusion — manual setup guide

**Media Node Search Exclusion** (`media_node_search_exclusion`) keeps your Search
API index consistent by propagating a media item's "exclude from search" flag up
to the nodes that reference it. Out of the box, marking a media entity as excluded
from search does *not* hide the pages built around it — so content can stay
searchable even though a media item it depends on was meant to be hidden. This
module closes that gap.

When a media item is flagged as excluded, the module works out which referencing
nodes should also be excluded and updates their exclusion field accordingly. You
choose the rules: which boolean field marks media as excluded, which media bundles
participate, and whether a node is excluded when **any** referenced media is
excluded or only when **all** of them are. The work can run inline for small sites
or be deferred to a queue for content‑heavy sites with large reference sets.

The module reacts automatically to media and node saves, and it adds live status
indicators to the node and media edit forms so editors can see an item's current
exclusion state at a glance. It ships with a guided tour to introduce the workflow,
and integrates with the **Search API Exclude Entity** module, whose exclusion
field it reads and writes.

One privacy note worth knowing: the small JavaScript‑backed status endpoint that
powers the live indicators is gated only by the "access content" permission
(effectively broad, and anonymous on many sites). It is strictly read‑only — it
never changes anything — but it does return a media item's label, bundle, and
current exclusion state for requested media IDs, so low‑privilege users could read
those media labels. Keep that in mind if media labels are sensitive on your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   satisfy the Search API dependencies.
2. [Configuration](configuration/index.md) — choose the exclusion field, allowed
   bundles, inline vs. queue processing, and debug logging.

## Where it lives in the admin menu

Its settings form sits at **Configuration → Search and metadata → Media Node
Search Exclusion** (`/admin/config/search/media-node-search-exclusion`), and
requires the **Administer site configuration** permission.
