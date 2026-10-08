# Scroll blocks — manual setup guide

**Scroll blocks** (`scroll_blocks`) makes a block appear or disappear based on how
far the visitor has scrolled down the page. You know the pattern: a call-to-action
that slides up from the bottom once you have scrolled past the hero, a floating
contact bar that arrives part-way through a long article, a back-to-top button that
only exists once you are far enough down, or a promo banner held back until the
reader shows some engagement. Each of those is normally a bespoke scroll listener
written into the theme; this module turns the behaviour into a **property of the
block** instead.

When you enable the pop-up behaviour on a block, the block starts hidden and slides
into view at the scroll distance you choose — and slides back down at another
distance you choose. It also provides a **close button** that mutes the block until
the page is reloaded. You control the trigger distances and the window-width range
per block placement, right on the block's configuration form. The behaviour only
runs when the block is actually on the page, so you use core's normal block
visibility settings to decide which pages it appears on.

The module is JavaScript and configuration only — it has **no PHP classes**. It
depends on core's **Block** module and supports Drupal 8, 9, 10 and 11. Note that
this 2.0.x release is an **alpha**, so treat it accordingly on production sites.

Two things are worth deciding before you use it. First, **reduced motion**:
scroll-driven appearance is motion, and visitors who have asked for reduced motion
should not get elements sliding into view — check what the shipped CSS does about
`prefers-reduced-motion` and adjust in your theme if needed. Second, **mobile
overlap**: a block that appears over content can cover it on small screens, so test
the layout at mobile widths with the block visible, not just at desktop.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.
2. [Configuration](configuration/index.md) — the per-block pop-up options (reveal
   and hide scroll distances, min/max window width).

## Where it lives in the admin menu

Scroll blocks has no settings page of its own. It adds its options to each block's
configuration form under **Structure → Block layout**
(`/admin/structure/block`) — see [Configuration](configuration/index.md).
