# Back to top with progress scrollbar — manual setup guide

**Back to top with progress scrollbar** (`back_to_top_with_pi`) gives you a "back to
top" control that also shows a **scroll‑progress indicator** — a bar that fills in as
the visitor scrolls down, showing how far through the page they are, with a one‑click
jump back to the top. It's delivered as a **block**, so you place it wherever you want
the control to appear.

It depends on core's **Block** module and runs on Drupal 9, 10 and 11. It's a purely
front‑end convenience — it has no effect on content or access, so there's nothing to
configure beyond deciding where the block sits.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

There is no settings form — you use it entirely through **Structure → Block layout**
(`/admin/structure/block`).

## How to use it

After enabling the module, go to **Structure → Block layout**, find the module's
back‑to‑top block, and place it in a region. It typically works best in a region that
appears across the site (a header or a full‑width region) so the scroll‑progress bar and
the back‑to‑top button are available on long pages everywhere. Use the block's normal
visibility settings if you only want it on certain pages. Once placed, the progress
indicator tracks the visitor's scroll position and the button returns them to the top in
one click.
