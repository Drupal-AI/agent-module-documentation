# Block Animate — manual setup guide

**Block Animate** (`block_animate`) bundles [Animate.css](https://animate.style/)
and exposes its named entrance animations as options right on the block
configuration form. A site builder can make a block fade or slide in without writing
any CSS or template overrides.

Normally, using Animate.css in Drupal means adding the library, attaching it to the
right pages, and getting the animation class names onto the right markup — which for
a block means a preprocess function or a template override. This module does that
plumbing for you: you pick an animation (`fadeInUp`, `bounceIn`, `slideInLeft`, and
several dozen more) in the block's settings, it's stored with the block, and the
class is applied when the block renders.

The `animate.min.css` stylesheet ships **inside the module**, so there's no external
CDN request and no separate library download — no third-party origin is added to
your pages. Because the animation choice is stored in block config, it also travels
with your configuration export.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no separate settings page. You pick the animation per block on the block's
own configuration form under **Structure → Block layout**
(`/admin/structure/block`) — edit a placed block and choose the animation.

## How to use it

1. Go to **Structure → Block layout** and edit (or place) a block.
2. In the block's configuration, choose the Animate.css animation you want.
3. Save the block.

The block will play that entrance animation when it renders. To remove the effect
later, edit the block and clear the animation choice.

### Three things worth knowing

- **The stylesheet loads on every page that contains an animated block**, so a
  single decorative animation costs every visitor on that page the Animate.css
  download.
- **Entrance animations fire on page load, not on scroll.** A block below the fold
  will have finished animating before a visitor scrolls to it — the module supplies
  the classes, not the "animate when it comes into view" logic.
- **Check reduced-motion.** Recent Animate.css versions respect the visitor's
  `prefers-reduced-motion` setting; confirm the bundled copy does so before shipping
  motion to everyone.
