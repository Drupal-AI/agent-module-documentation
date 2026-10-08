# Search API Sorts — manual setup guide

**Search API Sorts** (`search_api_sorts`) lets you add a block of clickable **sort
options** to a Search API search — the familiar "Sort by: Price / Date / Relevance"
controls you see on catalogue and search‑results pages. Visitors click an option to
reorder the results, and click it again to flip between ascending and descending. It
works with any single‑value indexed field on your Search API index.

You configure sorting **per display** — a "display" is any place your Search API index
is shown, such as a Views page or block backed by the index, or a Search API Pages
page. On a "Manage sort fields" screen for each display you tick the fields that should
be sortable, give each one a label and a weight, and optionally mark one as the default
sort. Search API Sorts then provides a block that renders those options as sort links,
and applies the chosen sort to the query behind the scenes. Sharable URLs work too —
sorting is driven by `?sort=<field>&order=<asc|desc>` query parameters.

The module depends on the **Search API** module and adds no permissions of its own —
managing sorts uses Search API's own *Administer Search API* permission. One thing worth
knowing up front: search results (and therefore the sort block) can't be cached
reliably, so the block is set to never cache and is best delivered with core's
**BigPipe** module so it doesn't hold up the rest of the page.

The **8.x-1.3** release is a maintenance update: it adds PHP 8.4 compatibility, restores
the drag‑and‑drop weight handles on the Manage sort fields form, and fixes a dependency
and the test suite. Nothing about how you configure or use the module changed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — enable sort fields per display, place the
   sort block, and set a default sort.

## Where it lives in the admin menu

Sorting is managed under each Search API index. Go to **Configuration → Search and
metadata → Search API** (`/admin/config/search/search-api`), open your index, and use
the **Sorts** tab (`/admin/config/search/search-api/index/{index}/sorts`). From there
you pick a display and open its "Manage sort fields" form. The sort **block** is placed
from **Structure → Block Layout** like any other block.

## How to use it

1. Enable the module (and BigPipe, if it isn't already on).
2. Open your index's **Sorts** tab and enable the fields you want to be sortable for a
   display.
3. Place the "Sort by" block for that display in a region.

See [Configuration](configuration/index.md) for the details.
