# Analog Digital Clock Block — manual setup guide

**Analog Digital Clock Block** (`adc_block`) gives you ready-made clock blocks you
can drop into any region of your site. It ships two kinds of clock — an **analog**
face drawn with SVG/CSS and a **digital** readout — and both are configurable, so
you can pick a style and a timezone and place as many as you like. The time is
rendered in the visitor's browser (client-side), so the clock ticks live without
reloading the page.

This is purely a presentation feature. It adds no content of its own and has no
special access rules — you configure a clock once, as an administrator, and every
visitor sees the same clock ticking. Its only dependency is Drupal's core **Block**
module, which handles placing the clock in a region.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. Everything happens where you place blocks:
**Structure → Block layout** (`/admin/structure/block`). A clock's appearance —
its style and timezone — is set on the block itself when you add or configure it
there.

## How to use it

1. Go to **Structure → Block layout**.
2. Next to the region where you want the clock (for example *Sidebar* or
   *Header*), click **Place block**.
3. Find the **Analog Digital Clock** block in the list and click **Place block**
   beside it.
4. In the block configuration dialog, choose the clock style (analog or digital)
   and the timezone you want to display, then set the usual block options
   (title, visibility conditions).
5. Click **Save block**. The clock now appears in that region and updates live
   in every visitor's browser.

Repeat to place additional clocks — for example a digital clock in the header and
an analog clock in the footer, each with its own timezone.
