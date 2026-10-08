# Layout Builder Animate On Scroll — manual setup guide

**Layout Builder Animate On Scroll** (`lb_aos`) adds per‑block scroll‑animation
settings to
[Layout Builder](https://www.drupal.org/docs/8/core/modules/layout-builder), so a
site builder can make a block fade or slide into view as the visitor scrolls —
without writing any JavaScript.

It works by joining two things: the **AOS** (Animate On Scroll) library, which does
the actual animation, and Layout Builder, which decides what is on the page. The
module hooks into Layout Builder's block build so each block gains a set of
animation settings, and the resulting AOS data attributes are attached to the
block's markup for the library to act on. The animation settings are stored in the
layout configuration, so they travel with the layout — through a config export for
default layouts, and with the entity for per‑entity overrides.

Two caveats apply to any scroll‑animation approach, and both are worth checking
before shipping motion to a public site:

- **Reduced motion.** Honoring the visitor's `prefers-reduced-motion` setting is the
  AOS library's responsibility rather than this module's — verify it is respected
  before you rely on it.
- **Content that only appears on scroll is absent until then.** Don't animate
  anything a visitor needs immediately, and check how the page behaves with
  JavaScript disabled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (note the unusual
   package name) and enable it alongside AOS and Layout Builder.

There is **no settings form** for this module. Animation is chosen per block, right
in the Layout Builder editor, as described below.

## Where it lives in the admin menu

The module adds no admin page of its own. You use it from within the Layout Builder
editor, on each block you want to animate.

## How to use it

1. Make sure core's **Layout Builder** and the **AOS** module are enabled and in
   use.
2. In the Layout Builder editor, add or configure a block.
3. On the block's configuration form, choose the **animation** you want the block to
   use as it scrolls into view.
4. Save the block and the layout. On the front end, the block animates in on scroll,
   driven by the AOS library.
