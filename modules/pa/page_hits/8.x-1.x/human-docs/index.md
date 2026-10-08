# Page Hits — manual setup guide

**Page Hits** (`page_hits`) is a small, self‑hosted view counter. It tracks how
many times pages and content are viewed and surfaces those counts through a block,
so you can show a "views" figure or report on which pages are most popular —
without wiring up a third‑party analytics service. All counting happens locally on
your own site.

Setting it up is a three‑step job: enable the module, place the **Page Hits**
block where you want the count to appear, and then open the module's settings page
to fine‑tune how tracking and display behave. Because the counter records data per
hit, it is worth being mindful of privacy — avoid keeping more per‑visitor detail
than you actually need.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and place the block.
2. [Configuration](configuration/index.md) — where the settings page lives and
   what it controls.

## Where it lives in the admin menu

The block is placed from **Structure → Block layout**
(`/admin/structure/block`). The module's own settings form sits under
**Configuration → System → Page Hits** (config route `page_hits.settings`).
