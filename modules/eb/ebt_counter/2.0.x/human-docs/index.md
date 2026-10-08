# Extra Block Types (EBT): Counter — manual setup guide

**Extra Block Types (EBT): Counter** (`ebt_counter`) adds a block type for
**animated number counters** — the "count up from zero" statistics you often see
on landing pages ("500+ clients", "1M downloads"). Each counter pairs a number
with WYSIWYG-editable text, and you can arrange them in 2, 3, or 4 columns.

Under the hood it uses the **countUp.js** library and exposes all of its options,
so you control how the numbers animate. It is part of the **Extra Block Types
(EBT)** family, whose components are provided as **block types** placeable in any
region and in **Layout Builder** in a few clicks. The shared design widget comes
from the **EBT Core** (`ebt_core`) base module, and this module also requires the
**Paragraphs** module. It runs on Drupal 10.1+, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its EBT Core and Paragraphs dependencies).

## Configuration

There is **no separate settings page** for this module. Like all EBT block types,
the Counter is configured **per block instance** when you place it: you add each
counter (its target number and WYSIWYG text), choose 2/3/4 columns, set the
countUp.js animation options, and adjust the shared **Design** options (CSS box
margins/paddings/borders; background colour, image — including parallax and cover
— or YouTube video; edge-to-edge vs. container width) from the **EBT Core**
widget. See the [EBT Core project page](https://www.drupal.org/project/ebt_core)
for more.

## How to use it

1. Edit a page with **Layout Builder**, or go to **Structure → Block layout**.
2. Click **Add block** and choose the **Counter** block type.
3. Add each counter (number plus text), pick the column count and the countUp.js
   options, and adjust the shared Design options.
4. Save. The numbers animate upward when the block scrolls into view.
