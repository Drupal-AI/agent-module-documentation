# Flipcard Layout — manual setup guide

**Flipcard Layout** (`lb_flipcard`) adds a flip-card layout plugin to Drupal's
Layout Builder. A section using this layout renders as a card with a **front and
back face** that flips over on hover or click — a compact, interactive way to
present teaser or feature content, where a short prompt on the front reveals more
detail on the back.

The effect is **pure CSS**, so there is no JavaScript library to install and no
external dependency to pull in. You place blocks into the layout's regions the
same way you would with any core layout; the front/back flip is handled entirely
by the module's stylesheet. It supports a wide range of Drupal versions
(8.8 through 11).

This module is **minimally maintained** (maintenance fixes only), which is worth
noting if you are choosing it for a long-lived site — but the CSS-only approach
keeps it simple and low-risk.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no configuration page** of its own. You choose and fill the
flip-card layout from within Layout Builder, described below.

## Where it lives in the admin menu

There is no dedicated settings page (`configure` is null). The flip-card layout
becomes available as a layout choice inside **Layout Builder**.

## How to use it

1. Enable the module.
2. Edit the layout of any Layout Builder–enabled entity or view display.
3. When you **add a section**, choose the flip-card layout from the list of
   available layouts.
4. Place a block into the **front** region and a block into the **back** region.
5. Save. On the rendered page, the card flips to reveal the back face on hover or
   click.
