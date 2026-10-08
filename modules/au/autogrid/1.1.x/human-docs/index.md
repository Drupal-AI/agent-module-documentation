# Content Autogrid — manual setup guide

**Content Autogrid** (`autogrid`) gives editors a spreadsheet‑style table of every
entity of a chosen type or bundle, without you having to build a View. Pick which
entity types should have a grid, and the module generates a sortable, paged table
whose columns are built automatically from that bundle's field definitions — each
cell rendered with the field's own display formatter — plus an ID column and
per‑row operation links (edit, delete).

You choose which entity types get a grid on a single settings form. From then on,
the module attaches a **grid** tab to each enabled type's management pages (for a
node type, for example, at `…/manage/<type>/grid`). Editors open that tab to scan
all the content of that type at a glance — useful for reviewing field values across
many entities before bulk‑editing them elsewhere. It works with bundled entity
types such as content types, taxonomy vocabularies, or media types.

The module is display‑only and fully permission‑gated: it reads existing entities
and renders them, and exposes no anonymous or content‑changing endpoints. Two
permissions govern it — one to configure which types have grids, and one to view
the grids — so you decide exactly who sees what.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which entity types get a grid
   and grant the viewing permission.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Content Autogrid**
(`/admin/config/content/autogrid/settings`). Each grid itself appears as a **grid**
tab on the relevant entity type's management pages.
