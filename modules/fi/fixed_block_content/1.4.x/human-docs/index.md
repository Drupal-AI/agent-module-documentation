# Fixed Block Content — manual setup guide

**Fixed Block Content** (`fixed_block_content`) lets you place a custom (content)
block by a stable configuration reference instead of by its content id. This
solves a familiar frustration: when the underlying custom block is absent —
deleted by an editor, or not yet staged to a fresh environment — an ordinary block
placement turns into the dreaded "This block is broken or missing." A fixed block
placement never breaks that way.

The module adds a **Fixed block content** configuration entity that acts as a
permanent wrapper around a custom block. Each fixed block records which custom
block *type* (bundle) it targets and, optionally, a serialized snapshot of the
block's *default content* that can recreate it. For each fixed block, the module
exposes a placeable block (in the admin "Fixed custom" category) that you drop into
Block layout like any other. When it renders, it loads the linked custom block —
and if that content block has disappeared, it quietly creates an empty one on
demand — then displays it in the view mode you choose.

Because the wrapper is *configuration*, it exports and deploys with the rest of
your site, which solves two problems at once: **staging** (custom blocks created
locally aren't lost between environments) and **permanence** (a placement survives
deletion of its content block). You can snapshot the current block into config
before a release and restore it afterward, auto‑snapshot on every save, and mark a
block as *protected* so it can't be edited or deleted independently of its wrapper.

This guide is written for a **human** using the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create a fixed block, place it, and
   manage its default content for staging.

## Where it lives in the admin menu

Fixed blocks are managed at **Structure → Block content → Fixed block content**
(`/admin/structure/block-content/fixed-block-content`), gated by the core
**Administer block types** permission. The blocks they produce are placed from
**Structure → Block layout** under the **Fixed custom** category.

## How to use it

Create a fixed block, choosing the custom block type it wraps; place its block in
a region; then edit the linked custom block content as usual — the placement stays
valid even if that content is later removed. To carry a block's content between
environments, use the export/import operations to store a default‑content snapshot
in config. See [Configuration](configuration/index.md) for the details.
