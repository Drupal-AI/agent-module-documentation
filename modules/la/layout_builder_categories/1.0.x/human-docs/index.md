# Layout Builder Categories — manual setup guide

**Layout Builder Categories** (`layout_builder_categories`) is a small
quality‑of‑life tweak for core's Layout Builder. When you click **Add block** in
Layout Builder, the off‑canvas panel lists every available block grouped by
category — and on a real site that list gets long. This module **collapses those
category groups**, so instead of scrolling one enormous flat list you get tidy,
collapsible headings you can expand only when you need them.

That is the whole feature. It is purely a UI/editing‑experience improvement: it
changes how the add‑block list is displayed and has no effect on content, on which
blocks are available, or on access. There is nothing to configure — enable it and
the block picker is collapsed from then on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no configuration page** and no settings — it works the moment it
is enabled.

## Where it lives in the admin menu

It adds no admin page. The change appears inside the Layout Builder **Add block**
off‑canvas panel, which you open whenever you build a layout (for example
**Structure → Content types → *(type)* → Manage display → Layout → Add block**).

## How to use it

Just enable it. The next time you open **Add block** in Layout Builder, the block
category groups will be collapsed. Click a category heading to expand it and see
the blocks inside.
