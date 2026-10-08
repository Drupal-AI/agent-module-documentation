# Y Layout Builder — Hero — manual setup guide

**Y Layout Builder — Hero** (`lb_hero`) provides the full-width "hero banner"
block type for YMCA Layout Builder pages: the band at the top of a location or
programme page, with background media, a heading, supporting text, and usually a
call to action overlaid on an image. It is part of the YMCA Website Services
family of Layout Builder components (the `y_lb` package).

Two things matter more for a hero than for almost any other component. It is
usually the page's **largest contentful paint**, which makes its responsive image
configuration the highest-value performance lever you have — preloading the hero
image is often worth doing. And **text over a photograph is a contrast problem
the design has to solve structurally** (an overlay, a scrim, or a constrained
text area), because the image is the thing editors change; legibility over one
photo tells you nothing about the next. On a multi-location site this compounds:
dozens of branches each choosing their own hero image means the design has to
hold for images nobody reviewed.

This module is designed to be used **with the YMCA's Website Services
distribution**. Its hard dependency on **Y Layout Builder (`y_lb`)** means it is
not a standalone install — see [Installation](installation/index.md) for the
important note about where `y_lb` actually comes from.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, the Composer/Drush
   commands, and the `y_lb` dependency caveat.

This module has **no configuration page** of its own. You place and edit the hero
block from within the Layout Builder interface, described below.

## Where it lives in the admin menu

There is no dedicated settings page (`configure` is null). Everything happens in
**Layout Builder**: edit a page's layout, add the Hero block near the top, and
set its background media, heading, description, and call-to-action link. For
general Layout Builder mechanics, see Drupal core's Layout Builder.

## How to use it

1. Enable the module (and the rest of the YMCA Website Services / `y_lb` stack it
   belongs to).
2. Edit a page's **Layout** (Layout Builder) and **add** the Hero block to the
   first section.
3. Choose the background image/media, and enter the heading, supporting text, and
   call-to-action.
4. Because the hero is typically the largest image on the page, pick a properly
   sized responsive image and consider preloading it; make sure your overlay or
   scrim keeps the text legible over whatever image an editor might choose.
5. Save the layout.
