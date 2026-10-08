# History Memory Calculator — manual setup guide

**History Memory Calculator** (`history_memory_calculator`) adds an interactive
calculator to your site as a **block** you can drop into any region. Beyond basic
arithmetic — add, subtract, multiply, divide, and percentage, with decimal
support — it offers two conveniences most on‑page calculators lack: a **memory**
function to store and recall a value, and a **timestamped history** of past
calculations that visitors can page through.

The whole thing runs client‑side in the browser: there's no server route, no
saved data, no permission, and no external calls — the calculator is pure
JavaScript attached to the block. That makes it a simple, self‑contained widget
for educational sites, e‑commerce price helpers, or finance/savings tools.

It depends only on core's **Block** module and runs on Drupal 8, 9, and 10. The
block carries a single "layout" option in its own placement settings; otherwise
there's nothing to configure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no separate configuration page** for this module — its only setting (a
layout selector) lives in the block's own placement form, described in "How to
use it" below.

## Where it lives in the admin menu

History Memory Calculator adds no configuration page of its own. You place its
block from **Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the region where you want the calculator (a sidebar or footer works well),
   click **Place block** and choose **History Memory Calculator Block**.
3. In the block's placement form, pick the **layout** option and set any standard
   block visibility conditions (which pages, roles, etc.).
4. Save. The calculator now appears in that region, ready to use — memory,
   history, and pagination all work immediately in the visitor's browser.
