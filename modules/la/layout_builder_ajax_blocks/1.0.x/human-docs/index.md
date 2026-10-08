# Layout Builder Ajax Blocks — manual setup guide

**Layout Builder Ajax Blocks** (`layout_builder_ajax_blocks`) lets blocks placed
in a **Layout Builder** layout load with **Ajax** instead of blocking the initial
page render. When a block is marked for Ajax loading, the module renders a
lightweight placeholder in the initial response, then JavaScript fetches the fully
rendered block and swaps it into place. For heavy or slow blocks — a complex View,
an expensive computed block — this can improve the perceived performance of the
page, since the main content arrives without waiting on them.

There is nothing to configure globally: the behaviour is opt‑in **per block**,
switched on with a single checkbox while you edit the layout. That keeps it
precise — you Ajax‑load only the blocks that actually benefit, and leave
everything else rendering normally.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no settings form — you configure Ajax loading per block inside the
Layout Builder UI. See "How to use it".

## Where it lives in the admin menu

Layout Builder Ajax Blocks adds no admin settings page. You use it entirely inside
**Layout Builder**, when editing a layout for a content type's display or an
individual entity — see [Layout Builder](https://www.drupal.org/docs/8/core/modules/layout-builder).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Edit a layout in **Layout Builder** (for example, **Structure → Content types →
   *(type)* → Manage display**, with Layout Builder enabled, or the per‑entity
   layout).
3. Add or configure a block in the layout. In the block's configuration form,
   tick **"Enable Ajax for this block."** and save the block.
4. **Save the layout.**
5. Visit the page and confirm the block loads via Ajax — it appears momentarily as
   a placeholder and is then replaced by the fully rendered block.
