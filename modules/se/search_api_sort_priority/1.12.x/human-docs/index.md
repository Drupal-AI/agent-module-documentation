# Search API Sort Priority — manual setup guide

**Search API Sort Priority** (`search_api_sort_priority`) lets you give your
search results an *editorial* ranking. Out of the box, Search API sorts by
relevance; this module adds a set of index **processors** that quietly attach a
hidden "weight" number to each indexed item, so you can decide, for example, that
News should rank above Pages, that PDFs should come before spreadsheets, or that
the most-viewed articles should surface first — and then sort on that weight in
your search view.

Each processor calculates the weight from a different property of the item, and
you set the priorities by dragging rows into order on a simple weight table. The
module ships six processors:

- **Content type** (`contentbundle`) — priority per node content type.
- **Media bundle** (`mediabundle`) — priority per media type (Video before Image,
  say).
- **Paragraph bundle** (`paragraphbundle`) — priority per paragraph type.
- **File MIME type** (`filemime`) — priority per file type.
- **Role** (`role`) — priority based on the highest-weighted role of the item's
  author (content by Admins outranks content by Editors).
- **Statistics** (`statistics`) — priority based on a node's view count, using
  core's Statistics module.

There is **no settings page, no permissions, and no Drush commands** — all
configuration happens on your Search API index's **Processors** tab, which is why
the "configuration" page here explains how to work within Search API's UI rather
than a form of the module's own.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (for Solr sites) the Solr submodule.
2. [Configuration](configuration/index.md) — enable a processor on your index,
   set the priority weights, re-index, and add the weight field as a sort.

## Where it lives in the admin menu

Everything is configured on your existing Search API index, under **Configuration
→ Search and metadata → Search API → *(your index)* → Processors**
(`admin/config/search/search-api/index/<id>/processors`). The sort itself is then
added in the Search API **view** that displays your results.
