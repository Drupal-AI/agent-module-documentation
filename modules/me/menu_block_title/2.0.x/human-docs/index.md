# Menu Block Title — manual setup guide

**Menu Block Title** (`menu_block_title`) adds a single, handy checkbox to menu
blocks: **"Block title as menu link parent."** Tick it and the block's title
turns into a link pointing at the parent of the menu item the visitor is
currently on. It's exactly what you want for a sidebar navigation block — the
heading becomes a contextual "you are here" link back to the current section's
parent page.

The classic use is a second-level sidebar menu. Configure a menu block to start
at level 2, turn on this checkbox, and the block's title will always link to the
top-level section the visitor is browsing — think documentation chapters,
product categories, or an intranet's department landing pages. As the visitor
moves around the menu, the title follows the active trail automatically.

There's no settings page, permission, or code to write. The feature is a
per-block checkbox stored as a small piece of block configuration, so you can
turn it on for some menu blocks and leave others alone, and it travels with your
exported block config between environments. Under the hood it relabels the title
at render time and adds the correct cache context so the result stays
cache-correct.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You use the feature from **Structure → Block
layout** (`/admin/structure/block`) when you edit an individual menu block.

## How to use it

The checkbox only appears on **menu-based blocks** — core system menu blocks
(such as *Main navigation*) and blocks from the contrib *Menu Block* module. It
does nothing on other kinds of block, and only takes effect when the block's
title is set to display.

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** and edit (or place) a menu block —
   `/admin/structure/block/manage/<block_id>`.
3. Make sure **Display title** is checked — the title has to be visible for the
   link to appear.
4. For the most useful result, set the block to start at **menu level 2** so the
   title links up to the current top-level section.
5. Tick **"Block title as menu link parent"** near the bottom of the form.
6. Click **Save block**.

Now the block's title is a link to the parent of whichever menu item is in the
active trail, and it updates as the visitor navigates. You can enable it on
several menu blocks at once, each showing its own branch's parent as the title.
