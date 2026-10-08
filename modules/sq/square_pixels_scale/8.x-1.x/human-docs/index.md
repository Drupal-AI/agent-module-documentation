# Square Pixels Scale — manual setup guide

**Square Pixels Scale** (`square_pixels_scale`) adds an **image effect** you can
use inside Drupal's image styles. Instead of scaling to a fixed width or height, it
scales an image to a target **total number of pixels** — its area, calculated as
width × height — while preserving the original aspect ratio.

Why would you want that? Because when you display images of very different aspect
ratios together — think a row of logos, some wide, some tall, some square — scaling
them all to the same width (or height) makes their *apparent* sizes wildly
inconsistent. Scaling by area instead gives them more visually similar sizes, so a
grid of mixed‑shape images looks balanced. The effect approximates your target
area: the result will usually land slightly above or below the exact number, which
is expected.

This is a media / image‑style feature. It produces image derivatives and has no
content or access role of its own, and it needs no special requirements. It works
across Drupal 8 through 11. Like all image‑style effects, you configure it *within*
an image style rather than on a module settings page.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install and enable the module.
2. [Configuration](configuration/index.md) — add the effect to an image style and
   set its options.

## How to use it

Add the **Square Pixels Scale** effect to an image style at **Configuration →
Media → Image styles**, set your target area and options, then use that image style
wherever you display the images (an image field formatter, a view, and so on). See
[Configuration](configuration/index.md) for the field‑by‑field details.
