# Layout Builder Section-Block Clone — manual setup guide

**Layout Builder Section-Block Clone** (`layout_builder_section_block_duplicate`)
adds the one verb core **Layout Builder** is missing: *duplicate*. Layout Builder's
controls are add, configure, move and remove — but a real page is often built by
making one component and copying it several times, changing the text each time. A
page with six feature cards is far quicker to build by cloning than by configuring
six blocks from scratch, and cloning also keeps the repeated components consistent,
so the sixth card doesn't quietly differ from the first in some style option nobody
notices.

This module adds clone actions in two places: a **Clone section** link alongside a
section's existing controls, which duplicates an entire section with all its blocks
and configuration; and a **Clone block** action in a block's contextual links, which
copies an individual block. Duplicates preserve the original's settings,
configuration and visibility rules, and appear immediately after the original. It
works out of the box with no configuration, depends on core Layout Builder, and
targets Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it works out of the box. You
use it entirely from the Layout Builder editing interface, described below.

## How to use it

This module extends core Layout Builder, so you use it wherever Layout Builder is
active.

**Clone a section:**

1. Enter Layout Builder mode on any page.
2. Hover over a section to reveal its administrative links.
3. Click **Clone section** (it appears with a clone icon). The section is duplicated
   immediately below the original, with all its blocks and configuration.
4. Save your layout changes.

**Clone a block:**

1. In Layout Builder mode, hover over any block.
2. Open the block's contextual links button and choose **Clone block**.
3. The block is cloned and appears after the original.
4. Save your layout changes.
