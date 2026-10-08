# Commerce Quick Node Clone — manual setup guide

**Commerce Quick Node Clone** (`commerce_quick_node_clone`) lets you **clone a
Commerce product** — with all of its fields and paragraphs — in one click, so
building a catalogue of similar products is far faster than recreating each one
from scratch. It is an extension of the general
[Quick Node Clone](https://www.drupal.org/project/quick_node_clone) module, adding
support for the Commerce Product content type. It supports Drupal 10, 11, and 12.

The problem it solves is repetitive data entry: when many products share most of
their fields, cloning an existing one and tweaking the differences is much quicker
than starting fresh. Once the module is enabled, a **Clone** option appears on each
product, and using it creates a duplicate with the original's fields copied over.
It depends on core **Node**, **Commerce**, and Commerce **Product**, and provides
its own permission.

The main thing to think about is that cloning copies **everything**: confirm it
doesn't duplicate anything that should be unique — a SKU, a stock count — without
you adjusting it afterwards, and restrict who can clone to the people who should be
creating products in the first place.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Commerce.

This module has no dedicated settings page of its own; clone behaviour and field
exclusions are governed by the parent Quick Node Clone module, and access is
governed by permissions — described below.

## Where it lives in the admin menu

Commerce Quick Node Clone adds no central admin page. After installation, a
**Clone** action appears on each Commerce product. Which fields are excluded from
cloning is controlled by the parent [Quick Node
Clone](https://www.drupal.org/project/quick_node_clone) module's settings, and who
may clone is controlled by permissions at **People → Permissions**.

## How to use it

1. Enable the module (see Installation).
2. Grant the clone permission to the appropriate roles at **People → Permissions**
   — restrict it to users who should be creating products.
3. Open a Commerce product and choose the **Clone** option; a duplicate is created
   with the original's fields and paragraphs copied.
4. Adjust anything that must be unique on the copy — for example the SKU or stock
   figures — before saving/publishing.
